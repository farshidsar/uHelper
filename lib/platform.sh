#!/usr/bin/env bash

uh_detect_platform() {
    UH_PLATFORM="unknown"
    UH_PACKAGE_MANAGER=""
    if [[ -r /etc/os-release ]]; then
        # shellcheck disable=SC1091
        . /etc/os-release
        UH_PLATFORM="${ID:-unknown}"
    fi
    if command -v apt-get >/dev/null 2>&1; then
        UH_PACKAGE_MANAGER=apt
    elif command -v dnf >/dev/null 2>&1; then
        UH_PACKAGE_MANAGER=dnf
    elif command -v yum >/dev/null 2>&1; then
        UH_PACKAGE_MANAGER=yum
    elif command -v apk >/dev/null 2>&1; then
        UH_PACKAGE_MANAGER=apk
    fi
    uh_log INFO "platform detected" "$(uh_log_field platform "$UH_PLATFORM")$(uh_log_field package_manager "$UH_PACKAGE_MANAGER")"
}

uh_require_supported_platform() {
    uh_detect_platform
    case "$UH_PLATFORM" in
        ubuntu|debian) return 0 ;;
        fedora|rhel|centos|alpine)
            uh_fail "platform is documented but not fully supported: $UH_PLATFORM"
            ;;
        *)
            uh_fail "unsupported platform: $UH_PLATFORM"
            ;;
    esac
}

uh_is_root_or_dry_run() {
    [[ "${UH_DRY_RUN:-0}" == "1" || "${EUID:-$(id -u)}" -eq 0 ]]
}

uh_run() {
    if [[ "${UH_DRY_RUN:-0}" == "1" ]]; then
        uh_log INFO "dry-run command" "$(uh_log_field command "$*")"
        return 0
    fi
    "$@"
}
