! This is just a "translation" of the cfirst example of the GD lib C
! documentation at https://libgd.github.io/manuals/2.3.3/files/preamble-txt.html
! to the Fortran language
!
! All bugs are my own

program test_fortran_gd
  use iso_c_binding,  only: c_ptr, c_int, c_null_char, c_associated
  use iso_fortran_env, only: error_unit
  use fortran_libgd
  implicit none

  real, parameter :: PI = 3.14159265359 

  integer(c_int), parameter:: corners=30
  
  ! Declare the image  
  type(c_ptr)   :: im

  ! Declare output files
  type (c_ptr)  :: pngout

  ! Fontpointer
  type(c_ptr)    :: giant, large, mediumbold, small, tiny

  ! Declare color indexes  
  integer(c_int):: white, black, yellow, red, blue, green, magenta, cyan,&
                   grey, orange

  integer(c_int):: closestatus
  integer(c_int):: fromcounter, tocounter, from_x, from_y,to_x, to_y

  character(len=100):: tempstring

 
  im = gdImageCreate(1280_c_int, 950_c_int)
  
  black   =  gdImageColorAllocate(im, 0_c_int, 0_c_int, 0_c_int)
  white   =  gdImageColorAllocate(im, 255_c_int, 255_c_int, 255_c_int)
  
  giant      = gdFontGetGiant()
  
  pngout = gd_fopen("outpics/polygon.png"//c_null_char, "wb"//c_null_char)
  if(.not. c_associated (pngout)) then
     write(error_unit,*) 'Error: Could not open inpics/test_extended.png. '
  endif

  do fromcounter = 0,corners-1
     from_x= int(475.0+450*cos(1.0*fromcounter*2.0*pi/corners), kind= c_int)
     from_y= int(475.0+450*sin(1.0*fromcounter*2.0*pi/corners), kind= c_int)    
     do tocounter = 0, corners-1
        to_x= int(475.0+450*cos(1.0*tocounter*2.0*pi/corners), kind= c_int)
        to_y= int(475.0+450*sin(1.0*tocounter*2.0*pi/corners), kind= c_int)
        call gdImageLine(im, from_x, from_y, to_x, to_y, white) 
     enddo
  enddo

  call gdImageLine(im, 950_c_int, 0_c_int, 950_c_int, 950_c_int, white)

  call gdImageString(im, giant, 960_c_int, 20_c_int, 'Number of corners:'//c_null_char,&
       white)
  write(tempstring,*) corners
  tempstring = trim(adjustl(tempstring)) // c_null_char
  call gdImageString(im, giant, 960_c_int, 40_c_int, tempstring, white)
    
  call gdImageString(im, giant, 960_c_int, 70_c_int, 'Number of Diagonals:'//c_null_char,&
       white)
  write(tempstring,*) (corners-2)*(corners-3)
  tempstring = trim(adjustl(tempstring)) // c_null_char
  call gdImageString(im, giant, 960_c_int, 90_c_int, tempstring, white)
  
  call gdImageString(im, giant, 960_c_int, 120_c_int, 'Sum of internal angles in degrees:'//c_null_char,&
                     white)
  write(tempstring,*) 180*(corners-2)
  tempstring = trim(adjustl(tempstring)) // c_null_char
  call gdImageString(im, giant, 960_c_int, 140_c_int, tempstring, white)
 
  call gdImagePng(im, pngout)
 
  closestatus = gd_fclose(pngout)
  
end program test_fortran_gd
