! Test program for Free Type Fonts
! To make it work you may have to adapt the font path 


program test_fortran_gd
  use, intrinsic:: iso_c_binding,  only: c_ptr, c_int, c_null_char
  use fortran_libgd
  implicit none

  ! Declare the image  
  type(c_ptr)   :: im

  ! Declare output files
  type (c_ptr)  :: pngout, jpegout

  ! Declare color indexes  
  integer(c_int):: white, black, red,yellow

  integer(c_int):: closestatus

  integer(c_int), dimension(0:7) ::imagerect

  imagerect=[0,0,639,0,639,479,0,479]
  
  
  im = gdImageCreate(640_c_int, 480_c_int)
  
  black  = gdImageColorAllocate(im, 0_c_int, 0_c_int, 0_c_int)  
  white  = gdImageColorAllocate(im, 255_c_int, 255_c_int, 255_c_int)
  red    = gdImageColorAllocate(im, 255_c_int, 0_c_int, 0_c_int)
  yellow = gdImageColorAllocate(im, 255_c_int, 255_c_int, 0_c_int)

  call gdImageStringFT(im, imagerect, white,"/usr/share/fonts/opentype/freefont/FreeSans.otf"//c_null_char , &
       30._c_double, 0._c_double ,10,100,"KF©ªÀ}ɨɸΘΓӜӅआऍ♣ⵛꔞꔡꔦꔦ𐤕𐤌𐤌"//c_null_char)

  call gdImageStringFT(im, imagerect, red,"/usr/share/fonts/opentype/freefont/FreeSerif.otf"//c_null_char , &
       20._c_double, -0.1_c_double ,10,200,"KF©ªÀ}ɨɸΘΓӜӅआऍ♣ⵛꔞꔡꔦꔦ𐤕𐤌𐤌"//c_null_char)
 
  call gdImageStringFT(im, imagerect, yellow,"/usr/share/fonts/opentype/freefont/FreeMono.otf"//c_null_char , &
       25._c_double, +0.3_c_double ,10,400,"KF©ªÀ}ɨɸΘΓӜӅआऍ♣ⵛꔞꔡꔦꔦ𐤕𐤌𐤌"//c_null_char)

  pngout = gd_fopen("outpics/tf_font.png"//c_null_char, "wb"//c_null_char)

  jpegout =  gd_fopen("outpics/tf_font.jpeg"//c_null_char, "wb"//c_null_char)

  ! Output the image to the disk file in PNG format.
  call gdImagePng(im, pngout)

  ! Output the same image in JPEG format, using the default
  ! JPEG quality setting. 
  call gdImageJpeg(im, jpegout, -1_c_int);

  ! Close the files.
  closestatus = gd_fclose(pngout)
  closestatus = gd_fclose(jpegout)

  ! Destroy the image in memory.
  call  gdImageDestroy(im);

   
  
end program test_fortran_gd
