FROM python:3.9-slim as development

ENV \
  PYTHONUNBUFFERED=1 \
  PATH=${PATH}:/root/.local/bin

WORKDIR /usr/src/app

COPY requirements.txt requirements-dev.txt setup.py ./
COPY LICENSE README.md pyproject.toml ./
COPY scripts scripts
COPY src src
COPY tests tests

RUN \
  python -m pip install --upgrade pip && \
  python -m pip install pipx && \
  pipx install --system-site-packages isort && \
  pipx install --system-site-packages black && \
  pipx install --system-site-packages bandit && \
  pipx install --system-site-packages safety && \
  python -m pip install pip-tools && \
  pip-sync requirements.txt requirements-dev.txt && \
  pip install --editable /usr/src/app

ENTRYPOINT ["/bin/bash"]
