.PHONY: all
all: x86_64 aarch64

.PHONY: x86_64
x86_64: x86_64.build

.PHONY: aarch64
x86_64: aarch64.build

%.build: rpmbuild/SPECS/mitamae.spec
	./scripts/build.sh $*

.PHONY: upload
upload:

.PHONY: clean
clean:
	rm -rf *.build.bak *.build
