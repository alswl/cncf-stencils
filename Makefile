source_git_url = "https://github.com/cncf/landscape.git"
source_icons_version = "unknown"

.PHONY: install
install:
	pip3 install omnigraffle-stencil
	pip3 show -f omnigraffle-stencil
	which python
	which python3
	which omnigraffle-stencil
	python3 -c "import site; print(site.getsitepackages())"
	patch $(shell python3 -c "import site; print(site.getsitepackages()[0])")/omnigraffle_stencil/converter.py hack/converter.py.diff

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
	(cd vendor/landscape/cached_logos && find . -name "*.svg" -exec rsvg-convert -h 120 -f svg {} -o ../../../build/cached_logos/{} \;)
	(cd vendor/landscape/hosted_logos && find . -name "*.svg" -exec rsvg-convert -h 120 -f svg {} -o ../../../build/hosted_logos/{} \;)
	# grouping
	python scripts/group.py
	# build stencil
	omnigraffle-stencil --svg build/final --stencil-file ./output/cncf-$(source_icons_version).gstencil
	zip -r ./output/cncf-$(source_icons_version).gstencil.zip ./output/cncf-$(source_icons_version).gstencil

.PHONY: clean
clean:
	rm -rf build
