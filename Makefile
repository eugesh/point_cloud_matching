
ifeq ($(basename $(notdir $(MAKE))), mingw32-make)
  CMAKE_GENERATOR = "MinGW Makefiles"
  MAKE_DIR = md
  REMOVE_DIR = rd /s /q
else
  CMAKE_GENERATOR = "Unix Makefiles"
  MAKE_DIR = mkdir -p
  REMOVE_DIR = rm -rf
endif

PREFIX ?= /usr

all: release

release:
	@-${MAKE_DIR} bin
	@-${MAKE_DIR} build
	@-${MAKE_DIR} doc/documentation
	@cd build && cmake -G $(CMAKE_GENERATOR) -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=$(PREFIX) ..
	@$(MAKE) -C build

debug:
	@-${MAKE_DIR} bin
	@-${MAKE_DIR} build
	@-${MAKE_DIR} doc/documentation
	@cd build && cmake -G $(CMAKE_GENERATOR) -D CMAKE_BUILD_TYPE=Debug -D CMAKE_INSTALL_PREFIX=$(PREFIX) ..
	@$(MAKE) -C build

install: release
	@echo "Performing installation"
	@$(MAKE) -C build install

doc:
	@cd doc && doxygen

clean:
	@echo "Cleaning build directory"
	-@$(MAKE) -C build clean

distclean: clean
	@echo "Removing build directory"
	-@${REMOVE_DIR} bin
	-@${REMOVE_DIR} build
	-@${REMOVE_DIR} doc/documentation

.PHONY: doc
