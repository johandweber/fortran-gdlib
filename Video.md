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
  use, intrinsic:: iso_fortran_env
  use fortran_libgd
  implicit none
```
