#!makefile

LLVMCONFIG ?= /usr/lib/llvm-15/bin/llvm-config
LIBS    := -lLLVM
LDFLAGS := $(shell $(LLVMCONFIG) --ldflags)
CFLAGS  := $(shell $(LLVMCONFIG) --cflags)

test.out: main.c
	gcc $(CFLAGS) -g -o $@ $< $(LDFLAGS) $(LIBS)
