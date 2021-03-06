.PHONY: all
all: x86_64 aarch64

.PHONY: x86_64
x86_64: x86_64.build

.PHONY: aarch64
aarch64: aarch64.build

%.build: rpmbuild/SPECS/mitamae.spec
	./scripts/build.sh $*

.PHONY: upload
upload:
	./scripts/upload.pl

.PHONY: clean
clean:
	rm -rf *.build.bak *.build
