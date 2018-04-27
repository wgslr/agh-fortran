.PHONY: all

KIND=4
FLAGS=-O3 -funroll-all-loops -WB -std08 -module . -implicitnone -fpp -warn all -pedantic -fpp -Iout/ -DDEF_KIND=$(KIND) 

all: out/main

out/main: *.f90
	mkdir -p out
	ifort $^ -o $@ $(FLAGS)

