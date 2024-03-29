# Video manipulation using FFMPEG and fortran-gdlib

Using [FFMPG](https://www.ffmpeg.org/) it is also possible to use GDlib - and
consequently fortran-gdlib - to manipulate videos .

To do so a pipe from (for input) and another pipe to ffmpeg are created.
The advantage of this approach is that the internals of the codecs do not 
have to be known to the program acting as "filter", if the ffmpeg takes care of the the
conversion of the input data into raw data that can be handled
by the 'filter'. After the manipulation is done, FFMPEG re-encodes the raw output.

Of course, it is also possible to use ffmpeg only for the input of data.

An detailed explanation on the basis of a test program is given in in a 
![here](Video.md).

The method described there is based on a 
excellent [blog entry](https://batchloaf.wordpress.com/2017/02/12/a-simple-way-to-read-and-write-audio-and-video-files-in-c-using-ffmpeg-part-2-video/) 
by Ted Burke which in turn was inspired by
a [Python solution](http://zulko.github.io/blog/2013/09/27/read-and-write-video-frames-in-python-using-ffmpeg/) by Zulko.

While Ted Burke was so kind to give me permission to use his Code as a template for my Fortran example,
all bugs are purely my own...

Now let's look at the example program step by step.

```fortran
program test_pipes
  use, intrinsic:: iso_c_binding
  use fortran_libgd
  implicit none
```

Besides the libgd module '''fortran_libgd''' we also use the intrinsic module
```iso_c_binding``` to make sure our data types are compatible with LibGD, which is
a C library.

```fortran
  integer(c_int), parameter:: w = 320_c_int
  integer(c_int), parameter:: h = 240_c_int
```
Here we define the width ```w``` and the height ```h``` of the video in pixels.

```fortran
  integer(c_int)    :: return_code
  integer(c_size_t) :: count
```
Helper variables that will be explained below.

```fortran
  type(c_ptr) :: im, inpipe, outpipe
```
Pointers for the GD Image Handle ```ìm``` and the file pointers for the
input and output pipes.

```fortran
  integer(c_int8_t) :: pipematrix(1:3, 0:w-1, 0:h-1)
  integer(c_int8_t) :: pipematrix_linear(3*w*h)
  integer(c_int)    :: workmatrix(1:3, 0:w-1, 0:h-1)
```
Arrays that  represent different stages of the pre-processing of the input data.
The video data data are first read (in steps reprenting a single image frame) 
from the pipe into the array ```pipematrix_linear````,
which consists of 8-bit integer values representing the red, green and blue values of
one image frame.

These data are then reshaped into the 3-dimensional array pipematrix, where the first
dimension represents the color channel (1 = red, 2 = green, 3 = blue) the width and the 
height. Note that the arrays for the width and the height start with 0 instead of 1.
The reason is consistency with the C implementation.
Note that Fortran does not support unsigned integers. SO the color range 0...255 is mapped to
-128...127 using two's complement.

The array ```ẁorkmatrix``` has the same shape as ```pipematrix``` but stores the values in 
32-bit integer numbers. (The color-values are remapped to the range 0...255).
This requires additional memory, but being able to store positive numbers between 0 ands 255
leads to a more convenient way to manipulate the data.

```fortran
  integer(c_int)   :: x_counter, y_counter
  integer(c_int)   :: yellow
  integer(c_int)   :: r, g, b
```

```x_counter``` and ```y_counter``` are counters for the pixel in ```x```- and ```y```-direction.
```yellow``` stores the color value for yellow.

```r```, ```g``` and ```b``` store the values for the red, green, and blue color channel.

```fortran
  integer:: frame_counter = 1
```

```frame_counter``` is a counter variable for the image frames

```fortran
  integer(c_int), dimension(0:7) ::imagerect
  imagerect=[0,0,319,0,319,239,0,239]  
```
The array ```imagerect``` defines the relevant window for the font output.
In this case this corresponds to the entire image.

```fortran
  im = gdImageCreateTrueColor(w, h)

  yellow = gdImageColorAllocate(im, 255_c_int, 255_c_int, 0_c_int)
```
Here an image handler that will store the frames (with with ```w``` and height ```h```) 
is saved in the variable ```im```.
Furthermore the variable ```yellow``` is defined as the rgb-vlaues of the color yellow.

```fortran
  inpipe = gd_popen("ffmpeg -i inpics/swans.mp4 -f image2pipe"//&
       " -vcodec rawvideo -pix_fmt rgb24 -"//c_null_char, "r"//c_null_char)

  if ( .not. c_associated(inpipe) ) &
       stop 'Could not open input pipe. Is ffmpeg in your executable path?'

```
```gf_popen```is a wrapper aroung the C ```popen```(Unix-like systems) or ```_popen``` (Windows)
function to open pipes.

Here the input pipe is defined. Here FFMPEG takes the MP4 file inpics/swans.mp3 and converts
it into a uncompressed raw stream where each pixel is described by one byte for the red, green and
blue channel respectively.

If opening the pipe is not successful, the program stops with an error message.

```fortran
  outpipe = gd_popen("ffmpeg -y -f rawvideo"//&
       " -vcodec rawvideo -pix_fmt rgb24 -s 320x240 -r 25 -i -"//&
       " -f mp4 -q:v 5 -an -vcodec mpeg4 outpics/purplewater.mp4"//c_null_char, "w"//c_null_char)

  if ( .not. c_associated(outpipe) ) &
      stop 'Could not open outpup pipe. Is ffmpeg in your executable path?'
```
Here the pipe for the output, where FFMPEG  reconferts the RAW output stream into the MP4 file
```outpics/purplewater```.

*Note:* I am not an expert in the usage of FFMPEG. So the details of the command-line options will
not be explained here. Instaed I refer to Ted Burke's blog or the - for variations - to the original
FFMPEG documentation.

```fortran  
  outpipe = gd_popen("ffmpeg -y -f rawvideo"//&
       " -vcodec rawvideo -pix_fmt rgb24 -s 320x240 -r 25 -i -"//&
       " -f mp4 -q:v 5 -an -vcodec mpeg4 outpics/purplewater.mp4"//c_null_char, "w"//c_null_char)

  if ( .not. c_associated(outpipe) ) &
      stop 'Could not open outpup pipe. Is ffmpeg in your executable path?'
```
Definition of the output pipe.

```fortran
  print*, "start loop"
  do while(.true.)
     count = gd_fread_rawdata_matrix(pipematrix_linear,w,h,inpipe)
     if (count .ne. 3*w*h)&
          exit
     print*
```
Not the loop over the image frames is started. It is realized as an endless loop.
The function ```gd_fread_rawdata_matrix``` reads from the input pipe and saves 
the data into the array ```pipematrix_linear```. It returns the number of bytes read.
If the result differs from ```3*w*h```, this means that the pipe is fully read
and the loop can be left using the ```exit````command.

```fortran
    pipematrix = reshape(pipematrix_linear,(/3,w,h/));
    call gdUInt8ArrayToIntArray(pipematrix, workmatrix, w, h)
```
Now the previously described arrays ```pipematrix``` and ```workmatrix``` are filled.
 
```fortran
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
```
Here the blue value of the input pipe is mapped to the red value of the output pipe,
the red value of the input pipe to the green value of the output pipe,
and the green channel of the input pipe to the blue value of the output pipe. 
Note that these operations are not implemented using GDlib, but are pure per-pixel
manipulations.

```fortran
     call gdWriteImFromIntArray(im, workmatrix, w, h)
```
Here the pixel values from ```workmatrix``` are read into the structure referenced by the pointer
```im``` using the subroutine ```call gdWriteImFromIntArray```. Additionaly, the width and the 
height of the image frame have to be provided.

```fortran
     call gdImageStringFT(im, imagerect, yellow,"/usr/share/fonts/opentype/freefont/FreeSans.otf"//c_null_char , &
          16._c_double, 0._c_double ,10,20,"Fortran TV"//c_null_char)
     call gdImageSetThickness(im, 3)
     call gdImageLine(im, 0, 120, 319, 120, yellow)
     call gdimageLine(im, 160, 0, 160, 239, yellow)
```
Here  the String "Fortran TV" and a cross with line width 3 are added to each image frame. In this example
the manipulation is the same for each frame, but it is also possible to change the manipulation from 
frame to frame.

```fortran
     call gdReadIntArrayFromIm(im, workmatrix, w, h)
```
Now the pixel values of ```im``` are written back into the array ```workmatrix```. 

```fortran
     write(*,*) 'Workmatrix(1,0,0) :', workmatrix(1,0,0)
     call gdIntArrayToUInt8Array(workmatrix,pipematrix,w,h)

     count= gd_fwrite_rawdata_matrix(pipematrix,w,h, outpipe)
     write(*,*) "Count = ",count
     if (count .ne. 3*w*h) then
        write(*,*) 'Could not write in pipe'
        stop
     endif
     write(*,*) 'Frame #', frame_counter
     frame_counter = frame_counter+1
   enddo
```
In the subroutine ```gdIntArrayToUInt8Array```  the array ```workmatrix``` is transferred into the array ```pipematrix```, where each color value is represented by a 8-bit integer value (using two's compliment, so althoug the data type is signed, the
bit pattern corresponds to the one of a 8-bit unsigned values whose number equals the 32bit integer value of the array
```workmatrix```).

The function ```gd_fwrite_rawdata_matrix``` writes the array ```pipematrix``` to the output pipe and returns the
number of written bytes. If the value differs from the expected value of three times the width in pixels times the
height in pixels, the program terminates with an error message.
The frame counter is now increaed by one and the loop starts again.

```fortran
  return_code = gd_fflush(inpipe)
  return_code = gd_pclose(inpipe)
  return_code = gd_fflush(outpipe)
  return_code = gd_pclose(outpipe)

end program test_pipes
```

Finally the pipes are flushed and closed.
*Note:* It is important to use the C-wrappers ```gd_fflush``` and ```gd_pclose``` 
instead of similar Fortran commands/functions, because the C library GD-lib requires a C-style file handling. 


