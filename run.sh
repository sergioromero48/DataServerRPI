#!/usr/bin/env bash
set -e

# --- CONFIGURATION ---
ENV_NAME="flood-monitoring"
ENV_FILE="environment.yml"

# --- CONDA AUTO-INSTALLER ---

# 1. Check if conda is installed. If not, install it automatically.
if ! command -v conda &> /dev/null
then
    echo "⚠️ Conda is not installed. Beginning automatic installation of Miniforge..."

    # Verify we are on a Raspberry Pi (aarch64)
    ARCH=$(uname -m)
    if [ "$ARCH" != "aarch64" ]; then
        echo "❌ ERROR: This auto-installer is for Raspberry Pi (aarch64) only."
        echo "   Your architecture is '$ARCH'. Please install Conda manually for your system."
        exit 1
    fi

    echo "⬇️  Downloading Miniforge installer for Raspberry Pi..."
    MINIFORGE_INSTALLER="Miniforge3-Linux-aarch64.sh"
    wget "https://github.com/conda-forge/miniforge/releases/latest/download/$MINIFORGE_INSTALLER" -O "$MINIFORGE_INSTALLER"

    echo "📦 Installing Miniforge to '$HOME/miniforge3'..."
    bash "$MINIFORGE_INSTALLER" -b -p "$HOME/miniforge3"

    echo "✨ Initializing Conda for your shell..."
    source "$HOME/miniforge3/bin/activate"
    conda init bash

    # Clean up the installer script
    rm "$MINIFORGE_INSTALLER"

    echo "✅ Conda installation complete!"
    echo "‼️ IMPORTANT: Please CLOSE and REOPEN your terminal, then run this script again to launch the application."
    exit 0
fi


# --- CONDA ENVIRONMENT SETUP (runs if Conda is already installed) ---

# 2. Make 'conda activate' available to the script.
source "$(conda info --base)/etc/profile.d/conda.sh"

# 3. Check if the environment already exists to speed up startup.
if ! conda env list | grep -q "^$ENV_NAME\s"; then
    echo "🐍 First-time setup: Creating Conda environment '$ENV_NAME'. This may take a few minutes..."
    conda env create --name "$ENV_NAME" --file "$ENV_FILE"
else
    # For speed, we just activate. A full update can be done manually if needed.
    echo "🐍 Environment '$ENV_NAME' already exists. Activating..."
fi

conda activate "$ENV_NAME"
echo "✅ Conda environment is ready."


# --- LAUNCH APPLICATION ---
# Create the data directory if it doesn't exist.
mkdir -p "$(pwd)/data"
echo "✅ Data directory ensured."

echo "🚀 Launching Streamlit app..."
# The app.py will handle its own configuration for API keys etc.
export CSV_PATH="$(pwd)/data/data.csv"
export SERIAL_PORT="${SERIAL:-AUTO}"

exec streamlit run app.py --server.port=8501 --server.address=0.0.0.0
