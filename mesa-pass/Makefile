#!makefile

LLVMCONFIG ?= /usr/lib/llvm-15/bin/llvm-config
LIBS    := -lLLVM
LDFLAGS := $(shell $(LLVMCONFIG) --ldflags)
CFLAGS  := $(shell $(LLVMCONFIG) --cflags)

test.out: main.cpp
	g++ $(CFLAGS) -g -o $@ $< $(LDFLAGS) $(LIBS)
