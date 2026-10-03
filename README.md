# DeepSeek Harness Docker

[DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness) (dsh) 的 Docker 镜像，通过容器内 socat 反向代理实现远程访问。dsh 自身仍只监听 127.0.0.1:3080。

## 镜像

- 基础镜像：node:24
- 平台：linux/amd64, linux/arm64
- 标签：与官方版本一致（如 0.1.1-rc.2），同时维护 latest

## 运行

```bash
docker run -d \
  --name DeepseekHarness \
  -p 3080:3080 \
  -e DEEPSEEK_API_KEY="API_KEY" \
  -v dsh-data:/root/.dsh \
  arcticfox520/deepseek-harness:latest
```

访问 `http://localhost:3080`。

## Docker Compose

```yaml
services:
  dsh:
    image: arcticfox520/deepseek-harness:latest
    container_name: DeepseekHarness
    ports:
      - "3080:3080"
    environment:
      - API_KEY=${API_KEY}
    volumes:
      - dsh-data:/root/.dsh
    restart: unless-stopped

volumes:
  dsh-data:
```

## 环境变量

| 变量 | 说明 | 必填 |
|------|------|------|
| `DEEPSEEK_API_KEY` | DeepSeek 官方 API Key | 是 |

API Key 仅通过运行时环境变量注入，不写入镜像。

## 安全

dsh 官方拒绝将 Web UI 绑定到公网。本镜像的 socat 代理不改变该安全边界，dsh 仍只监听回环地址。请勿直接暴露到公网。如需远程访问，请在代理前增加认证层或使用 Tailscale。

## 自动构建

GitHub Actions 每天 UTC 06:00 检测上游最新 tag。仅当 npm 上存在对应版本且 Docker Hub 尚无该标签时，构建并推送多架构镜像。
