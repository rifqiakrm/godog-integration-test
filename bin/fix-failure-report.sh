set -euo pipefail

head -n -1 report.json > report.json.temp

cp report.json.temp report.json

rm -f report.json.temp