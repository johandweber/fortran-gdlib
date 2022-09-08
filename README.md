# fortran-gdlib
Fortran binding for the GD graphics library [https://libgd.github.io/](https://libgd.github.io/).

## Currents status and aims
This is a Fortran binding for the GD graphics library.
<<<<<<< HEAD
Currently it is in a very early state and supports only 
a small subset of additional subroutines functions.
=======
Currently it is in a very early state and only supports 
a small small subset of the library.
>>>>>>> 4d833edede85db32e5275ce65fe0bd65f0d5b1cf
My plan is to gradually add more functions, but it is unlikely that the wrapper will ever
cover the complete functionality of the GD librrary.

If you miss a certainn functionality contact me or -- even better -- add the functionality
and open a pull request.

Currently supported subroutines functions:

*gd_fclose
*gd_fopen


If you miss sopme functionality just drop me a message or -- even better -- add that functionality and
and fill a pull request.


The currently supported subroutines and functions are

* gd_fclose
* gdFontGetGiant
* gdFontGetLarge
* gdFontGetMediumBold
* gdFontGetSmall
* gdFontGetTiny
* gd_fopen
* gdImageArc
* gdImageClone
* gdImageColorAllocate
* gdImageColorAllocateAlpha
* gdImageCopy
* gdImageCopyMerge
* gdImageCopyMergeGrey
* gdImageCreate
* gdImageCreateTrueColor
* gdImageDashedLine
* gdImageDestroy
* gdImageEllipse
* gdImageFill
* gdImageFilledArc
* gdImageFilledEllipse
* gdImageFilledRectangle
* gdImageGetPixel
* gdImageGetTrueColorPixel
* gdImageJpeg
* gdImageLine
* gdImagePng
* gdImageRectangle
* gdImageString
* gdTrueColorGetAlpha
* gdTrueColorGetBlue
* gdTrueColorGetGreen
* gdTrueColorGetRed 

## Requirements
* Fortran-2008 compatible Fortran compiler (tested with gfortran 11)
* libGD and its dependencies

## Compiling
Edit the ```Makefile``` such that ist fits both your Fortran environment and your installation of the GD Library.
The library is then created (along with an example application) by invoking the ```make``` command.
