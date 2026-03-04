#!/bin/bash
set -e

echo "🐳 Развертывание genzh/shvirtd-example-python..."

# Полное удаление + свежий клон
cd /opt
rm -rf shvirtd-example-python
git clone https://github.com/genzh/shvirtd-example-python.git
cd shvirtd-example-python

echo "✅ Файлы из GitHub:"
ls -la *.yaml* .env 2>/dev/null || echo "Файлы Docker Compose:"

# Остановка старых контейнеров
docker compose down 2>/dev/null || true

# ✅ Запуск ИЗ каталога проекта (использует файлы из GitHub)
docker compose up -d

sleep 10  # Ждем запуска MySQL

echo "✅ Статус:"
docker compose ps

echo "✅ IP web контейнера:"
docker inspect $(docker ps -q -f name=web) 2>/dev/null | grep IPAddress || echo "Web контейнер не запущен"

echo "✅ GitHub Fork: https://github.com/genzh/shvirtd-example-python"
EOF