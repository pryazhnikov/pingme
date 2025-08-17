#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BELL_FILE="$SCRIPT_DIR/assets/medium_bell_wake_plus_full.mp3"
BELL_URL="https://plumvillage.org/wp-content/uploads/2020/04/medium_bell_wake_plus_full.mp3"

download() {
    if [ ! -f "$BELL_FILE" ]; then
        echo "Downloading bell sound file..."
        curl -L "$BELL_URL" -o "$BELL_FILE"
        echo "Bell sound file downloaded to $BELL_FILE"
    else
        echo "Bell sound file already exists at $BELL_FILE"
    fi
}

play() {
    if [ ! -f "$BELL_FILE" ]; then
        echo "Bell sound file not found. Run '$0 download' first."
        exit 1
    fi
    
    if ! command -v afplay >/dev/null 2>&1; then
        echo "Error: afplay not found. This script requires macOS."
        exit 1
    fi
    
    echo "Playing bell sound..."
    afplay "$BELL_FILE"
    echo "Done!"
}

case "${1:-}" in
    download)
        download
        ;;
    play)
        play
        ;;
    *)
        echo "Usage: $0 {download|play}"
        exit 1
        ;;
esac

