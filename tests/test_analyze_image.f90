program test_analyze_image
  use iso_c_binding,  only: c_ptr, c_int, c_null_char, c_associated
  use iso_fortran_env, only: error_unit
  use fortran_libgd
  implicit none

  ! Declare the image  
  type(c_ptr)   :: im

  im = gdImageCreateFromFile("inpics/flowers.jpg"//c_null_char)

  call write_statistics(im)

  call separate_color_channels(im)

  
contains

  subroutine write_statistics(im)
    implicit none
    type(c_ptr), value:: im
    write(*,*) 'GD major version : ', gdMajorVersion()
    write(*,*) 'GD minor version : ', gdMinorVersion()
    write(*,*) 'GD release version : ',gdReleaseVersion()  
    write(*,*) 'Size in pixels (x-direction) :', gdImageSX(im)
    write(*,*) 'Size in pixels (y-direction) :', gdImageSY(im)
    write(*,*) 'Resolution in dpi (x-direction) :', gdImageResolutionX(im)
    write(*,*) 'Resolution in dpi (y-direction) :', gdImageResolutionY(im)       
  end subroutine write_statistics

  subroutine separate_color_channels(im)
    implicit none
    type(c_ptr), value:: im
    type(c_ptr):: red, green, blue
    type(c_ptr):: redout, greenout, blueout
    integer(c_int):: x,y
    integer(c_int):: redval, greenval, blueval
    integer(c_int):: closestatus

    red   = gdImageCreateTrueColor(gdImageSx(im), gdImageSY(im))
    green = gdImageCreateTrueColor(gdImageSx(im), gdImageSY(im))
    blue  = gdImageCreateTrueColor(gdImageSx(im), gdImageSY(im))

    do x = 0, gdImageSx(im) - 1
       do y = 0, gdImageSy(im) -1
          redval=gdImageRed(im,gdImageGetTrueColorPixel(im, x,y))*256_c_int*256_c_int
          greenval=gdImageGreen(im,gdImageGetTrueColorPixel(im, x,y))*256_c_int
          blueval=gdImageBlue(im,gdImageGetTrueColorPixel(im, x,y))

          call gdImageSetPixel(red,x,y,redval)
          call gdImageSetPixel(green,x,y,greenval)
          call gdImageSetPixel(blue,x,y,blueval)
          
       enddo
    end do

    redout = gd_fopen('outpics/flowers_red.jpg'//c_null_char,'wb'//c_null_char)
    greenout = gd_fopen('outpics/flowers_green.jpg'//c_null_char,'wb'//c_null_char)
    blueout = gd_fopen('outpics/flowers_blue.jpg'//c_null_char,'wb'//c_null_char)

    call gdImageJpeg(red,redout, -1_c_int)
    call gdImageJpeg(green,greenout, -1_c_int)
    call gdImageJpeg(blue,blueout, -1_c_int)
    
    closestatus = gd_fclose(redout)
    closestatus = gd_fclose(greenout)
    closestatus = gd_fclose(blueout)
    
  end subroutine separate_color_channels
  
end program test_analyze_image
