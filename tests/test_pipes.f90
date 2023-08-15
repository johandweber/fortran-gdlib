program test_pipes
  use, intrinsic:: iso_c_binding
  use fortran_libgd
  implicit none

  integer(c_int), parameter:: w = 320_c_int
  integer(c_int), parameter:: h = 240_c_int

  integer(c_int)    :: return_code
  integer(c_size_t) :: count

  type(c_ptr) :: im, inpipe, outpipe

  integer(c_int8_t) :: pipematrix(1:3, 0:w-1, 0:h-1)
  integer(c_int8_t) :: pipematrix_linear(3*w*h)
  integer(c_int)    :: workmatrix(1:3, 0:w-1, 0:h-1)

  integer(c_int)   :: x_counter, y_counter
  integer(c_int)   :: yellow
  integer(c_int)   :: r, g, b
  
  integer:: frame_counter = 1

  integer(c_int), dimension(0:7) ::imagerect
  imagerect=[0,0,319,0,319,239,0,239]

  im = gdImageCreateTrueColor(w, h)

  yellow = gdImageColorAllocate(im, 255_c_int, 255_c_int, 0_c_int)

  inpipe = gd_popen("ffmpeg -i inpics/swans.mp4 -f image2pipe"//&
       " -vcodec rawvideo -pix_fmt rgb24 -"//c_null_char, "r"//c_null_char)

  if ( .not. c_associated(inpipe) ) &
       stop 'Could not open input pipe. Is ffmpeg in your executable path?'
  
  outpipe = gd_popen("ffmpeg -y -f rawvideo"//&
       " -vcodec rawvideo -pix_fmt rgb24 -s 320x240 -r 25 -i -"//&
       " -f mp4 -q:v 5 -an -vcodec mpeg4 outpics/purplewater.mp4"//c_null_char, "w"//c_null_char)

  if ( .not. c_associated(outpipe) ) &
      stop 'Could not open outpup pipe. Is ffmpeg in your executable path?'
       

  print*, "start loop"
  do while(.true.)
     count = gd_fread_rawdata_matrix(pipematrix_linear,w,h,inpipe)
     if (count .ne. 3*w*h)&
          exit
     print*
     pipematrix = reshape(pipematrix_linear,(/3,w,h/));
     call gdUInt8ArrayToIntArray(pipematrix, workmatrix, w, h)
     
     do y_counter=0,gdImageSy(im)-1
        do x_counter=0,gdImageSx(im)-1
           
           r =  workmatrix(1, x_counter, y_counter)
           g =  workmatrix(2, x_counter, y_counter)
           b =  workmatrix(3, x_counter, y_counter)
              
           workmatrix(1, x_counter, y_counter) =  b
           workmatrix(2, x_counter, y_counter) =  r
           workmatrix(3, x_counter, y_counter) =  g
              
        end do
     end do

     call gdWriteImFromIntArray(im, workmatrix, w, h)

     call gdImageStringFT(im, imagerect, yellow,"/usr/share/fonts/opentype/freefont/FreeSans.otf"//c_null_char , &
          16._c_double, 0._c_double ,10,20,"Fortran TV"//c_null_char)
     call gdImageSetThickness(im, 3)
     call gdImageLine(im, 0, 120, 319, 120, yellow)
     call gdimageLine(im, 160, 0, 160, 239, yellow)
     
     call gdReadIntArrayFromIm(im, workmatrix, w, h)
     
     write(*,*) 'Workmatrix(1,0,0) :', workmatrix(1,0,0)
     call gdIntArrayToUInt8Array(workmatrix,pipematrix,w,h) 

     count= gd_fwrite_rawdata_matrix(pipematrix,w,h, outpipe)
     write(*,*) "Count = ",count
     if (count .ne. 3*w*h)then
        write(*,*) 'Could not write in pipe'
        stop
     endif
     write(*,*) 'Frame #', frame_counter
     frame_counter = frame_counter+1
   enddo
  
  return_code = gd_fflush(inpipe)
  return_code = gd_pclose(inpipe)
  return_code = gd_fflush(outpipe)
  return_code = gd_pclose(outpipe)

end program test_pipes
