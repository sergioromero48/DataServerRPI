# Flood Monitoring

Run this on a Raspberry Pi or Jetson Nano.

## Getting started

1. Open Terminal and change to the project folder (example):

```bash
cd ~/DataServerRPI
```

2. Run the installer (this sets up everything):

```bash
sudo bash install.sh
```

After that the app is installed and ready. You can:
- Double-click the FloodMonitoring icon on the desktop to start the dashboard, or
- Start it from Terminal with:

```bash
bash launch.sh
```

Open the dashboard in a browser at:

http://localhost:8501

To stop the app started from Terminal: press Ctrl+C. To stop a background start:

```bash
pkill -f "app.py" || pkill -f streamlit
```

## Quick technical reference

Manual install and run:

```bash
python3 -m pip install -r requirements.txt
bash launch.sh
```

Environment variables you may use:
- OPENWEATHER_API_KEY — OpenWeather API key (optional)
- SERIAL_PORT — serial device path (e.g. /dev/ttyUSB0)
- BAUDRATE — serial speed (default 115200)

CSV file: `data/data.csv` (columns: EntryTimeUTC,Latitude,Longitude,Temperature,Humidity,Light,Precipitation,WaterLevel)

OpenWeather API quick steps:
1. Create a free account at https://openweathermap.org/.
2. In your profile, go to "API keys" and generate a key.
3. On the device run:

```bash
export OPENWEATHER_API_KEY=your_key_here
bash launch.sh
```

Make the key persistent by adding the export to `~/.profile`.

---
