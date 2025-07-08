#!/data/data/com.termux/files/usr/bin/bash

CITY="Bhadi Khurd, IN"
API_KEY="dd8beaa29190bb62979cb613181473ed"
URL="https://api.openweathermap.org/data/2.5/forecast?q=${CITY}&appid>

DATA=$(curl -s "$URL")
RAIN_FORECAST=$(echo "$DATA" | grep -A6 '"dt_txt"' | grep '"rain"' | >
FORECAST_TIME=$(echo "$RAIN_FORECAST" | grep -oP '"dt_txt":"\K[^"]+')

if [[ -n "$RAIN_FORECAST" ]]; then
  HR12=$(date -d "$FORECAST_TIME" +"%I %p")
  espeak -v hi -s 150 "सर, आज भदी खुर्द में लगभग ${HR12} बजे बारिश होने की >
fi
