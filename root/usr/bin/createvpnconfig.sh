#!/command/with-contenv bash

[[ "${DEBUG,,}" == trace* ]] && set -x

# --- 1. Variable Alignment Mapping ---
# Maps your ENV vars to internal standards used in upstream-style logic
S_COUNTRIES="${COUNTRY:-${SERVER_COUNTRIES:-US}}"
S_GROUP="${GROUP:-${SERVER_GROUP:-Standard VPN Servers}}"
S_CITIES="${CITY:-$SERVER_CITIES}"
S_TOP="${RANDOM_TOP:-0}"

# --- 2. Globals & Metadata ---
nvcountries=$(jq -c '.[]' < "/etc/nordvpn/countries.json")
nvgroups=$(jq -c '.[]' < "/etc/nordvpn/groups.json")
nvtechnologies=$(jq -c '.[]' < "/etc/nordvpn/technologies.json")

numericregex="^[0-9]+$"
ovpntemplatefile="/etc/nordvpn/template.ovpn"
ovpnfile="/tmp/nordvpn.ovpn"

SELECTED_HOSTNAME=""
SELECTED_IP=""
SELECTED_NAME=""

# --- 3. Functions (Modularized for Step 2) ---

get_id() {
    local type=$1 # countries, groups, or technologies
    local input=$2
    local json_data

    case $type in
        countries) json_data="$nvcountries" ;;
        groups)    json_data="$nvgroups" ;;
        tech)      json_data="$nvtechnologies" ;;
    esac

    if [[ "$input" =~ $numericregex ]]; then
        echo "$json_data" | jq -r --argjson ID "$input" 'select(.id == $ID) | .id'
    else
        # Try name, then code/identifier
        local res=$(echo "$json_data" | jq -r --arg N "$input" 'select(.name == $N or .code == $N or .identifier == $N) | .id' | head -n 1)
        echo "$res"
    fi
}

use_manual_override() {
    local data="$1"
    [[ "$data" != *";"* ]] && return 1

    IFS=';' read -ra ADDR <<< "$data"
    if [[ -n "${ADDR[2]}" && "${ADDR[2]}" =~ ^[a-z]{2}[0-9]+$ ]]; then
        echo "Manual override: ${ADDR[2]}"
        SELECTED_HOSTNAME="${ADDR[2]}.nordvpn.com"
        SELECTED_NAME="Manual Selection (${ADDR[0]})"
        SELECTED_IP=$(host -t A "$SELECTED_HOSTNAME" | awk '/has address/ { print $4 }' | head -n 1)
        return 0
    fi
    return 1
}

discover_best_server() {
    echo "Querying NordVPN API (Standard Alignment)..."
    local city_filter=""

    # Smart City Filter parsing
    if [[ "$S_CITIES" == *";"* ]]; then
        IFS=';' read -ra ADDR <<< "$S_CITIES"
        for p in "${ADDR[@]}"; do
            [[ "$p" =~ $numericregex ]] && city_filter="${city_filter}&filters\[city_id\]=${p}"
        done
    fi

    local cid=$(get_id countries "$S_COUNTRIES")
    local gid=$(get_id groups "$S_GROUP")
    local tid=$(get_id tech "$TECHNOLOGY")

    local api_url="https://api.nordvpn.com/v1/servers/recommendations?filters\[country_id\]=$cid&filters\[group_id\]=$gid&filters\[servers_technologies\]\[identifier\]=$tid$city_filter&limit=$((S_TOP > 20 ? S_TOP : 20))"

    local resp=$(curl -s "$api_url")
    [[ $(echo "$resp" | jq '. | length') -eq 0 ]] && { echo "No servers found."; exit 1; }

    # Sort by load
    local pool=$(echo "$resp" | jq -c 'sort_by(.load) | .[]')

    # Handle Random Shuffling
    if [[ $S_TOP -ne 0 ]]; then
        local plen=$(echo "$resp" | jq '. | length')
        if [[ $S_TOP -lt $plen ]]; then
            pool="$(echo "$pool" | head -n "$S_TOP" | shuf)$(echo "$pool" | tail -n +$((S_TOP + 1)))"
        else
            pool=$(echo "$pool" | shuf)
        fi
    fi

    SELECTED_HOSTNAME=$(echo "$pool" | jq -r '.hostname' | head -n 1)
    SELECTED_IP=$(echo "$pool" | jq -r '.station' | head -n 1)
    SELECTED_NAME=$(echo "$pool" | jq -r '.name' | head -n 1)
}

apply_config() {
    local proto=$([[ "$TECHNOLOGY" == "openvpn_tcp" ]] && echo "tcp" || echo "udp")
    local port=$([[ "$proto" == "tcp" ]] && echo "443" || echo "1194")

    echo "Selected: $SELECTED_NAME ($SELECTED_HOSTNAME) via $proto/$port"
    cp "$ovpntemplatefile" "$ovpnfile"
    sed -i "s/__IP__/$SELECTED_IP/g" "$ovpnfile"; sed -i "s/__X509_NAME__/$SELECTED_HOSTNAME/g" "$ovpnfile"
    sed -i "s/__PROTOCOL__/$proto/g" "$ovpnfile"; sed -i "s/__PORT__/$port/g" "$ovpnfile"
}

# --- 4. Execution ---
if [[ -n "$S_CITIES" ]] && use_manual_override "$S_CITIES"; then
    echo "Framework: Using manual override path."
else
    discover_best_server
fi

apply_config
