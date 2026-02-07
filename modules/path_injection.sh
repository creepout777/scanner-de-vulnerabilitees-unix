echo "[PATH INJECTION] Répertoires writable"
echo "$PATH" | tr ':' '\n' | while read dir; do
  [ -w "$dir" ] && echo "Writable : $dir"
done
