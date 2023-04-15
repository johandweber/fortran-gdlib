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
  integer(c_int):: white
  integer(c_int):: black

  integer(c_int):: closestatus

  integer(c_int), dimension(0:7) ::imagerect

  imagerect=/0,0,639,0,639,479,0,479/
  
  ! Allocate the image: 640 pixels across by 480 pixels tall  
  im = gdImageCreate(640_c_int, 64_c_int)

  ! Allocate the color black (red, green and blue all minimum).
  ! Since this is the first color in a new image, it will
  ! be the background color.  
  black = gdImageColorAllocate(im, 0_c_int, 0_c_int, 0_c_int)

  ! Allocate the color white (red, green and blue all maximum).  
  white = gdImageColorAllocate(im, 255_c_int, 255_c_int, 255_c_int)

  call gdImageStringFT(im, imagerect, white,"/usr/share/fonts/opentype/freefont/FreeSans.otf"//c_null_char , &
                       40, 0 ,100,100,"KF©ªÀ}ɨɸΘΓӜӅआऍ♣ⵛꔞꔡꔦꔦ𐤕𐤌𐤌"//c_null_char)

  ! Open a file for writing. "wb" means "write binary", important
  ! under MSDOS, harmless under Unix. */
  pngout = gd_fopen("test.png"//c_null_char, "wb"//c_null_char)

  ! Do the same for a JPEG-format file. *
  jpegout =  gd_fopen("test.jpeg"//c_null_char, "wb"//c_null_char)

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
