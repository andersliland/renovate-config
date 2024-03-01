renovate-dry-run:
	LOG_LEVEL=debug npx renovate --platform=local --dry-run

renovate:
	LOG_LEVEL=debug npx renovate --platform=local

renovate-config-validator:
	renovate-config-validator $(shell find . -type f -name "*.json5*" ! -name ".prettierrc.json" ! -name "package.json" ! -name "package-lock.json" -not -path "./node_modules/*")

copy_docs:
	mkdir -p docs && cp -r README.md docs/

# Cannot use docker image since we use custom plugins (same-dir and exclude)
docs_generate: copy_docs
	npx techdocs-cli generate --verbose --no-docker

docs: docs_generate
	npx techdocs-cli serve --verbose --no-docker

mkdocs: copy_docs
	mkdocs serve --verbose
