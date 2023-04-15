program animation
  use, intrinsic:: iso_fortran_env
  use, intrinsic:: iso_c_binding
  use fortran_libgd
  implicit none

  type(c_ptr)    :: source_png , my_gif
  type(c_ptr)    :: src, dst
  integer(c_int) :: angle
  integer(c_int) :: error_code

  source_png = gd_fopen("inpics/smileyguy.png"//c_null_char, "rb"//c_null_char)
  my_gif     = gd_fopen("outpics/animation.gif"//c_null_char, "wb"//c_null_char)
  src        = gdImageCreateFromPng(source_png)
  
  do angle=0_c_int, 360_c_int
     dst = gdImageCreate(100,100)
     call gdImageCopyRotated(dst, src, 50.0_c_double, 50.0_c_double,0_c_int,0_c_int,&
          100_c_int, 100_c_int, angle)
     if (angle .eq. 0_c_int) then
        call gdImageGifAnimBegin(dst, my_gif,1_c_int, 0_c_int)   
     else
        call gdImageGifAnimAdd (dst, my_gif, 1_c_int, 0_c_int, 0_c_int, 4,gdDisposalNone, c_null_ptr)
     endif
     call gdImageDestroy(dst)
  enddo

  call gdImageGifAnimEnd(my_gif)

  error_code = gd_fclose(source_png)
  error_code = gd_fclose(my_gif)

end program animation

  
  
