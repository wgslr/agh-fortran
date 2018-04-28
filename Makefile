.PHONY: all

KIND=4
IFLAGS=-funroll-all-loops -WB -std08 -module . -implicitnone -fpp -warn all -pedantic -fpp -Iout/ -DDEF_KIND=$(KIND)  -g
GFLAGS=-O3  -ffree-form -std=f2008 -fimplicit-none -Wall -pedantic -fbounds-check -cpp

all: out/main

out/main: src/main.f90 out/utils.mod out/gauss.mod
	ifort $^ -o $@ $(IFLAGS)

out/gauss.mod: src/gauss.f90 out/utils.mod
	ifort $^ -c -o $@ $(IFLAGS)

out/utils.mod: src/utils.f90
	ifort $^ -c -o $@ $(IFLAGS)
	

out/gmain: src/*.f90
	mkdir -p out
	gfortran $^ -o $@ $(GFLAGS)

clean:
	-rm -r out/* *.mod
