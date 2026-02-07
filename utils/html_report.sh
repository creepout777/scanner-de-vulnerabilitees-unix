#!/bin/bash

INPUT="$1"
OUTPUT="report/report.html"
DATE=$(date)

cat << EOF > "$OUTPUT"
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Rapport de Scan de Vulnérabilités</title>

<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
  background-color: #0d1117;
  color: #e6edf3;
}
.card {
  background-color: #161b22;
  border: 1px solid #30363d;
}
.card-header {
  background-color: #0d1117;
  font-weight: bold;
}
pre {
  color: #e6edf3;
  white-space: pre-wrap;
  margin: 0;
}
</style>
</head>

<body>

<nav class="navbar navbar-dark bg-dark px-3">
  <span class="navbar-brand"> Local Vulnerability Scanner</span>
</nav>

<div class="container my-4">

<div class="row mb-4">
  <div class="col">
    <div class="card">
      <div class="card-body">
        <h4 class="card-title text-primary">Rapport de Scan de Vulnérabilités</h4>
        <p class="card-text" style="color:white">
          <strong>Date du scan :</strong> $DATE<br>
          <strong>Type :</strong> Scan local – Blue Team
        </p>
      </div>
    </div>
  </div>
</div>
EOF

awk '
/^\[SUDOERS\]/ {
  print "<div class=\"card mb-3\"><div class=\"card-header text-warning\">Sudoers dangereux</div><div class=\"card-body\"><pre>";
  next
}
/^\[SUID/ {
  print "</pre></div></div><div class=\"card mb-3\"><div class=\"card-header text-warning\">SUID / SGID</div><div class=\"card-body\"><pre>";
  next
}
/^\[PATH/ {
  print "</pre></div></div><div class=\"card mb-3\"><div class=\"card-header text-warning\">PATH Injection</div><div class=\"card-body\"><pre>";
  next
}
/^\[SYSTEMD/ {
  print "</pre></div></div><div class=\"card mb-3\"><div class=\"card-header text-info\">Systemd Timers</div><div class=\"card-body\"><pre>";
  next
}
/^\[CVE/ {
  print "</pre></div></div><div class=\"card mb-3\"><div class=\"card-header text-info\">Logiciels & CVE</div><div class=\"card-body\"><pre>";
  next
}
/^\[RED TEAM\]/ {
  print "</pre></div></div><div class=\"card mb-3\"><div class=\"card-header text-danger\">Artefacts Red Team</div><div class=\"card-body\"><pre>";
  next
}
/^===== CHANGEMENTS/ {
  print "</pre></div></div><div class=\"card mb-3\"><div class=\"card-header text-success\">Évolution depuis le dernier scan</div><div class=\"card-body\"><pre>";
  next
}
{ print }
END { print "</pre></div></div>" }
' "$INPUT" >> "$OUTPUT"

cat << EOF >> "$OUTPUT"
</div>

<footer class="text-center text-muted py-3">
  Rapport généré automatiquement – Projet Blue Team
</footer>

</body>
</html>
EOF

