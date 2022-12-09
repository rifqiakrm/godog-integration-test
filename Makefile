.PHONY: tests
tests:
	bin/godog.sh

.PHONY: test
test:
	bin/godog-feature.sh $(feature)

.PHONY: generate.report
generate.report:
	bin/generate-report.sh