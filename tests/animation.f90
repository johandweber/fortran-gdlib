program animation
  use, intrinsic:: iso_fortran_env
  use, intrinsic:: iso_c_binding
  use fortran_libgd
  implicit none

  type(c_ptr) ::  my_gif
  type(c_ptr):: src, dst
  integer(c_int) :: angle
  integer(c_int): :error_code

  src = gdImageCreateFromFile("outpics/smileyguy.png"//c_null_char)
  my_gif = gd_fopen("outpics/animation.gif"//c_null_char)
  call gdImageGifAnimBegin(dest, my_gif,1_c_int, -1_c_int)

  do angle=0,360
     dest = gdImageCreate(100,100)
     call gdImageCopyRotated(dst, src, 50_c_double, 50_c_double,0_c_int,0_c_int,&
                             100_c_int, 100_c_int, angle)  
     call gdImageGifAnimAdd (dst, my_gif, 0_c_int, 0_c_int, 0_c_int, 4,c_null_ptr)
     gdImageDestroy(dst)
  enddo

  gdImageGifAnimEnd(my_gif)
  
  error_code = gd_fclose(my_gif)
  
end program animation

  
