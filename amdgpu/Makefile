#!makefile

LLVMCONFIG ?= llvm-config
LIBS    := $(shell $(LLVMCONFIG) --libs)
LDFLAGS := $(shell $(LLVMCONFIG) --ldflags)
CFLAGS  := $(shell $(LLVMCONFIG) --cflags)

test.out: main.c
	gcc $(CFLAGS) -g -o $@ $< $(LDFLAGS) $(LIBS)
