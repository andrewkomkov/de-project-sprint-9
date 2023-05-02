Для сборки готовых контейнеров сначала собираем базовый - для ускорения сборки/отладки/разработки

команда

docker buildx build --platform linux/amd64,linux/arm64 --push -t andrewkomkov/de_proj9_base:02052023 .