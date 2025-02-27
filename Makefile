export GORELEASER := $(shell which goreleaser)


include main/main.mk
# Release wia goreleaser
release:
	@[ -x "$(GORELEASER)" ] || ( echo "goreleaser not installed"; exit 1)
	@goreleaser --snapshot --skip-publish --rm-dist
.PHONY: release

docker:
	@docker build --target $(stage_version) -t goimage:$(tag) . 
.PHONY: docker 
