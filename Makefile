# Makefile
# Copyright (C) 2021-2022  Jacob Koziej <jacobkoziej@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

export REMARKABLE_UTILS_VERSION = 0.1.0

export PROJECT_ROOT = $(shell pwd)

export SRC   = $(PROJECT_ROOT)/src
export BUILD = $(PROJECT_ROOT)/build

export PREFIX  ?= /usr/local
export DESTDIR ?=

export SHELL_SCRIPTS = $(shell shfmt -f $(SRC))

.PHONY: all
all: shfmt
	./tools/shsub

.PHONY: install-remarkable
install-remarkable: all
	install -D $(SHELL_SCRIPTS:$(SRC)%=$(BUILD)%) \
	-t $(DESTDIR)$(PREFIX)/bin

.PHONY: test
test: shellcheck

.PHONY: shfmt
shfmt:
	shfmt -w -p -sr -fn $(SHELL_SCRIPTS)

.PHONY: shellcheck
shellcheck:
	shellcheck $(SHELL_SCRIPTS)

.PHONY: clean
clean:
	rm -rf $(BUILD)
