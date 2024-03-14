# Используйте официальный образ Python 3.11 как базовый
FROM python:3.11

# Установите рабочий каталог в контейнере
WORKDIR /usr/src/app

# Установите poetry
RUN pip install poetry

# Отключите создание виртуального окружения poetry, 
# поскольку Docker и так изолирует зависимости
RUN poetry config virtualenvs.create false

# Копируйте только файлы pyproject.toml и poetry.lock (если есть) 
# для установки зависимостей в начале и улучшения кэширования слоев Docker
COPY pyproject.toml poetry.lock* ./

# Установите зависимости, используя poetry
RUN poetry install --no-dev --no-interaction --no-ansi

# Скопируйте оставшиеся файлы вашего проекта
COPY . .

# Задайте команду для запуска приложения
CMD [ "python", "./homework8.py" ]