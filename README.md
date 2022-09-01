# fortran-gdlib
Fortran binding for the GD graphics library [https://libgd.github.io/](https://libgd.github.io/).

## Currents status and aims
This is a Fortran binding for the GD graphics library.
Currently it is in a very early state and only supports 
a small small subset of the library.
My plan is to gradually add more functions, but it is unlikely that the wrapper will ever
cover the complete functionality of the GD librrary.

If you miss a certainn functionality contact me or -- even better -- add the functionality
and open a pull request.

Currently supported subroutines functions:

*gd_fclose
*gd_fopen


## Requirements
* Fortran-2008 compatible Fortran compiler (tested with gfortran 11)
* libGD

## Compiling
Edit the ```Makefile``` such that ist fits both your Fortran environment and your installation of the GD Library.
The library is then created (along with an example application) by invoking the ```make``` command.
