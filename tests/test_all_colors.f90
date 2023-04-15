program test_all_colors
  use, intrinsic:: iso_c_binding,  only: c_ptr, c_int, c_null_char, c_associated
  use, intrinsic:: iso_fortran_env, only: error_unit
  use fortran_libgd
 
  ! Declare the image  
  type(c_ptr)   :: im

  ! Declare output files
  type (c_ptr)  :: pngout

  ! Declare color indexes  
  integer(c_int):: current_color

  integer(c_int):: closestatus
  integer(c_int):: xcounter, ycounter, running_number

  character(len=100):: tempstring

 
  im = gdImageCreateTrueColor(4096_c_int, 4096_c_int)

  pngout = gd_fopen('outpics/all_colors.png'//c_null_char, 'w'//c_null_char)
  
  do ycounter = 0, 4097
     do xcounter = 0, 4097
        running_number = ycounter*4096+xcounter
        current_color = gdImageColorAllocate(im, int(running_number/(256**2), kind=c_int),&
                                                 int(mod(running_number,256**2)/256, kind=c_int),&
                                                 int(mod(running_number, 256), kind=c_int) )
        call gdImageSetPixel(im, xcounter, ycounter, current_color)
     enddo
  enddo

 
  call gdImagePng(im, pngout)
 
  closestatus = gd_fclose(pngout)
  
end program test_all_colors
