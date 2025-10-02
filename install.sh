#!/usr/bin/env bash
set -e

echo "🚀 Starting Flood Monitor application installer..."

# Get the absolute path of the directory where this script is located
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "Found project directory at: $SCRIPT_DIR"

# Define the full path to the launcher script
LAUNCHER_PATH="$SCRIPT_DIR/launch_dashboard.sh"

# Define the source template and final desktop file name
TEMPLATE_FILE="$SCRIPT_DIR/FloodMonitoring.desktop.template"
DESKTOP_FILE="$SCRIPT_DIR/FloodMonitoring.desktop"

# --- Create the .desktop file from the template ---
echo "⚙️  Generating .desktop file with correct path..."
# Use sed to replace the placeholder with the actual path
# The use of '|' as a separator avoids issues with '/' in paths
sed "s|%%EXEC_PATH%%|$LAUNCHER_PATH|" "$TEMPLATE_FILE" > "$DESKTOP_FILE"

# --- Make scripts executable ---
echo "🔧 Setting script permissions..."
chmod +x "$LAUNCHER_PATH"
chmod +x "$SCRIPT_DIR/run_conda.sh"

# --- Install the .desktop file for the current user ---
INSTALL_DIR="$HOME/.local/share/applications"
echo "✅ Installing application shortcut to: $INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
cp "$DESKTOP_FILE" "$INSTALL_DIR/"

# --- Final Instructions ---
echo "✅ Installation Complete!"
echo "You can now find 'Flood Monitor' in your application menu."
echo "You can also right-click it in the menu to add it to your desktop."
