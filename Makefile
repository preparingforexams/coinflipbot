.PHONY: generate_all

generate_all:
	$(MAKE) -C application generate
	$(MAKE) -C infrastructure generate
	$(MAKE) -C interface generate
