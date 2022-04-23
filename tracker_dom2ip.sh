#!/usr/bin/env bash

# RESOLVE TRACKER URLS INTO IP ADDRESSES

WORKING_DIR="$(pwd)/tracker_dom2url"
GIT_TRACKER_TLDS='https://raw.githubusercontent.com/whoiscoos/adlists/master/tracker_tld_master'

GIT_TLD="$WORKING_DIR/tmp_tld_list"
TMP_SUBDOM="$WORKING_DIR/tmp_sublist"

MASTER_SUBDOM="$WORKING_DIR/tracker_subdomain_master"
MASTER_IPADDR="$WORKING_DIR/tracker_ipaddr_master"

function setup_env(){
    if [[ -d "$WORKING_DIR" ]]; then
        rm -rf "$WORKING_DIR"
    fi
    mkdir -p "$WORKING_DIR"
    wget -q -O "$GIT_TLD" "$GIT_TRACKER_TLDS"
}

#function cleanup_env(){
#    if [[ -f "$TMP_URL" ]]; then
#        rm -f "$TMP_URL"
#    fi
#
#    if [[ -f "$TMP_IP" ]]; then
#        rm -f "$TMP_IP"
#    fi
#}

function get_subdomains() {
    if [[ -f "$GIT_TLD" ]]; then
        while read -r url; do
            findomain --external-subdomains -q -t "$url" | tee -a "$TMP_SUBDOM"
            echo "sleeping for 10 seconds..." && sleep 10
        done < "$GIT_TLD"
    fi

    # touch output file
    #if [[ ! -f "$MASTER_SUBDOM" ]]; then
    #    touch "$MASTER_SUBDOM"
    #fi

    # sanitize output
    #echo "$(cat $TMP_SUBDOM | cut -f1 -d ',' | sed '/^[[:space:]]*$/d' | tr -d '[:blank:]' | sort | uniq)" > "$MASTER_SUBDOM"
}

# setup
setup_env
get_subdomains

#SANITIZE_IP="$(cat $TMP_OUT | cut -f2- -d ',' | sed '/^[[:space:]]*$/d' | tr -d '[:blank:]' | sort | uniq | sed '/0.0.0.0/d')"
#echo "$SANITIZE_IP" > "$MASTER_IP"
# cleanup
#cleanup_env
