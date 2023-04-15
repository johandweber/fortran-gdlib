! This is just a "translation" of the cfirst example of the GD lib C
! documentation at https://libgd.github.io/manuals/2.3.3/files/preamble-txt.html
! to the Fortran language
!
! All bugs are my own

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

  ! Allocate the image: 64 pixels across by 64 pixels tall  
  im = gdImageCreate(64_c_int, 64_c_int)

  ! Allocate the color black (red, green and blue all minimum).
  ! Since this is the first color in a new image, it will
  ! be the background color.  
  black = gdImageColorAllocate(im, 0_c_int, 0_c_int, 0_c_int)

  ! Allocate the color white (red, green and blue all maximum).  
  white = gdImageColorAllocate(im, 255_c_int, 255_c_int, 255_c_int)

  ! Draw a line from the upper left to the lower right,
  ! using white color index.  
  call gdImageLine (im, 0_c_int, 0_c_int, 63_c_int, 63_c_int, white)

  ! Open a file for writing. "wb" means "write binary", important
  ! under MSDOS, harmless under Unix. */
  pngout = gd_fopen("outpics/test.png"//c_null_char, "wb"//c_null_char)

  ! Do the same for a JPEG-format file. *
  jpegout =  gd_fopen("outpics/test.jpeg"//c_null_char, "wb"//c_null_char)

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
