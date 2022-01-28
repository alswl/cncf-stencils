source_git_url = "https://github.com/cncf/landscape.git"
source_icons_version = "unknown"

.PHONY: install
install:
	pip3 install omnigraffle-stencil
	patch $(shell pip3 show -f omnigraffle-stencil | grep Location | awk '{print $$2}')/omnigraffle_stencil/converter.py hack/converter.py.diff

.PHONY: install-for-github-actions
install-for-github-actions:
	pip3 install omnigraffle-stencil
	patch /home/runner/.local/lib/python3.8/site-packages/omnigraffle_stencil/converter.py hack/converter.py.diff

.PHONY: vendor
vendor:
	mkdir -p vendor
	git clone --depth=1 $(source_git_url) vendor/landscape


.PHONY: build
build: source_icons_version=$(shell git -C vendor/landscape log --format="%h" cached_logos | head -n 1)
build:
	mkdir -p output
	mkdir -p build/hosted_logos
	mkdir -p build/cached_logos
	mkdir -p build/final
	# height limits
	(cd vendor/landscape/cached_logos && find . -name "*.svg" -exec rsvg-convert -h 96 -f svg {} -o ../../../build/cached_logos/{} \;)
	(cd vendor/landscape/hosted_logos && find . -name "*.svg" -exec rsvg-convert -h 96 -f svg {} -o ../../../build/hosted_logos/{} \;)
	# grouping
	python scripts/group.py
	# build stencil
	omnigraffle-stencil --svg build/final --stencil-file ./output/cncf-$(source_icons_version).gstencil
	zip -r ./output/cncf-$(source_icons_version).gstencil.zip ./output/cncf-$(source_icons_version).gstencil

.PHONY: clean
clean:
	rm -rf build
