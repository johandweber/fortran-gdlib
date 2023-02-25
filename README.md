# fortran-gdlib
Fortran binding for the GD graphics library [https://libgd.github.io/](https://libgd.github.io/).

## Currents status and aims

Currently it is in an early state and supports only 
a subset of the functions provides by the GD library.
Currently it is in a very early state and only supports 
a small small subset of the library.
My plan is to gradually add more functions, but it is unlikely that the wrapper will ever
cover the complete functionality of the GD librrary.

If you miss sopme functionality just drop me a message or -- even better -- add that functionality and
and fill a pull request.

The currently supported subroutines and functions are

* gd_fclose
* gdFontCacheShutdown
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
* gdImageStringFT
* gdMinorVersion
* gdMajorVersion
* gdReleaseVersion
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

## Running the tests
Change to the ```tests``` subdirectory and run the ```run_tests.sh ``` script using the system shell. The output files can 
then be found in the ```outpics``` subdirectory of tests.
