FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    TZ=Asia/Shanghai \
    QQ_MCP_HOST=0.0.0.0 \
    QQ_MCP_PORT=8888

RUN apt-get update \
 && apt-get install -y --no-install-recommends git ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone --depth 1 https://github.com/print-yuhuan/QQ-MCP-Server.git . \
 && rm -rf .git

RUN pip install --no-cache-dir -r requirements.txt \
 && pip install --no-cache-dir --no-deps .

EXPOSE 8888

CMD ["python", "-m", "qq_mcp_server"]