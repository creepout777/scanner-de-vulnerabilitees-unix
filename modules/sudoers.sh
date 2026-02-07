echo "[SUDOERS] Entrées dangereuses"
grep -R "NOPASSWD" /etc/sudoers /etc/sudoers.d 2>/dev/null
