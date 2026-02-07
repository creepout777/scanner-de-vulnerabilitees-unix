echo "[RED TEAM] Artefacts suspects"

echo ">> authorized_keys"
find /home -name authorized_keys 2>/dev/null | while read f; do
  echo "--- $f ---"
  cat "$f"
done

echo ">> Processus suspects"
ps aux | grep -E "nc|bash -i|python -c" | grep -v grep
