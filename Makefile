container:
	@echo "Building container..."
	@docker buildx build --platform linux/arm64 --push -t ghcr.io/ci4rail/linux-testing-container/linux-testing:latest .