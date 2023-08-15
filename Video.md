#Video manipulation using FFMPEG and fortran-gdlib

Using [FFMPG](https://www.ffmpeg.org/) it is also possible to use GDlib - and
consequently fortran-gdlib - to manipulate videos .

To do so a pipe from (for input) and another pipe to ffmpeg are created.
The advantage of this approach is that the internals of the codecs do not 
have to be known to the program acting as "filter", if the ffmpeg takes care of the the
conversion of the input data into raw data that can be handled
by the 'filter'. After the manipulation is done, ffmpe3g re-encode the raw output.

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

The array ```ẁorkmatrix````has the same shape as ```pipematrix``` but stores the values in 
32-bit integer numbers. (The color-values are remapped to the range 0...255).

