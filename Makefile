.PHONY: all

KIND=4
IFLAGS=-O3 -funroll-all-loops -WB -std08 -module . -implicitnone -fpp -warn all -pedantic -fpp -Iout/ -DDEF_KIND=$(KIND) 
GFLAGS=-O3  -ffree-form -std=f2008 -fimplicit-none -Wall -pedantic -fbounds-check -cpp

all: out/main 


out/main: *.f90
	mkdir -p out
	-ifort $^ -o $@ $(IFLAGS)

out/gmain: *.f90
	mkdir -p out
	-gfortran $^ -o $@ $(GFLAGS)
