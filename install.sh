#!/usr/bin/env bash
set -e

echo "🚀 Starting Flood Monitor application installer..."

# Get the absolute path of the directory where this script is located
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "Found project directory at: $SCRIPT_DIR"

# Define the full path to the launcher script and the final .desktop file
LAUNCHER_PATH="$SCRIPT_DIR/launch.sh"
DESKTOP_FILE_NAME="FloodMonitoring.desktop"
INSTALL_DIR="$HOME/.local/share/applications"
FINAL_DESKTOP_PATH="$INSTALL_DIR/$DESKTOP_FILE_NAME"

# --- Make other scripts executable first ---
echo "🔧 Setting script permissions..."
chmod +x "$LAUNCHER_PATH"
chmod +x "$SCRIPT_DIR/run.sh"

# --- Generate the .desktop file content directly ---
# This removes the need for a separate template file and the 'sed' command.
echo "⚙️  Generating .desktop file content..."
# Using a 'here document' (cat <<EOF) is a very reliable way to write multi-line files.
cat > "$FINAL_DESKTOP_PATH" <<EOF
[Desktop Entry]
Version=1.0
Name=Flood Monitor
Comment=Launch the flood monitoring dashboard
Type=Application
Terminal=false
Icon=network-server
Categories=Application;Network;Dashboard;
StartupNotify=true
Path=$SCRIPT_DIR
Exec=$LAUNCHER_PATH
EOF

# --- Set permissions on the final installed file ---
# Some desktop environments require the .desktop file itself to be executable.
chmod +x "$FINAL_DESKTOP_PATH"
echo "✅ Installing and setting permissions for application shortcut..."

# --- Final Instructions ---
echo "✅ Installation Complete!"
echo "You can now find 'Flood Monitor' in your application menu."
echo "You can also right-click it in the menu to add it to your desktop."