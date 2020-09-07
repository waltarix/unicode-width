TABLE_FILE_VERSION := "14.0.0-r2"
TABLE_FILE := "https://github.com/waltarix/localedata/releases/download/$(TABLE_FILE_VERSION)/tables.rs"

CACHE_DIR := .cache
CACHE_FILE := $(CACHE_DIR)/$(TABLE_FILE_VERSION)

.PHONY: all
all: src/tables.rs

src/tables.rs: $(CACHE_FILE)
	curl -sL $(TABLE_FILE) \
		| sed 's/u64, u64, u64/u8, u8, u8/; s/, -1, -1/,  0,  0/g; /d800/d' \
		> $@

$(CACHE_DIR):
	mkdir -p $@
$(CACHE_FILE): $(CACHE_DIR)
	touch $@

.PHONY: clean
clean:
	$(RM) -r $(CACHE_DIR)
