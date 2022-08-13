module fortran_libgd
  use iso_c_binding
  implicit none  
  interface

     function gd_fopen(filename, modus) bind(c, name = 'fopen')
       import::  c_ptr, c_char
       implicit none
       type(c_ptr) :: gd_fopen
       character(kind= c_char),   intent(in) :: filename(*), modus(*) 
     end function gd_fopen

     function gd_fclose(filepointer) bind(c, name = 'fclose')
       import:: c_ptr,c_int
       implicit none
       type(c_ptr), value  :: filepointer
       integer(c_int) :: gd_fclose
     end function gd_fclose

     function gdImageCreate(xsize, ysize) bind(c, name = 'gdImageCreate')
       import:: c_ptr, c_int
       implicit none
       type(c_ptr) :: gdImageCreate
       integer(c_int), value :: xsize, ysize
     end function gdImageCreate


     function gdImageCreateTrueColor(xsize, ysize) bind(c, name = 'gdImageCreateTrueColor')
       import:: c_ptr, c_int
       implicit none
       type(c_ptr) :: gdImageCreateTrueColor
       integer(c_int), value :: xsize, ysize
     end function gdImageCreateTrueColor
     

     subroutine gdImageDestroy(imagepointer) bind(c, name = 'gdImageDestroy')
       import:: c_ptr
       implicit none
       type(c_ptr), value :: imagepointer
     end subroutine gdImageDestroy

     function gdImageColorAllocate (imagepointer, r, g, b) bind(c, name = 'gdImageColorAllocate')
       import c_int, c_ptr
       implicit none
       integer(c_int) :: gdImageColorAllocate
       type(c_ptr), value :: imagepointer
       integer(c_int), value :: r, g, b
     end function gdImageColorAllocate

     function gdImageColorAllocateAlpha (imagepointer, r, g, b, a) bind(c, name = 'gdImageColorAllocateAlpha')
       import c_int, c_ptr
       implicit none
       integer(c_int) :: gdImageColorAllocateAlpha
       type(c_ptr), value :: imagepointer
       integer(c_int), value :: r, g, b, a
     end function gdImageColorAllocateAlpha


     subroutine gdImageLine (imagepointer, x1, y1, x2, y2, color) bind(c, name = 'gdImageLine')
       import c_int, c_ptr
       implicit none
       type(c_ptr)   , value :: imagepointer
       integer(c_int), value :: x1, y1, x2, y2, color
     end subroutine gdImageLine

     subroutine gdImagePng (imagepointer, filepointer) bind(c, name= 'gdImagePng')
       import c_ptr
       implicit none
       type(c_ptr), value :: imagepointer
       type(c_ptr), value :: filepointer
     end subroutine gdImagePng

     subroutine gdImageJpeg (imagepointer, filepointer, quality) bind(c, name= 'gdImageJpeg')
       import c_ptr, c_int
       implicit none
       type(c_ptr), value :: imagepointer
       type(c_ptr), value :: filepointer
       integer(c_int), value :: quality
     end subroutine gdImageJpeg
        
  end interface
  
end module fortran_libgd


