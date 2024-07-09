TABLE_FILE_VERSION := 16.0.0
TABLE_FILE := https://github.com/waltarix/localedata/releases/download/$(TABLE_FILE_VERSION)/lookup.rs

CACHE_DIR := .cache
CACHE_FILE := $(CACHE_DIR)/$(TABLE_FILE_VERSION)

LOOKUP_FILE := src/tables/lookup.rs

.PHONY: all
all: $(LOOKUP_FILE)

$(LOOKUP_FILE): $(CACHE_FILE)
	curl -sL $(TABLE_FILE) > $@

$(CACHE_DIR):
	mkdir -p $@
$(CACHE_FILE): $(CACHE_DIR)
	touch $@

.PHONY: clean
clean:
	$(RM) -r $(CACHE_DIR)
