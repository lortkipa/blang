NAME := blang

BIN_FOLDER := bin
SRC_FOLDER := src

SRC_FILES := $(shell find $(SRC_FOLDER) -name '*.s')
OBJ_FILES := $(patsubst $(SRC_FOLDER)/%.s,$(BIN_FOLDER)/%.o,$(SRC_FILES))

# run executable
.PHONY: run
run: $(BIN_FOLDER)/$(NAME)
	-@./$<

# generete executable from all .o files
$(BIN_FOLDER)/$(NAME): $(OBJ_FILES)
	@ld -s -e main -o $@ $^
	@echo 'Compiled: $@'

# generate .o file for each .s
$(BIN_FOLDER)/%.o: $(SRC_FOLDER)/%.s | $(BIN_FOLDER)
	@mkdir -p $(dir $@)
	@as -o $@ $<
	@echo 'Compiled: $@'

# create binaries folder
$(BIN_FOLDER):
	@mkdir -p $@
	@echo 'Folder Created: $@'

# delete binaries folder
.PHONY: clean
clean:
	@rm -rf $(BIN_FOLDER)
	@echo 'Folder Deleted: $(BIN_FOLDER)'