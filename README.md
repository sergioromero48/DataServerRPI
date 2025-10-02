
# Flood Monitoring

Run on Raspberry Pi or Jetson Nano.

1) Make `install.sh` executable and run it, or double-click it in the file manager:

```bash
./install.sh
```

No `sudo` required unless your system specifically asks for it.

The installer registers the application ("Flood Monitor") in the application menu and may open the dashboard automatically.

2) If the dashboard is not already open, open a browser on the device and go to:

http://localhost:8501

To stop the app started in the background:

```bash
pkill -f "app.py" || pkill -f streamlit
```

## Technical (compact)

Manual install & run:

```bash
python3 -m pip install -r requirements.txt
./launch.sh
```

Key environment variables:
- `OPENWEATHER_API_KEY` — OpenWeather API key (optional)
- `SERIAL_PORT` — serial device path (e.g. `/dev/ttyUSB0`) or `AUTO`
- `BAUDRATE` — serial speed (default `115200`)
- `CSV_PATH` — path to CSV (default `data/data.csv`)

CSV schema (columns written to `data/data.csv`):
EntryTimeUTC,Latitude,Longitude,Temperature,Humidity,Light,Precipitation,WaterLevel

Typical microcontroller serial lines accepted:
- `DATA,24.7,51.2,22340,0,Nominal`
- `24.7,51.2,22340,0,Nominal`

OpenWeather API quick steps:
1. Sign up at https://openweathermap.org/.
2. In your profile, create an API key.
3. Set it for the session and start the app:

```bash
export OPENWEATHER_API_KEY=your_key_here
./launch.sh
```

That's all.
