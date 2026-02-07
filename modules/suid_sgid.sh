echo "[SUID / SGID] Binaires à privilèges"
find / -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null

