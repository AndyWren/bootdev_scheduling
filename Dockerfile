FROM python:3.13.2 AS base
# Set environment variables to prevent Python from writing .pyc files to disk and to ensure the output is buffered
ENV PYTHONUNBUFFERED 1
ENV PYTHONWARNINGS "ignore::UserWarning"
ENV POETRY_HOME=/opt/poetry
ENV POETRY_NO_INTERACTION=1
ENV POETRY_VIRTUALENVS_CREATE=false
ENV POETRY_CACHE_DIR='/var/cache/pypoetry'
# Install Poetry dependencies (curl and install Poetry)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl && \
    curl -sSL https://install.python-poetry.org | python3 - && \
    # Clean up to reduce image size
    rm -rf /var/lib/apt/lists/*
ENV PATH="/opt/poetry/bin:${PATH}"
COPY . /src/
WORKDIR /src
RUN $POETRY_HOME/bin/poetry install --no-interaction --no-ansi