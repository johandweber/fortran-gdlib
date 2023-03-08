program test_edge
  use iso_c_binding, only:  c_ptr, c_int
  use fortran_libgd
  implicit none

  type(c_ptr) :: im            ! image pointer
  type(c_ptr) :: output_image  ! file pointer  

  integer(c_int) :: status

  
  im= gdImageCreateFromFile("inpics/flowers.jpg"//c_null_char)

  status=gdImageEdgeDetectQuick(im)

  output_image =gd_fopen('outpics/flowers_edge.jpg'//c_null_char, 'wb'//c_null_char)
  call gdImageJpeg(im, output_image, -1)

  status = gd_fclose(output_image)
  
end program test_edge
