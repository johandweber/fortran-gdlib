#include<gd.h>
#include<stdio.h>

/* Functions that wrap the accessor macros so nthat they can be interaced from
   Fortran */

int wrap_gdImageTrueColor (gdImagePtr im) {
  return gdImageTrueColor(im);
}

int wrap_gdImageSX (gdImagePtr im) {
  return gdImageSX(im);
}

int wrap_gdImageSY (gdImagePtr im) {
  return gdImageSY(im);
}

int wrap_gdImageColorsTotal (gdImagePtr im) {
  return gdImageColorsTotal(im);
}

int wrap_gdImageRed(gdImagePtr im, int c){
  return gdImageRed(im,c);
}

int wrap_gdImageGreen(gdImagePtr im, int c){
  return gdImageGreen(im,c);
}

int wrap_gdImageBlue(gdImagePtr im, int c){
  return gdImageBlue(im,c);
}

int wrap_gdImageAlpha(gdImagePtr im, int c){
  return gdImageAlpha(im,c);
}

int wrap_gdImageGetInterlaced(gdImagePtr im){
  return gdImageGetInterlaced(im);
}

int wrap_gdImagePalettePixel(gdImagePtr im, int x, int y){
  return gdImagePalettePixel(im, x, y);
}

int wrap_gdImageTrueColorPixel(gdImagePtr im, int x, int y){
  return gdImageTrueColorPixel(im, x, y);
}

int wrap_gdImageResolutionX(gdImagePtr im){
  return gdImageResolutionX(im);
}

int wrap_gdImageResolutionY(gdImagePtr im){
  return gdImageResolutionY(im);
}

FILE* wrap_popen(const char *command, const char *type){

  FILE* myfile = NULL;

#ifdef _POSIX_C_SOURCE
  myfile=popen(command, type);
#endif

#ifdef _WIN32
  myfile = _popen(command, type);
#endif

  return myfile;
}
    
  

