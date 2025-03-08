# expects the config to have:
# - THEME_FILE
# - SRC_FILE
# - OUT_FILE
include ./make.conf

SRC_DIR = src
BUILD_DIR = build

SRC = $(SRC_DIR)/$(SRC_FILE)
TEMPLATE = template.yaml

OUT = $(BUILD_DIR)/$(OUT_FILE)

ifdef THEME_FILE
	HIGHLIGHT_ARG = --highlight-style $(THEME_FILE)
endif

all: $(OUT)

$(OUT): $(SRC) $(STYLE) | $(BUILD_DIR)
	pandoc $(SRC) --lua-filter=mermaid.lua --resource-path $(SRC_DIR) --metadata-file $(TEMPLATE) --pdf-engine=xelatex -o $(OUT) $(HIGHLIGHT_ARG)

$(BUILD_DIR):
	mkdir build

clean:
	rm -r $(BUILD_DIR)

.PHONY: all clean
