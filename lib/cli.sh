#!/usr/bin/env bash

uh_usage() {
    cat <<'EOF'
Usage: uHelper.sh [OPTIONS]
  --check-mirrors URL...   Check HTTPS/package mirrors and update catalog
  --docker-mirrors JSON    Validate/apply Docker registry mirrors
  --prune-mirrors          Remove stale catalog entries
  --dry-run                Log actions without changing the system
  --non-interactive        Never prompt; required for automation
  --log-format FORMAT      text (default) or json
  --operation-id ID        Set a correlation/operation ID
  --help                   Show this help
EOF
}

uh_cli_main() {
    local action="" docker_mirrors="" urls=()
    while (($#)); do
        case "$1" in
            --check-mirrors) action=check; shift; while (($#)) && [[ "$1" != --* ]]; do urls+=("$1"); shift; done; continue ;;
            --docker-mirrors) action=docker; docker_mirrors="${2:-}"; shift 2; continue ;;
            --prune-mirrors) action=prune; shift; continue ;;
            --dry-run) UH_DRY_RUN=1; shift; continue ;;
            --non-interactive) UH_NON_INTERACTIVE=1; shift; continue ;;
            --log-format) UH_LOG_FORMAT="${2:-text}"; shift 2; continue ;;
            --operation-id) UH_OPERATION_ID="${2:-}"; shift 2; continue ;;
            --help|-h) uh_usage; return 0 ;;
            *) uh_usage >&2; return 2 ;;
        esac
    done
    uh_log_init
    [[ -n "$action" ]] || { uh_usage; return 0; }
    uh_require_supported_platform || return 1
    case "$action" in
        check)
            ((${#urls[@]})) || uh_fail "--check-mirrors requires at least one URL" || return 2
            local url; for url in "${urls[@]}"; do uh_mirror_check "$url" "${UH_REGION:-unknown}" "${UH_PACKAGE_TYPE:-apt}" || true; done
            uh_mirror_prune_stale
            ;;
        prune) uh_mirror_prune_stale ;;
        docker)
            [[ "$docker_mirrors" == \[*\] ]] || uh_fail "--docker-mirrors requires a JSON array" || return 2
            uh_docker_apply_mirrors "$docker_mirrors"
            ;;
    esac
}
