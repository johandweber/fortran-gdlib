program test_im_int_array
  use, intrinsic:: iso_c_binding
  use, intrinsic:: iso_fortran_env
  use fortran_libgd
  implicit none
  integer, parameter :: red_threshold = 10
  real,    parameter :: red_factor=3.0
  type(c_ptr):: in_im, out_im
  type(c_ptr):: output_file
  integer(c_int), dimension(:,:,:), allocatable :: pixel_array
  integer(c_int):: x_counter, y_counter, greyvalue, closestatus

  in_im = gdImageCreateFromFile("inpics/Scardinius.jpg"//c_null_char)

  if (.not. c_associated(in_im)) then
     write(ERROR_UNIT,*) "Could not load file inpics/Scardinus.jpg"
     stop
  endif
 
  out_im = gdImageCreateTrueColor(gdImageSx(in_im), gdImageSy(in_im))

  allocate(pixel_array(1:3, 0:gdImageSx(in_im)-1,  0:gdImageSy(in_im)-1))

  call gdReadIntArrayFromIm(in_im, pixel_array,&
                            gdImageSx(in_im), gdImageSy(in_im))

  do y_counter=0,gdImageSy(in_im)-1
     do x_counter=0,gdImageSx(in_im)-1
        if ( pixel_array(1,x_counter,y_counter) / (pixel_array(2,x_counter,y_counter)+0.001) .le. red_factor&
            .and. &
            pixel_array(1,x_counter,y_counter) / (pixel_array(3,x_counter,y_counter)+0.001) .le. red_factor)  then
           greyvalue = sum (pixel_array(:, x_counter, y_counter))/3
           pixel_array(:, x_counter, y_counter) = greyvalue           
        endif
     end do
  end do
  
  call gdWriteImFromIntArray(out_im, pixel_array, gdImageSx(out_im),gdImageSy(out_im) )

  output_file = gd_fopen('outpics/thanksforthefish.jpg'//c_null_char, 'wb'//c_null_char)

  call gdImageJpeg(out_im, output_file, -1_c_int)

  closestatus = gd_fclose(output_file)
end program test_im_int_array
