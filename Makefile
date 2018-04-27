.PHONY: all

FLAGS=-O3 -funroll-all-loops -WB -std08 -module . -implicitnone -fpp -warn all -pedantic

all: out/main

out/main: *.f90
	ifort $^ -o $@ $(FLAGS)



#out/main: *.f90
	#gfortran -O3  -ffree-form -std=f2008 -fimplicit-none -Wall -pedantic -fbounds-check -cpp $^ -o $@
