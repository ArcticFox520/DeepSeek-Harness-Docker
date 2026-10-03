# DeepSeek Harness Docker 镜像

自动构建 [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness) (dsh) 的 Docker 镜像，发布到 Docker Hub。

## 镜像信息

- **基础镜像**: `node:24`
- **平台**: `linux/amd64`, `linux/arm64`
- **标签**: 与官方版本号一致（如 `0.1.1-rc.2`），同时维护 `latest`

## 使用

### 运行

```bash
docker run -d \
  --name dsh \
  -p 3080:3080 \
  -e BAILIAN_API_KEY="your-api-key" \
  your-dockerhub-username/deepseek-harness:latest
```

### Docker Compose

```yaml
services:
  dsh:
    image: your-dockerhub-username/deepseek-harness:latest
    ports:
      - "3080:3080"
    environment:
      - BAILIAN_API_KEY=${BAILIAN_API_KEY}
    restart: unless-stopped
```

访问 `http://localhost:3080` 打开 Web UI。

## 环境变量

| 变量 | 说明 | 必填 |
|------|------|------|
| `BAILIAN_API_KEY` | 阿里云百炼 API Key | 是（或用 DEEPSEEK_API_KEY） |
| `DEEPSEEK_API_KEY` | DeepSeek 官方 API Key | 是（二选一） |

API Key 仅通过运行时环境变量注入，不写入镜像。

## GitHub Actions 配置

在仓库 Settings → Secrets and variables → Actions 中添加：

- `DOCKERHUB_USERNAME`: Docker Hub 用户名
- `DOCKERHUB_TOKEN`: Docker Hub Access Token（非登录密码）

## 自动构建机制

工作流每天 UTC 06:00 检测 DeepSeek Harness 上游仓库的最新 tag。若发现 npm 上存在对应版本且 Docker Hub 尚无该标签的镜像，则自动构建并推送多架构镜像。
