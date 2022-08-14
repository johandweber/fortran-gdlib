! This is just a "translation" of the cfirst example of the GD lib C
! documentation at https://libgd.github.io/manuals/2.3.3/files/preamble-txt.html
! to the Fortran language
!
! All bugs are my own

program test_fortran_gd
  use iso_c_binding,  only: c_ptr, c_int, c_null_char
  use fortran_libgd
  implicit none

  ! Declare the image  
  type(c_ptr)   :: im

  ! Declare output files
  type (c_ptr)  :: pngout, jpegout

  ! Declare color indexes  
  integer(c_int):: white, black, yellow, red, blue, magenta, cyan,&
                   grey, orange

  integer(c_int):: closestatus

 
  im = gdImageCreate(640_c_int, 640_c_int)

  
  black   =  gdImageColorAllocate(im, 0_c_int, 0_c_int, 0_c_int)
  white   =  gdImageColorAllocate(im, 255_c_int, 255_c_int, 255_c_int)
  yellow  =  gdImageColorAllocate(im, 255_c_int, 255_c_int, 0_c_int)
  red     =  gdImageColorAllocate(im, 255_c_int, 0_c_int, 0_c_int)
  blue    =  gdImageColorAllocate(im, 0_c_int, 0_c_int, 255_c_int)
  cyan    =  gdImageColorAllocate(im, 0_c_int, 255_c_int, 255_c_int)
  magenta =  gdImageColorAllocate(im, 255_c_int, 0_c_int, 255_c_int)
  grey    =  gdImageColorAllocate(im, 127_c_int, 127_c_int, 127_c_int)
  orange  =  gdImageColorAllocate(im, 255_c_int, 127_c_int, 0_c_int)
  
  
  call gdImageLine (im, 0_c_int, 0_c_int, 639_c_int, 639_c_int, white)
  call gdImageDashedLine (im, 0_c_int, 630_c_int, 639_c_int, 0_c_int, yellow)
  call gdImageRectangle (im, 10_c_int, 300_c_int, 50_c_int, 340_c_int, red)
  call gdImageFilledRectangle (im, 630_c_int, 300_c_int, 590_c_int, 340_c_int, blue)
  call gdImageEllipse (im, 320_c_int, 30_c_int, 40_c_int, 40_c_int, cyan)
  call gdImageFilledEllipse (im, 320_c_int, 610_c_int, 40_c_int, 40_c_int, magenta)
  call gdImageArc (im, 320_c_int, 320_c_int, 100_c_int, 100_c_int, 0_c_int, 90_c_int, grey)

  call gdImageLine (im, 320_c_int, 100_c_int, 340_c_int, 180_c_int, white)
  call gdImageLine (im, 320_c_int, 100_c_int, 300_c_int, 180_c_int, white)
  call gdImageLine (im, 300_c_int, 180_c_int, 340_c_int, 180_c_int, white)
  call gdImageFill (im, 320_c_int, 110_c_int, orange)
  

  pngout = gd_fopen("test_extended.png"//c_null_char, "wb"//c_null_char)


  jpegout =  gd_fopen("test_extended.jpeg"//c_null_char, "wb"//c_null_char)


  call gdImagePng(im, pngout)

 
  call gdImageJpeg(im, jpegout, -1_c_int);


  closestatus = gd_fclose(pngout)
  closestatus = gd_fclose(jpegout)


  call  gdImageDestroy(im);

   
  
end program test_fortran_gd
