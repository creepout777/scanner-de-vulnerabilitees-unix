#!/bin/bash

SCAN_TIME=$(date +"%Y%m%d_%H%M")

RAW_SCAN="scans/raw_$SCAN_TIME.log"
FINAL_SCAN="scans/scan_$SCAN_TIME.log"
LAST_RAW="history/last_raw.log"

mkdir -p scans history report

echo "[+] Scan démarré à $SCAN_TIME" > "$RAW_SCAN"

for module in modules/*.sh; do
  echo "-----------------------------" >> "$RAW_SCAN"
  bash "$module" >> "$RAW_SCAN"
done

# Copie du scan brut vers le scan final
cp "$RAW_SCAN" "$FINAL_SCAN"

# Comparaison propre
if [ -f "$LAST_RAW" ]; then
  echo "===== CHANGEMENTS DEPUIS LE DERNIER SCAN =====" >> "$FINAL_SCAN"
  diff -u "$LAST_RAW" "$RAW_SCAN" >> "$FINAL_SCAN"
fi

# Mise à jour de la base
cp "$RAW_SCAN" "$LAST_RAW"

# Génération du rapport HTML
bash utils/html_report.sh "$FINAL_SCAN"

echo "[+] Scan terminé"

