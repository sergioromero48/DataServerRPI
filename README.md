# Flood Monitoring

Simple instructions to run the dashboard on Raspberry Pi or Jetson Nano.

## Getting started (simple)

1. Open Terminal and change to the project folder. Example:

```bash
cd ~/DataServerRPI
```

2. Run the installer (may ask for your password):

```bash
sudo bash install.sh
```

3. Create a desktop launcher so you can start the dashboard by double-clicking. Replace /path/to/DataServerRPI with the actual path to this folder (for example /home/pi/DataServerRPI):

```bash
cp FloodMonitoring.desktop.template ~/Desktop/FloodMonitoring.desktop
sed -i "s|%%EXEC_PATH%%|/usr/bin/env bash -c '/path/to/DataServerRPI/launch.sh'|" ~/Desktop/FloodMonitoring.desktop
chmod +x ~/Desktop/FloodMonitoring.desktop
```

4. Double-click the FloodMonitoring icon on the desktop. Wait a few seconds for the server to start.

5. Open a browser on the device and go to:

http://localhost:8501

To stop the dashboard (if it was started from Terminal) press Ctrl+C in that Terminal. If started from the desktop icon, stop it from Terminal with:

```bash
pkill -f "app.py" || pkill -f streamlit
```

If the desktop icon does not start the app, run in Terminal:

```bash
bash launch.sh
```

What to click/press in the UI:
- Open the dashboard in your browser (step 5).
- No buttons required to collect data: connect the microcontroller by USB and it will appear in charts automatically.
- To refresh the page manually press the browser reload button.

What each part of the dashboard shows:
- Top metrics: current sensor values (Temperature, Humidity, Light, etc.).
- Plots: historical graphs for each sensor value.
- Data table: recent raw rows saved to `data/data.csv`.
- Map / Weather: location and current weather (only shown if an OpenWeather key is configured).

## Technical (commands & config)

Install and run manually:

```bash
python3 -m pip install -r requirements.txt
bash launch.sh
```

Common environment variables:
- OPENWEATHER_API_KEY — OpenWeather API key (optional)
- SERIAL_PORT — serial device path (e.g. /dev/ttyUSB0). If unset the worker will try to auto-detect.
- BAUDRATE — serial speed (default 115200)
- CSV_PATH — path to the CSV file (default `data/data.csv`)

Set an env var for the current session and start the app:

```bash
export OPENWEATHER_API_KEY=your_key_here
export SERIAL_PORT=/dev/ttyUSB0
bash launch.sh
```

CSV schema (columns in `data/data.csv`):

EntryTimeUTC,Latitude,Longitude,Temperature,Humidity,Light,Precipitation,WaterLevel

Accepted microcontroller line examples (sent over serial):
- `DATA,24.7,51.2,22340,0,Nominal`
- `24.7,51.2,22340,0,Nominal`

OpenWeather API — quick reference:
1. Go to https://openweathermap.org/ and sign up for a free account.
2. Sign in and open your profile > "API keys".
3. Create a new key and copy it.
4. On the Pi/Nano set the key and restart the app:

```bash
export OPENWEATHER_API_KEY=your_key_here
bash launch.sh
```

To make the key persistent, add the export line to `~/.profile` or `/etc/environment`.

Logs and data:
- Data file: `data/data.csv` (append-only)
- Worker output: visible in the Terminal where `launch.sh` runs

If you want an automatic startup at boot (systemd service) or a ready-made desktop shortcut modified for your exact path, tell me the target installation path and I will provide the files.

---
