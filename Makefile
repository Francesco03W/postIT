#ISSUE: add options to make the project based on OS (unix/win)

CC=g++
SOURCE=postIT.cpp

# compiler options to differentiate between debug flags and release flags
CC_DEBUG_MODE=-ggdb
CC_RELEASE_MODE=-O2 -DNDEBUG
CC_DISABLE_COMPILER_EXTENSIONS_FLAG=-pedantic-errors
CC_MAX_WARNING_LEVEL=-Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion
CC_WARNINGS_AS_ERRORS=-Werror
CC_LANG_STANDARD=-std=c++17



# Portability issue: Windows uses \, GNU/Linux /

# instead of adding manually the .h files to the compiler, just use -I option to find them in directories instead
IMGUI_SRC_FOLDER=lib/imgui
IMGUI_BACKEND_FOLDER=lib/imgui/backends
SDL_FOLDER=/usr/local/include/SDL2

#IMGUI_SRC_FOLDER=lib\imgui
#IMGUI_BACKEND_FOLDER=lib\imgui\backends
#SDL_FOLDER=lib\SDL2-2.30.3\include


## GNU Make - Wildcard Function - Portable ##

# compile imgui 
IMGUI_SRC_CPP_FILES=$(wildcard $(IMGUI_SRC_FOLDER)/*.cpp)
#IMGUI_SRC_H_FILES=$(wildcard $(IMGUI_SRC_FOLDER)/*.h)

# compile imgui API backends
IMGUI_PLATFORM_CPP_FILES=$(wildcard $(IMGUI_BACKEND_FOLDER)/imgui_impl_sdl2.cpp)
#IMGUI_PLATFORM_H_FILES=$(wildcard $(IMGUI_BACKEND_FOLDER)/imgui_impl_sdl2.h)
IMGUI_RENDERER_CPP_FILES=$(wildcard $(IMGUI_BACKEND_FOLDER)/imgui_sdlrenderer2.cpp)
#IMGUI_RENDERER_H_FILES=$(wildcard $(IMGUI_BACKEND_FOLDER)/imgui_sdlrenderer2.h)


# pedantic compiler
debug-build: $(SOURCE)
	$(CC) $(SOURCE) -L/usr/local/lib -Wl, -Bstatic -lSDL2 -Wl, -Bdynamic -lm -ldl -I$(IMGUI_SRC_FOLDER) -I$(IMGUI_BACKEND_FOLDER) -I$(SDL_FOLDER)  $(IMGUI_SRC_CPP_FILES) $(IMGUI_PLATFORM_CPP_FILES) $(IMGUI_RENDERER_CPP_FILES) $(DEBUG_ARGS) -o $@
$(DEBUG_ARGS): $(CC_DEBUG_MODE) $(CC_DISABLE_COMPILER_EXTENSION_FLAG) $(CC_MAX_WARNING_LEVEL) $(CC_WARNINGS_AS_ERRORS) $(CC_LANG_STANDARD)

release-build: $(SOURCE)
	$(CC) $(SOURCE) $(RELEASE_ARGS) -o $@
$(RELEASE_ARGS): $(CC_RELEASE_MODE) $(CC_LANG_STANDARD)
