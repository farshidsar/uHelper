#!/usr/bin/env bash

UH_MIRROR_CATALOG="${UH_MIRROR_CATALOG:-${XDG_STATE_HOME:-/var/lib}/uhelper/mirrors.jsonl}"
UH_MIRROR_MAX_AGE="${UH_MIRROR_MAX_AGE:-604800}"

uh_mirror_catalog_init() {
    if [[ "${UH_DRY_RUN:-0}" == "1" ]]; then return 0; fi
    mkdir -p "$(dirname "$UH_MIRROR_CATALOG")" || return 1
    touch "$UH_MIRROR_CATALOG"
}

uh_mirror_catalog_add() {
    local url="$1" region="$2" package_type="$3" tls="$4" checked_at
    checked_at="$(date -u +%s)"
    uh_mirror_catalog_init || return 1
    printf '{"url":"%s","region":"%s","package_type":"%s","tls_valid":%s,"checked_at":%s}\n' \
        "$(uh_json_escape "$url")" "$(uh_json_escape "$region")" \
        "$(uh_json_escape "$package_type")" "$tls" "$checked_at" >>"$UH_MIRROR_CATALOG"
}

uh_mirror_tls_valid() {
    local url="$1"
    [[ "$url" == https://* ]] || return 1
    command -v curl >/dev/null 2>&1 || return 1
    curl --fail --silent --show-error --head --max-time "${UH_MIRROR_TIMEOUT:-8}" "$url" >/dev/null
}

uh_mirror_check() {
    local url="$1" region="${2:-unknown}" package_type="${3:-apt}" status=0 tls=false
    [[ "$url" == https://* ]] && tls=true
    if [[ "${UH_DRY_RUN:-0}" == "1" ]]; then
        uh_log INFO "dry-run mirror check" "$(uh_log_field url "$url")"
        return 0
    fi
    if ! curl --fail --silent --show-error --location --max-time "${UH_MIRROR_TIMEOUT:-8}" \
        --output /dev/null "$url"; then status=1; fi
    if [[ "$tls" == true ]] && ! uh_mirror_tls_valid "$url"; then status=1; fi
    if (( status == 0 )); then
        uh_mirror_catalog_add "$url" "$region" "$package_type" "$tls"
        uh_log INFO "mirror is healthy" "$(uh_log_field url "$url")$(uh_log_field package_type "$package_type")"
    else
        uh_log WARN "mirror is stale or unreachable" "$(uh_log_field url "$url")"
    fi
    return "$status"
}

uh_mirror_prune_stale() {
    [[ -f "$UH_MIRROR_CATALOG" ]] || return 0
    [[ "${UH_DRY_RUN:-0}" == "1" ]] && { uh_log INFO "dry-run mirror prune"; return 0; }
    local now line checked_at
    now="$(date -u +%s)"
    local tmp="${UH_MIRROR_CATALOG}.tmp"
    : >"$tmp" || return 1
    while IFS= read -r line; do
        checked_at="$(printf '%s\n' "$line" | sed -n 's/.*"checked_at":\([0-9][0-9]*\).*/\1/p')"
        if [[ -n "$checked_at" ]] && (( now - checked_at <= UH_MIRROR_MAX_AGE )); then
            printf '%s\n' "$line" >>"$tmp"
        fi
    done <"$UH_MIRROR_CATALOG"
    mv "$tmp" "$UH_MIRROR_CATALOG"
}
