.PHONY: all

KIND=4
IFLAGS=-funroll-all-loops -WB -std08 -module . -implicitnone -fpp -warn all -pedantic -fpp -Iout/ -DDEF_KIND=$(KIND)  -g
GFLAGS=-O3  -ffree-form -std=f2008 -fimplicit-none -Wall -pedantic -fbounds-check -cpp

all: out/main

out/main: src/gauss.f90 src/constants.f90 src/main.f90
	mkdir -p out
	ifort $^ -o $@ $(IFLAGS)

out/gmain: src/*.f90
	mkdir -p out
	gfortran $^ -o $@ $(GFLAGS)
