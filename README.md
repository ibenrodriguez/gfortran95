fortran
=======

Source codes and data files from the Introduction to Fortran training course plus some extra bits.

### fortran95

Files with `.f95` extension are modernised and compile with

    gfortran -std=f95 -ffree-form -fimplicit-none \
     -Werror -Wall -Wconversion -Wimplicit-interface \
     -pedantic-errors

unless specified otherwise in the source code.

### COPYRIGHT / LICENSE

The MIT License (MIT).

Cloned from: https://github.com/bszcz/fortran

Iben.Rodriguez@gmail.com 

May 9, 2017

NOTE: These programs have been tested on both Mac OS X 10.12.14 using home brew and Debian Linux 8.7 Jessie (running on an ARM8 BeagleBone Black BBB Rev C SBC)

    Here is the process for compliling and running a simple "Hello World" program: 
    debian@beaglebone:~/gfortran95$ gfortran -ffree-form -o hello hello.f
    debian@beaglebone:~/gfortran95$ ./hello
     Hello World!
    debian@beaglebone:~/gfortran95$

