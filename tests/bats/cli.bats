#!/usr/bin/env bats

setup() {
    ROOT="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
    TMP="$(mktemp -d)"
    export UH_MIRROR_CATALOG="$TMP/mirrors.jsonl"
    export UH_LOG_FORMAT=json
    mkdir -p "$TMP/bin"
    printf '#!/usr/bin/env bash\nexit 0\n' >"$TMP/bin/curl"
    chmod +x "$TMP/bin/curl"
}

teardown() { rm -rf "$TMP"; }

@test "help is non-interactive" {
    run "$ROOT/uHelper.sh" --help
    [ "$status" -eq 0 ]
    [[ "$output" == *"--dry-run"* ]]
}

@test "dry-run mirror checks emit operation ids" {
    run "$ROOT/uHelper.sh" --dry-run --non-interactive --check-mirrors https://mirror.example/ubuntu/
    [ "$status" -eq 0 ]
    [[ "$output" == *"operation_id"* ]]
}

@test "mocked mirror checks write the catalog schema" {
    PATH="$TMP/bin:$PATH" run "$ROOT/uHelper.sh" --non-interactive \
        --check-mirrors https://mirror.example/ubuntu/
    [ "$status" -eq 0 ]
    [ -s "$UH_MIRROR_CATALOG" ]
    grep -q '"package_type":"apt"' "$UH_MIRROR_CATALOG"
    grep -q '"tls_valid":true' "$UH_MIRROR_CATALOG"
}
