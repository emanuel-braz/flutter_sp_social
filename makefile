release:
	@echo "Building release version..."
	@rm -rf docs/
	@flutter build web --no-source-maps --web-renderer html --output docs/
	@echo "Done."

release-canvas:
	@echo "Building release version..."
	@rm -rf docs/
	@flutter build web --no-source-maps --output docs/
	@echo "Done."

analyze:
	@echo "Analyzing code..."
	@flutter analyze --fatal-infos --fatal-warnings .
	@echo "Done."