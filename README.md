# Building
## Prerequisites

Installed `ifort` or `gfortran` compiler.

## Compilation

The program can be compiled using provided Makefile.
The default action for `make` is to use ifort compiler creating
executable `out/main`. 

Command `make out/gmain` can be used
for compilation with gfortran. Note that you may need to issue `make clean`
before switching compilers.

## `kind` adjustemnt



`kind` value used for floating point variables can be changed by modifying Makefile variable `KIND`, as in
```
make all -B KIND=8
```

The `-B` switch forces make to rebuild project even when output files exist.  
You may need to issue above command twice to fix conflicts with module files compiled with other `KIND` option.

# Results

## Accuracy

Accuracy of calculated results was measured by comparing them to the expected result expressed as `f(x) = x`.
Averages of absolute differences between calculated and expected value are stored in files `result/accuracy.k{4,8,16}.dat`.  
Each of these files consists of columns expressing used `kind`, number of divisions `n` and the average error.

Graphs of the relation error(n) were generated using python pandas and matplotlib:

### kind=4
![kind4graph](results/accuracy.k4.png)

### kind=8
![kind4graph](results/accuracy.k8.png)

### kind=16
![kind4graph](results/accuracy.k16.png)

