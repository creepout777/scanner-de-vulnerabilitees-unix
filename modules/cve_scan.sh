echo "[CVE] Logiciels installés (extrait)"
if command -v dpkg >/dev/null; then
  dpkg -l | awk '{print $2, $3}' | head -n 20
elif command -v rpm >/dev/null; then
  rpm -qa | head -n 20
fi
