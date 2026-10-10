#!/bin/sh

set -eu

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
OUTPUT="$ROOT/output"

TEMPLATE_AUTO="$ROOT/auto"
TEMPLATE_CONFIG="$ROOT/config"

usage() {
    echo "Usage: $0 {all|xfce|lxqt|gnome|kde|cinnamon|mate|cosmic|minimal}"
    exit 1
}

build_variant() {
    VARIANT="$1"

    case "$VARIANT" in
        xfce)
            DESKTOP_NAME="Xfce"
            DESKTOP_PACKAGES="task-xfce-desktop"
            ;;

        lxqt)
            DESKTOP_NAME="LXQt"
            DESKTOP_PACKAGES="task-lxqt-desktop"
            ;;

        gnome)
            DESKTOP_NAME="GNOME"
            DESKTOP_PACKAGES="task-gnome-desktop"
            ;;

        kde)
            DESKTOP_NAME="KDE Plasma"
            DESKTOP_PACKAGES="task-kde-desktop"
            ;;

        cinnamon)
            DESKTOP_NAME="Cinnamon"
            DESKTOP_PACKAGES="task-cinnamon-desktop"
            ;;

        mate)
            DESKTOP_NAME="MATE"
            DESKTOP_PACKAGES="task-mate-desktop"
            ;;

        cosmic)
            DESKTOP_NAME="COSMIC"
            DESKTOP_PACKAGES="cosmic-desktop cosmic-session cosmic-greeter"
            ;;

        minimal)
            DESKTOP_NAME="Minimal"
            DESKTOP_PACKAGES=""
            ;;

        *)
            echo "ERROR: Unknown variant: $VARIANT"
            usage
            ;;
    esac

    VARIANT_DIR="$ROOT/livebian-$VARIANT"
    VARIANT_AUTO="$VARIANT_DIR/auto"
    VARIANT_CONFIG="$VARIANT_DIR/config"
    VARIANT_PACKAGES="$VARIANT_CONFIG/package-lists/livebian-desktop.list.chroot"

    ISO_NAME="livebian-${VARIANT}-amd64.hybrid.iso"

    echo
    echo "=============================================="
    echo "        LIVEBIAN ${DESKTOP_NAME}"
    echo "=============================================="
    echo "Build directory:"
    echo "  $VARIANT_DIR"
    echo
    echo "Output:"
    echo "  $OUTPUT/$ISO_NAME"
    echo "=============================================="
    echo

    mkdir -p "$OUTPUT"

    #
    # Create an independent copy of the master project.
    #
    if [ ! -d "$VARIANT_DIR" ]; then
        echo "==> Creating ${VARIANT} build tree..."

        mkdir -p "$VARIANT_DIR"

        cp -a "$TEMPLATE_AUTO" "$VARIANT_DIR/"
        cp -a "$TEMPLATE_CONFIG" "$VARIANT_DIR/"
    else
        echo "==> Existing ${VARIANT} build tree found."
    fi

    #
    # Make sure the package-list directory exists.
    #
    sudo mkdir -p "$VARIANT_CONFIG/package-lists"

    #
    # Configure desktop package list.
    #
    echo "==> Configuring ${DESKTOP_NAME} packages..."

    sudo sh -c "cat > '$VARIANT_PACKAGES'" <<EOF
# Livebian ${DESKTOP_NAME} desktop variant

live-boot
sudo
network-manager
${DESKTOP_PACKAGES}
EOF

    #
    # Enter the independent build tree.
    #
    cd "$VARIANT_DIR"

    #
    # Remove old generated build state.
    #
    echo "==> Cleaning ${DESKTOP_NAME} build tree..."

    sudo lb clean || true

    #
    # Configure this variant independently.
    #
    echo "==> Configuring live-build..."

    sudo lb config noauto \
        --distribution trixie \
        --architectures amd64 \
        --archive-areas "main contrib non-free non-free-firmware" \
        --binary-images iso-hybrid \
        --bootappend-live "boot=live components"

    #
    # Build.
    #
    echo
    echo "==> BUILDING LIVEBIAN ${DESKTOP_NAME}"
    echo

    sudo lb build

    #
    # Move ISO to the central output directory.
    #
    if [ -f "$VARIANT_DIR/livebian-amd64.hybrid.iso" ]; then

        sudo mv \
            "$VARIANT_DIR/livebian-amd64.hybrid.iso" \
            "$OUTPUT/$ISO_NAME"

        sudo chown "$(id -u):$(id -g)" "$OUTPUT/$ISO_NAME"

    else
        echo
        echo "ERROR: ISO was not produced:"
        echo "  $VARIANT_DIR/livebian-amd64.hybrid.iso"
        exit 1
    fi

    echo
    echo "=============================================="
    echo "       ${DESKTOP_NAME} BUILD COMPLETE"
    echo "=============================================="
    echo
}

case "${1:-}" in

    all)
        echo
        echo "=============================================="
        echo "       BUILDING ALL LIVEBIAN VARIANTS"
        echo "=============================================="
        echo

        for variant in \
            xfce \
            lxqt \
            gnome \
            kde \
            cinnamon \
            mate \
            cosmic \
            minimal
        do
            build_variant "$variant"
        done

        echo
        echo "=============================================="
        echo "       ALL VARIANTS COMPLETE"
        echo "=============================================="
        echo

        ls -lh "$OUTPUT"/livebian-*.hybrid.iso

        ;;

    xfce|lxqt|gnome|kde|cinnamon|mate|cosmic|minimal)
        build_variant "$1"
        ;;

    *)
        usage
        ;;

esac
