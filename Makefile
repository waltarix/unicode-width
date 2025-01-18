LOCALEDATA_VERSION := 16.0.0
EAW_FILE := https://github.com/waltarix/localedata/releases/download/$(LOCALEDATA_VERSION)/EastAsianWidth.txt

CACHE_DIR := .cache
CACHE_FILE := $(CACHE_DIR)/$(LOCALEDATA_VERSION)

LOCAL_EAW_FILE := scripts/EastAsianWidth.txt

.PHONY: all
all: generate

.PHONY: generate
generate: $(LOCAL_EAW_FILE)
	cd scripts && python3 -B unicode.py

$(LOCAL_EAW_FILE): $(CACHE_FILE)
	curl -sL $(EAW_FILE) > $@

$(CACHE_DIR):
	mkdir -p $@
$(CACHE_FILE): $(CACHE_DIR)
	touch $@

.PHONY: clean
clean:
	$(RM) -r $(CACHE_DIR)
