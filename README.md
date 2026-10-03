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
