# fortran-gdlib
Fortran binding for the GD graphics library [https://libgd.github.io/](https://libgd.github.io/).

## Currents status and aims
This is a Fortran binding for the GD graphics library.
Currently it is in a very early state and only able to 
compile the very first example of the documentation from
[https://libgd.github.io/manuals/2.3.3/files/preamble-txt.html](https://libgd.github.io/manuals/2.3.3/files/preamble-txt.html), 
which has been "translated"to Fortran.
My plan is to gradually add more functions, but it is unlikely that the wrapper will ever
cover the colplete functionality of the GD librrary.

## Requirements
* Fortran-2008 compatible Fortran compiler (tested with gfortran 11)
* libGD

##Compiling
Edit the ```Makefile``` such that ist fits both your Fortran environment and your installation of the GD Library.
The library is then created (along with an example application) by invoking the ```make``` command.
