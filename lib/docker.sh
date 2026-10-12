#!/usr/bin/env bash

UH_DOCKER_CONFIG="${UH_DOCKER_CONFIG:-/etc/docker/daemon.json}"
UH_DOCKER_BACKUP="${UH_DOCKER_BACKUP:-${UH_DOCKER_CONFIG}.uhelper.bak}"

uh_docker_validate_daemon_config() {
    [[ -f "$UH_DOCKER_CONFIG" ]] || return 0
    command -v jq >/dev/null 2>&1 || { uh_log WARN "jq is required to validate Docker daemon configuration"; return 0; }
    jq empty "$UH_DOCKER_CONFIG" >/dev/null 2>&1
}

uh_docker_backup_config() {
    [[ -f "$UH_DOCKER_CONFIG" ]] || return 0
    uh_run cp -p "$UH_DOCKER_CONFIG" "$UH_DOCKER_BACKUP"
}

uh_docker_restore_config() {
    [[ -f "$UH_DOCKER_BACKUP" ]] || return 0
    uh_run cp -p "$UH_DOCKER_BACKUP" "$UH_DOCKER_CONFIG"
    uh_log WARN "Docker daemon configuration rolled back"
}

uh_docker_pull_test() {
    local image="${1:-hello-world:latest}"
    command -v docker >/dev/null 2>&1 || { uh_log WARN "docker is not installed; pull test skipped"; return 0; }
    [[ "${UH_DRY_RUN:-0}" == "1" ]] && { uh_log INFO "dry-run Docker pull test" "$(uh_log_field image "$image")"; return 0; }
    docker pull "$image" >/dev/null
}

uh_docker_systemd_health() {
    command -v systemctl >/dev/null 2>&1 || return 0
    systemctl is-active --quiet docker
}

uh_docker_apply_mirrors() {
    local mirrors_json="$1"
    uh_is_root_or_dry_run || uh_fail "Docker mirror configuration requires root privileges" || return 1
    uh_docker_backup_config || return 1
    if [[ "${UH_DRY_RUN:-0}" == "1" ]]; then
        uh_log INFO "dry-run Docker daemon update" "$(uh_log_field mirrors "$mirrors_json")"
        return 0
    fi
    mkdir -p "$(dirname "$UH_DOCKER_CONFIG")" || return 1
    printf '{"registry-mirrors":%s}\n' "$mirrors_json" >"$UH_DOCKER_CONFIG" || return 1
    uh_docker_validate_daemon_config || { uh_docker_restore_config; return 1; }
    if command -v systemctl >/dev/null 2>&1; then
        systemctl restart docker || { uh_docker_restore_config; systemctl restart docker || true; return 1; }
        uh_docker_systemd_health || { uh_docker_restore_config; systemctl restart docker || true; return 1; }
    fi
    uh_docker_pull_test "hello-world:latest"
}
