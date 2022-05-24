.PHONY: help clean build watch analyze test test-report screenshot check-unused check-unused-files check-unused-l10n check-unused-code

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean: ## Clean project
	@echo "Cleaning the project..."
	@flutter clean
	@flutter pub get

build: ## Trigger one time code generation
	@echo "Generating code..."
	@flutter pub run build_runner build --delete-conflicting-outputs

watch: ## Watch files and trigger code generation on change
	@echo "Generating code on the fly..."
	@flutter pub run build_runner watch --delete-conflicting-outputs

analyze: ## Analyze the code
	@flutter analyze
	@flutter pub run dart_code_metrics:metrics analyze lib

test: ## Run all tests with coverage
	@flutter test --coverage --test-randomize-ordering-seed=random

test-report: test ## Run all tests with html coverage report
	@echo "Generating html report..."
	@genhtml coverage/lcov.info -o coverage/html
	@open coverage/html/index.html

screenshot: ## Make screenshot
	@flutter screenshot

check-unused: check-unused-files check-unused-l10n check-unused-code ## Check unused files, l10n, code

check-unused-files: ## Check unused files
	@echo "Checking unused files..."
	@flutter pub run dart_code_metrics:metrics check-unused-files lib

check-unused-l10n: ## Check unused l10n
	@echo "Checking unused l10n..."
	@flutter pub run dart_code_metrics:metrics check-unused-l10n lib

check-unused-code: ## Check unused code
	@echo "Checking unused code..."
	@flutter pub run dart_code_metrics:metrics check-unused-code lib