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

.PHONY: test
test: test-x86_64 test-aarch64

.PHONY: test-x86_64
test-x86_64:
	./scripts/test.sh x86_64

.PHONY: test-aarch64
test-aarch64:
	./scripts/test.sh aarch64

.PHONY: clean
clean:
	rm -rf *.build.bak *.build
