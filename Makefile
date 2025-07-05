# Define source and build directories
SRC_DIR = content
BUILD_DIR = build

# Find all .md files in content directory
MD_FILES = $(wildcard $(SRC_DIR)/*.md)
# Generate corresponding .html files in build directory
OUT_FILES = $(patsubst $(SRC_DIR)/%.md,$(BUILD_DIR)/%.html,$(MD_FILES))

# Default target
all: $(BUILD_DIR) $(BUILD_DIR)/images $(BUILD_DIR)/styles.css $(OUT_FILES)

# Create build directory
$(BUILD_DIR):
	mkdir -p $@

# Copy images directory to build directory
$(BUILD_DIR)/images: images
	cp -r $< $@

# Copy style.css to build directory
$(BUILD_DIR)/styles.css: styles.css
	cp $< $@

# Pattern rule for processing each .md file
$(BUILD_DIR)/%.html: $(SRC_DIR)/%.md
	pandoc $< -o $@ --template=template.html

# Clean target to remove build directory
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean
