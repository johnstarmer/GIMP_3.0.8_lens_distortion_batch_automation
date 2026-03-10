#!/usr/bin/env bash
# =============================================================
# run_gimp_lens_distortion.sh
# Desktop launcher for GIMP 3.0+ batch lens-distortion
#
# SETUP (one time only):
#   chmod +x ~/Desktop/run_gimp_lens_distortion.sh
#
# RUN:
#   Open Terminal and type:
#     ~/Desktop/run_gimp_lens_distortion.sh
# =============================================================

# ── Paths ────────────────────────────────────────────────────
INPUT_DIR="/Users/johnstarmer/Desktop/D_input"
OUTPUT_DIR="/Users/johnstarmer/Desktop/D_output"

# Path to the Script-Fu file (must also be on the Desktop)
SCM_SCRIPT="$HOME/Desktop/batch-lens-distortion.scm"

# GIMP 3.0 console binary
# Adjust this path if GIMP is installed somewhere else, e.g.:
#   /Applications/GIMP-3.0.app/Contents/MacOS/gimp-console-3.0
GIMP_CONSOLE="/Applications/GIMP.app/Contents/MacOS/gimp-console-3.0"

# ── Lens Distortion Parameters ───────────────────────────────
# All values range from -100 to 100.
#
#  BARREL   – Main barrel/pincushion correction
#  EDGE     – Edge correction
#  ZOOM     – Zoom in/out (use positive value to hide black borders)
#  SHIFT_X  – Horizontal optical-centre shift
#  SHIFT_Y  – Vertical optical-centre shift
#  BRIGHTEN – Vignetting compensation (active only if BARREL or EDGE != 0)
BARREL="0"
EDGE="53"
ZOOM="48"
SHIFT_X="0"
SHIFT_Y="5"
BRIGHTEN="0"

# ── Pre-flight checks ────────────────────────────────────────
if [ ! -f "$GIMP_CONSOLE" ]; then
  echo "ERROR: GIMP console binary not found at:"
  echo "  $GIMP_CONSOLE"
  echo "Edit the GIMP_CONSOLE variable in this script to match your installation."
  exit 1
fi

if [ ! -f "$SCM_SCRIPT" ]; then
  echo "ERROR: Script-Fu file not found at:"
  echo "  $SCM_SCRIPT"
  echo "Make sure batch-lens-distortion.scm is on your Desktop."
  exit 1
fi

if [ ! -d "$INPUT_DIR" ]; then
  echo "ERROR: Input directory not found: $INPUT_DIR"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

# ── Find all JPG files (case-insensitive) ────────────────────
# Compatible with macOS default /bin/sh and bash 3.2
# Uses a while-read loop instead of mapfile (bash 4+ only)
JPG_FILES=()
while IFS= read -r -d '' filepath; do
  JPG_FILES+=("$filepath")
done < <(find "$INPUT_DIR" -maxdepth 1 \( -iname "*.jpg" -o -iname "*.jpeg" \) -print0 | sort -z)

TOTAL=${#JPG_FILES[@]}

if [ "$TOTAL" -eq 0 ]; then
  echo "No JPG files found in: $INPUT_DIR"
  exit 1
fi

echo "========================================"
echo "  GIMP 3.0 Batch Lens Distortion"
echo "========================================"
echo "  Input    : $INPUT_DIR"
echo "  Output   : $OUTPUT_DIR"
echo "  Barrel   : $BARREL   Edge    : $EDGE"
echo "  Zoom     : $ZOOM     Shift X : $SHIFT_X"
echo "  Shift Y  : $SHIFT_Y  Brighten: $BRIGHTEN"
echo "  Files    : $TOTAL JPG(s) found"
echo "========================================"
echo ""

COUNT=0
ERRORS=0

for INPUT_PATH in "${JPG_FILES[@]}"; do

  FILENAME=$(basename "$INPUT_PATH")
  OUTPUT_PATH="$OUTPUT_DIR/$FILENAME"
  COUNT=$((COUNT + 1))

  echo "[$COUNT/$TOTAL] Processing: $FILENAME"

  "$GIMP_CONSOLE" \
    --no-interface \
    --batch-interpreter=plug-in-script-fu-eval \
    --batch="(begin
                (load \"$SCM_SCRIPT\")
                (process-one-image
                  \"$INPUT_PATH\"
                  \"$OUTPUT_PATH\"
                  $BARREL $EDGE $ZOOM $SHIFT_X $SHIFT_Y $BRIGHTEN))" \
    --batch="(gimp-quit 0)"
  GIMP_EXIT=$?

  if [ $GIMP_EXIT -eq 0 ]; then
    echo "  Saved -> $OUTPUT_PATH"
  else
    echo "  ERROR: GIMP returned exit code $GIMP_EXIT for $FILENAME — check output above for details"
    ERRORS=$((ERRORS + 1))
  fi

done

echo ""
echo "========================================"
echo "  Done. $COUNT file(s) processed."
if [ "$ERRORS" -gt 0 ]; then
  echo "  WARNING: $ERRORS file(s) may have had errors."
fi
echo "  Output folder: $OUTPUT_DIR"
echo "========================================"
