UNICODE_VERSION := "13.0.0"
UNICODE_FILE := "https://github.com/waltarix/localedata/releases/download/$(UNICODE_VERSION)/unicode.tar.xz"
UNICODE_DIR := unicode

all: src/tables.rs

$(UNICODE_DIR):
	curl -sL $(UNICODE_FILE) | tar -Jxvf -

src/tables.rs: $(UNICODE_DIR)
	cd $(UNICODE_DIR); \
		../scripts/unicode.py
	mv $(UNICODE_DIR)/tables.rs $@

clean:
	$(RM) -r $(UNICODE_DIR)

.PHONY: src/tables.rs clean
