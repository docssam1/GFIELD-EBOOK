@echo off
chcp 65001 > nul
cd /d "%~dp0"
echo 브라우저에서 http://127.0.0.1:8787/ 을 여세요.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$py='C:\Users\inki_\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'; if(Test-Path $py){& $py -m http.server 8787 --bind 127.0.0.1}else{python -m http.server 8787 --bind 127.0.0.1}"
