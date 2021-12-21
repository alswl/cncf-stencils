source_git_url = "https://github.com/cncf/landscape.git"
source_icons_version = "unknown"

.PHONY: install
install:
	pip3 install omnigraffle-stencil

.PHONY: vendor
vendor:
	mkdir -p vendor
	git clone --depth=1 $(source_git_url) vendor/landscape


.PHONY: build
build: source_icons_version=$(shell git -C vendor/landscape log --format="%h" cached_logos | head -n 1)
build:
	mkdir -p output
	for i in $(shell ls vendor/landscape/cached_logos/*.svg); do \
		rsvg-convert -h 120 -f svg $$i | sponge $$i; \
	done
	omnigraffle-stencil --svg ./vendor/landscape/cached_logos/ --stencil-file ./output/cncf-$(source_icons_version).gstencil
	zip -r ./output/cncf-$(source_icons_version).gstencil.zip ./output/cncf-$(source_icons_version).gstencil
