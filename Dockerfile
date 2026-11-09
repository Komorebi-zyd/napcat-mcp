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

# mcp 1.x，再装本体（pip 不会升级已满足的依赖）
RUN pip install --no-cache-dir "mcp<2" \
 && pip install --no-cache-dir .

# 构建期验证：这个导入能过就说明版本对了
RUN python -c "from mcp.server.fastmcp import FastMCP; print('FastMCP import OK')"

EXPOSE 8888

CMD ["python", "-m", "qq_mcp_server"]
