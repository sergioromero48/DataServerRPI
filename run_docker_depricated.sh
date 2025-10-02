#!/usr/bin/env bash
set -e

CSV_DIR="$(pwd)/data"
CSV_PATH="$CSV_DIR/data.csv"

echo "📁 Preparing CSV directory: $CSV_DIR"
mkdir -p "$CSV_DIR"
touch "$CSV_PATH"
echo "✅ CSV path OK → $CSV_PATH"
export OPENBLAS_CORETYPE=ARMV8 
#Default SERIAL=AUTO unless user overrides

SERIAL="${SERIAL:-AUTO}"
echo "ℹ️  SERIAL=$SERIAL — the background worker will probe for available ports."

# --- VIRTUAL ENVIRONMENT & INSTALLATION ---
if [ ! -d ".venv" ]; then
  echo "🐍 Creating virtual environment..."
  python3 -m venv .venv
fi

source .venv/bin/activate

# Upgrade pip first
pip install --upgrade pip >/dev/null

echo "🛠️ Ensuring system dependencies for compiling are present..."
sudo apt-get install -y build-essential libatlas-base-dev

echo "Installing compiled libraries from source to ensure compatibility..."
# Uninstall any previous versions first to be safe
pip uninstall -y numpy pandas
pip uninstall -y folium
# Reinstall Folium without binaries, forcing compilation from source code
pip install --no-binary :all: folium

echo "✅ Compiled libraries installed successfully."

echo "🐍 Installing remaining Python packages..."
pip install -r requirements.txt >/dev/null
echo "✅ All packages installed."


# --- LAUNCH APPLICATION ---
echo "🚀 Launching Streamlit app"
echo "   - URL: http://localhost:8501"
echo "   - CSV path: $CSV_PATH"

# Export env vars
export CSV_PATH="$CSV_PATH"
export SERIAL_PORT="$SERIAL"

exec streamlit run app.py --server.port=8501 --server.address=0.0.0.0
