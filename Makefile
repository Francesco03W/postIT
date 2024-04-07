CC=g++
SOURCE=postIT.cpp
# compiler options to differentiate between debug flags and release flags
CC_DEBUG_MODE=-ggdb
CC_RELEASE_MODE=-O2 -DNDEBUG
CC_DISABLE_COMPILER_EXTENSIONS_FLAG=-pedantic-errors
CC_MAX_WARNING_LEVEL=-Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion
CC_WARNINGS_AS_ERRORS=-Werror
CC_LANG_STANDARD=-std=c++17

# la debug-build ha come requisito i file SOURCE, se esistono e modificati -> build
debug-build: $(SOURCE)
	$(CC) $(SOURCE) $(DEBUG_ARGS) -o $@
$(DEBUG_ARGS): $(CC_DEBUG_MODE) $(CC_DISABLE_COMPILER_EXTENSION_FLAG) $(CC_MAX_WARNING_LEVEL) $(CC_WARNINGS_AS_ERRORS) $(CC_LANG_STANDARD)

release-build: $(SOURCE)
	$(CC) $(SOURCE) $(RELEASE_ARGS) -o $@
$(RELEASE_ARGS): $(CC_RELEASE_MODE) $(CC_LANG_STANDARD)
