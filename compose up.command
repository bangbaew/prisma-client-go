cd "$(dirname "$BASH_SOURCE")" || {
    echo "Error getting script directory" >&2
    exit 1
}
docker-compose -f docker-compose.dev.yml up -d