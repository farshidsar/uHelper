#!/usr/bin/env bash

uh_log_init() {
    UH_LOG_FORMAT="${UH_LOG_FORMAT:-text}"
    UH_LOG_FILE="${UH_LOG_FILE:-}"
    UH_OPERATION_ID="${UH_OPERATION_ID:-uh-$(date -u +%Y%m%dT%H%M%SZ)-$$}"
}

uh_json_escape() {
    local value="${1-}"
    value=${value//\\/\\\\}
    value=${value//\"/\\\"}
    value=${value//$'\n'/\\n}
    value=${value//$'\r'/\\r}
    value=${value//$'\t'/\\t}
    printf '%s' "$value"
}

uh_log() {
    local level="${1:-INFO}" message="${2:-}" fields="${3:-}"
    local timestamp line
    timestamp="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    if [[ "${UH_LOG_FORMAT:-text}" == "json" ]]; then
        line=$(printf '{"timestamp":"%s","level":"%s","operation_id":"%s","message":"%s"%s}' \
            "$timestamp" "$(uh_json_escape "$level")" "$(uh_json_escape "${UH_OPERATION_ID:-unknown}")" \
            "$(uh_json_escape "$message")" "$fields")
    else
        line="[$timestamp] [$level] [${UH_OPERATION_ID:-unknown}] $message"
    fi
    printf '%s\n' "$line" >&2
    if [[ -n "${UH_LOG_FILE:-}" ]]; then
        printf '%s\n' "$line" >>"$UH_LOG_FILE"
    fi
}

uh_log_field() {
    printf ',\"%s\":\"%s\"' "$(uh_json_escape "$1")" "$(uh_json_escape "${2-}")"
}

uh_fail() {
    uh_log ERROR "$1" "${2:-}"
    return 1
}
