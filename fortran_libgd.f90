module fortran_libgd
  use iso_c_binding
  implicit none

  integer(c_int), parameter :: gdArc                     =    0_c_int,&
                               gdPie                     =    0_c_int,&
                               gdChord                   =    1_c_int,&
                               gdNoFill                  =    2_c_int,&
                               gdEdged                   =    4_c_int,&
                               gdAlphaMax                =  127_c_int,&
                               gdAlphaOpaque             =    0_c_int,&
                               gdAlphaTransparent        =  127_c_int,&
                               gdRedMax                  =  255_c_int,&
                               gdGreenMax                =  255_c_int,&
                               gdBlueMax                 =  255_c_int,&
                               gdMaxColors               =  255_c_int,&
                               gdEffectReplace           =    0_c_int,&
                               gdEffectAlphaBlend        =    1_c_int,&
                               gdEffectNormal            =    2_c_int,&
                               gdEffectOverlay           =    3_c_int,&
                               gdEffectMultiply          =    4_c_int,&
                               GD_TRUE                   =    1_c_int,&
                               GD_FALSE                  =    0_c_int,&
                               gdStyled                  =   -2_c_int,&
                               gdBrushed                 =   -3_c_int,&
                               gdStyledBrushed           =   -4_c_int,&
                               gdTiled                   =   -5_c_int,&
                               gdTransparent             =   -6_c_int,&
                               gdAntiAliased             =   -7_c_int,&
                               gdFTEX_LINESPACE          =    1_c_int,&
                               gdFTEX_CHARMAP            =    2_c_int,&
                               gdFTEX_RESOLUTION         =    4_c_int,&
                               gdFTEX_DISABLE_KERNING    =    8_c_int,&
                               gdFTEX_XSHOW              =   16_c_int,&
                               gdFTEX_FONTPATHNAME       =   32_c_int,&
                               gdFTEX_FONTCONFIG         =   64_c_int,&
                               gdFTEX_RETURNFONTPATHNAME =   128_c_int,&
                               gdFTEX_Unicode            =     0_c_int,&
                               gdFTEX_shift_JIS          =     1_c_int,&
                               gdFTEX_Big5               =     2_c_int,&
                               gdFTEX_Adobe_Custom       =     3_c_int,&
                               GD_CMP_IMAGE              =     1_c_int,&
                               GD_CMP_NUM_COLORS         =     2_c_int,&
                               GD_CMP_COLOR              =     4_c_int,&
                               GD_CMP_SIZE_X             =     8_c_int,&
                               GD_CMP_SIZE_Y             =    16_c_int,&
                               GD_CMP_TRANSPARENT        =    32_c_int,&
                               GD_CMP_BACKGROUND         =    64_c_int,&
                               GD_CMP_INTERLACE          =   128_c_int,&
                               GD_CMP_TRUECOLOR          =   256_c_int,&
                               GD_RESOLUTION             =    92_c_int

  real(c_double), parameter::  GD_EPSILON                = 1e-6_c_double,&
                               GD_M_PI                   = 3.14159265358979323846_c_double
                                                               
     ! for gdInterpolationMethod
     enum, bind (c)
        enumerator:: GD_DEFAULT=0
        enumerator:: GD_BELLL
        enumerator:: GD_BESSEL
        enumerator:: GD_BILINIEAR_FIXED
        enumerator:: GD_BICUBIC
        enumerator:: GD_BICUBIC_FIXED
        enumerator:: GD_BLACKMAN
        enumerator:: GD_BOX
        enumerator:: GD_BSPLINE
        enumerator:: GD_CATMULLROM
        enumerator:: GD_GAUSSIAN
        enumerator:: GD_GENERALIZED_CUBIC
        enumerator:: GD_HERMITE
        enumerator:: GD_HAMMING
        enumerator:: GD_HANNING
        enumerator:: GD_MITCHELL
        enumerator:: GD_NEAREST_NEIGHBOUR
        enumerator:: GD_POWER
        enumerator:: GD_QUADRATIC
        enumerator:: GD_SINC
        enumerator:: GD_TRIANGLE
        enumerator:: GD_WEIGHTED4
        enumerator:: GD_LINEAR
        enumerator:: GD_METHOD_COUNT=23
     end enum

     ! for gdAffineStandardMatrix
     enum, bind(c)
        enumerator:: GD_AFFINE_TRANSLATE = 0
        enumerator:: GD_AFFINE_SCALE
        enumerator:: GD_AFFINE_ROTATE
        enumerator:: GD_AFFINE_SHEAR_HORIZONTAL
        enumerator:: GD_AFFINE_SHEAR_VERTICAL
     end enum

     ! for gdPaletteQuantizationMethod
     enum, bind(c)
        enumerator:: GD_QUANT_DEFAUALT = 0
        enumerator:: GD_QUANT_JQUANT   = 1
        enumerator:: GD_NEUQUANT       = 2
        enumerator:: GD_QUANT_LIQ      =3
     end enum

     ! Group: GifAnim
     enum, bind(c)
        enumerator:: gdDisposalUnknown
        enumerator:: gdDisposalNone
        enumerator:: gdDisposalRestoreBackground
        enumerator:: gdDisposalRestorePrevious
     end enum

     !for gdCropMode
     enum, bind(c)
        enumerator:: GD_CROP_DEFAULT = 0
        enumerator:: GD_CROP_TRANSPARENT
        enumerator:: GD_CROP_BLACK
        enumerator:: GD_CROP_WHITE
        enumerator:: GD_CROP_SIDES
        enumerator:: GD_CROP_THRESHOLD
     end enum
  
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
     
     subroutine gdImageDestroy(im) bind(c, name = 'gdImageDestroy')
       import:: c_ptr
       implicit none
       type(c_ptr), value :: im
     end subroutine gdImageDestroy

     function gdImageColorAllocate (im, r, g, b) bind(c, name = 'gdImageColorAllocate')
       import c_int, c_ptr
       implicit none
       integer(c_int) :: gdImageColorAllocate
       type(c_ptr), value :: im
       integer(c_int), value :: r, g, b
     end function gdImageColorAllocate

     function gdImageColorAllocateAlpha (im, r, g, b, a) bind(c, name = 'gdImageColorAllocateAlpha')
       import c_int, c_ptr
       implicit none
       integer(c_int) :: gdImageColorAllocateAlpha
       type(c_ptr), value :: im
       integer(c_int), value :: r, g, b, a
     end function gdImageColorAllocateAlpha

     subroutine gdImageLine (im, x1, y1, x2, y2, color) bind(c, name = 'gdImageLine')
       import c_int, c_ptr
       implicit none
       type(c_ptr)   , value :: im
       integer(c_int), value :: x1, y1, x2, y2, color
     end subroutine gdImageLine

    subroutine gdImageDashedLine (im, x1, y1, x2, y2, color) bind(c, name = 'gdImageDashedLine')
       import c_int, c_ptr
       implicit none
       type(c_ptr)   , value :: im
       integer(c_int), value :: x1, y1, x2, y2, color
     end subroutine gdImageDashedLine
     
    subroutine gdImageRectangle (im, x1, y1, x2, y2, color) bind(c, name = 'gdImageRectangle')
       import c_int, c_ptr
       implicit none
       type(c_ptr)   , value :: im
       integer(c_int), value :: x1, y1, x2, y2, color
     end subroutine gdImageRectangle
      
    subroutine gdImageFilledRectangle (im, x1, y1, x2, y2, color) bind(c, name = 'gdImageFilledRectangle')
       import c_int, c_ptr
       implicit none
       type(c_ptr)   , value :: im
       integer(c_int), value :: x1, y1, x2, y2, color
     end subroutine gdImageFilledRectangle
    
    
    subroutine gdImageEllipse (im, mx, my, w, h, color) bind(c, name = 'gdImageEllipse')
       import c_int, c_ptr
       implicit none
       type(c_ptr)   , value :: im
       integer(c_int), value :: mx, my, w, h, color
     end subroutine gdImageEllipse
      
    subroutine gdImageFilledEllipse (im, mx, my, w, h, color) bind(c, name = 'gdImageFilledEllipse')
       import c_int, c_ptr
       implicit none
       type(c_ptr)   , value :: im
       integer(c_int), value :: mx, my, w, h, color
     end subroutine gdImageFilledEllipse

    subroutine gdImageArc (im, mx, my, w, h, a1, a2, color) bind(c, name = 'gdImageArc')
       import c_int, c_ptr
       implicit none
       type(c_ptr)   , value :: im
       integer(c_int), value :: mx, my, w, h, a1, a2, color
     end subroutine gdImageArc

    subroutine gdImageFilledArc (im, mx, my, w, h, a1, a2, color, s) bind(c, name = 'gdImageFilledArc')
       import c_int, c_ptr
       implicit none
       type(c_ptr)   , value :: im
       integer(c_int), value :: mx, my, w, h, a1, a2, color,s 
     end subroutine gdImageFilledArc
     

     subroutine gdImageFill (im, x,y , color) bind(c, name = 'gdImageFill')
       import c_int, c_ptr
       implicit none
       type(c_ptr)   , value :: im
       integer(c_int), value :: x,y , color
     end subroutine gdImageFill

     subroutine gdImageString (im, fontpointer, x,y, s, color)&
          bind(c, name='gdImageString')
       import c_int, c_char, c_ptr
       implicit none
       type(c_ptr), value        :: im
       type(c_ptr), value        :: fontpointer
       integer(c_int),value      :: x,y
       character(kind= c_char),   intent(in) :: s(*)       
       integer(c_int), value     :: color
     end subroutine gdImageString
     
     subroutine gdImagePng (im, filepointer) bind(c, name = 'gdImagePng')
       import c_ptr
       implicit none
       type(c_ptr), value :: im
       type(c_ptr), value :: filepointer
     end subroutine gdImagePng
     
     subroutine gdImageJpeg (im, filepointer, quality) bind(c, name = 'gdImageJpeg')
       import c_ptr, c_int
       implicit none
       type(c_ptr), value :: im
       type(c_ptr), value :: filepointer
       integer(c_int), value :: quality
     end subroutine gdImageJpeg

     function gdFontGetGiant() bind(c, name = 'gdFontGetGiant')
       import c_ptr
       implicit none
       type(c_ptr) :: gdFontGetGiant
     end function gdFontGetGiant

     function gdFontGetLarge() bind(c, name = 'gdFontGetLarge')
       import c_ptr
       implicit none
       type(c_ptr) :: gdFontGetLarge
     end function gdFontGetLarge
     
     function gdFontGetMediumBold() bind(c, name = 'gdFontGetMediumBold')
       import c_ptr
       implicit none
       type(c_ptr) :: gdFontGetMediumBold
     end function gdFontGetMediumBold
    
     function gdFontGetSmall() bind(c, name = 'gdFontGetSmall')
       import c_ptr
       implicit none
       type(c_ptr) :: gdFontGetSmall
     end function gdFontGetSmall
    
     function gdFontGetTiny() bind(c, name = 'gdFontGetTiny')
       import c_ptr
       implicit none
       type(c_ptr) :: gdFontGetTiny
     end function gdFontGetTiny

     subroutine gdImageSetPixel(im, x, y, color)&
          bind(c, name = 'gdImageSetPixel')
       import c_ptr, c_int
       implicit none
       type(c_ptr), value :: im
       integer(c_int), value :: x,y,color
     end subroutine gdImageSetPixel

     function gdImageGetPixel(im, x, y)&
          bind(c, name = 'gdImageGetPixel')
       import c_ptr, c_int
       implicit none
       integer(c_int) :: gdImageGetPixel
       type(c_ptr):: im
       integer(c_int), value:: x,y
     end function gdImageGetPixel

     function gdImageGetTrueColorPixel (im, x, y)&
           bind(c, name = 'gdImageGetTrueColorPixel')
       import c_ptr, c_int
       implicit none
      integer(c_int):: gdImageGetTrueColorPixel
      type(c_ptr), value:: im
      integer(c_int), value :: x,y
     end function gdImageGetTrueColorPixel

     function gdImageClone(src) bind(c, name = 'gdImageClone')
       import c_ptr, c_int
       implicit none
       type(c_ptr):: gdImageClone
       type(c_ptr), value:: src
     end function gdImageClone

     subroutine gdImageCopy(dst, src, dstX, dstY, srcX, srcY, w, h)&
          bind(c, name = 'gdImageCopy')
       import c_ptr, c_int
       implicit none
       type(c_ptr), value :: dst, src
       integer(c_int), value :: dstX, dstY, srcX, srcY, w ,h
     end subroutine gdImageCopy

     subroutine gdImageCopyMerge(dst, src, dstX, dstY, srcX, srcY, w, h, pct)&
          bind(c, name = 'gdImageCopyMerge')         
       import c_ptr, c_int
       implicit none
       type(c_ptr), value:: dst, src
       integer(c_int), value :: dstX, dstY, srcX, srcY, w ,h, pct
     end subroutine gdImageCopyMerge

     subroutine gdImageCopyMergeGrey(dst, src, dstX, dstY, srcX, srcY, w, h, pct)&
          bind(c, name = 'gdImageCopyMergeGrey')         
       import c_ptr, c_int
       implicit none
       type(c_ptr), value:: dst, src
       integer(c_int), value :: dstX, dstY, srcX, srcY, w ,h, pct
     end subroutine gdImageCopyMergeGrey

     subroutine gdImageCopyResized(dst, src, dstX, dstY, srcX, srcY,&
          dstW, dstH, srcW, srcH) &
          bind(c, name = 'gdImageCopyResized')
       import c_ptr, c_int
       implicit none
       type(c_ptr), value:: dst, src
       integer(c_int), value :: dstX, dstY, srcX, srcY, dstW, dstH, srcW, srcH
     end subroutine gdImageCopyResized

     subroutine gdImageCopyRotated(dst, src, dstX, dstY, srcX, srcY, srcWidth,&
          srcHeight, angle) &
          bind(c, name='gdImageCopyRotated')
       import c_int, c_ptr
       implicit none
       type(c_ptr):: dst, src
       integer(c_int):: dstX, dstY, srcX, srcY, srcWidth, srcHeight, angle
     end subroutine gdImageCopyRotated

     subroutine gdImageCopyResampled(dst, src, dstX, dstY, srcX, srcY,&
          srcW, srcH, angle) &
          bind(c, name='gdImageCopyResampled')
       import c_ptr, c_int
       implicit none
       type(c_ptr):: dst, src
       integer(c_int)::  dstX, dstY, srcX, srcY,srcW, srcH, angle
     end subroutine gdImageCopyResampled
     
     subroutine gdImageStringFT(im, brect, fg, fontlist, ptsize, angle,x,y,string)&
          bind(c, name = 'gdImageStringFT')
       import c_char, c_ptr, c_int, c_double
      implicit none
       type(c_ptr), value:: im
       integer(c_int), dimension (0:7) :: brect
       integer(c_int),value:: fg
       character(kind= c_char),   intent(in) :: fontlist(*)
       real(c_double), value:: ptsize
       real(c_double), value:: angle
       integer(c_int), value:: x
       integer(c_int), value:: y
       character(kind= c_char),   intent(in) :: string(*)     
     end subroutine
     
     subroutine gdFontCacheShutdown() &
          bind(c, name = 'gdFontCacheShutdown')
     end subroutine gdFontCacheShutdown

     function gdMajorVersion() &
          bind(c, name = 'gdMajorVersion')
       import c_int
       implicit none
       integer(c_int) :: gdMajorVersion
     end function gdMajorVersion

     function gdMinorVersion() &
          bind(c, name = 'gdMinorVersion')
       import c_int
       implicit none
       integer(c_int) :: gdMinorVersion
     end function gdMinorVersion

     function gdReleaseVersion() &
          bind(c, name = 'gdReleaseVersion')
       import c_int
       implicit none
       integer(c_int) :: gdReleaseVersion
     end function gdReleaseVersion

     function gdImageCreateFromFile(filename) &
          bind(c, name = 'gdImageCreateFromFile')
       import c_ptr, c_char
       implicit none
       type(c_ptr) :: gdImageCreateFromFile
       character(kind= c_char),   intent(in) :: filename(*)
     end function gdImageCreateFromFile

     function gdImageTrueColor (im) &
       bind(c, name = 'wrap_gdImageTrueColor')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im
       integer(c_int) ::  gdImageTrueColor
     end function gdImageTrueColor

     function gdImageSX (im) &
       bind(c, name = 'wrap_gdImageSX')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im
       integer(c_int) ::  gdImageSX
     end function gdImageSX

     function gdImageSY (im) &
       bind(c, name = 'wrap_gdImageSY')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im
       integer(c_int) ::  gdImageSY
     end function gdImageSY

     function gdImageColorsTotal (im) &
       bind(c, name = 'wrap_gdImageColorsTotal')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im
       integer(c_int) ::  gdImageColorsTotal
     end function gdImageColorsTotal
     
     function gdImageRed (im, c) &
       bind(c, name = ' wrap_gdImageRed')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im
       integer(c_int), value :: c
       integer(c_int) :: gdImageRed
     end function gdImageRed
         
     function gdImageGreen (im, c) &
       bind(c, name = ' wrap_gdImageGreen')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im
       integer(c_int), value :: c
       integer(c_int) :: gdImageGreen
     end function gdImageGreen
         
     function gdImageBlue (im, c) &
       bind(c, name = ' wrap_gdImageBlue')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im
       integer(c_int), value :: c
       integer(c_int) :: gdImageBlue
     end function gdImageBlue
         
     function gdImageAlpha(im, c) &
       bind(c, name = ' wrap_gdImageAlpha')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im
       integer(c_int), value :: c
       integer(c_int) :: gdImageAlpha
     end function gdImageAlpha

     function gdImageGetInterlaced (im) &
       bind(c, name = 'wrap_gdImageGetInterlaced')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im
       integer(c_int) ::  gdImageGetInterlaced 
     end function gdImageGetInterlaced
 
     function gdImagePalettePixel (im,x,y) &
       bind(c, name = 'wrap_gdImagePalettePixel')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im
       integer(c_int), value:: x,y
       integer(c_int) ::  gdImagePalettePixel 
     end function 
 
     function gdImageTrueColorPixel (im,x,y) &
       bind(c, name = 'wrap_gdImageTrueColorPixel')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im 
       integer(c_int), value:: x,y
       integer(c_int) ::  gdImageTrueColorPixel 
     end function gdImageTrueColorPixel

     function gdImageResolutionX (im) &
       bind(c, name = 'wrap_gdImageResolutionX')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im
       integer(c_int) :: gdImageResolutionX 
     end function  gdImageResolutionX

     function gdImageResolutionY (im) &
       bind(c, name = 'wrap_gdImageResolutionY')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im
       integer(c_int) :: gdImageResolutionY 
     end function  gdImageResolutionY

     function gdImageScatter(im, sub, plus) &
          bind(c, name='gdImageScatter')
       import c_ptr, c_int
       implicit none
       integer(c_int):: gdImageScatter
       type(c_ptr), value :: im
       integer(c_int), value:: sub, plus
     end function gdImageScatter

     function gdImageScatterColor(im, sub, plus, colors, num_colors)&
          bind(c, name='gdImageScatterColor')
       import c_ptr, c_int
       implicit none
       integer(c_int):: gdImageScatterColor
       type(c_ptr), value:: im
       integer(c_int), value:: sub, plus, num_colors
       integer(c_int),  intent(in) :: colors(*)
     end function gdImageScatterColor

     function gdImagePixelate(im, block_size, mode)&
          bind(c, name='gdImagePixelate')
       import c_int, c_ptr
       implicit none
       integer(c_int):: gdImagePixelate
       type(c_ptr), value:: im
       integer(c_int), value ::  block_size, mode
     end function gdImagePixelate

     function gdImageNegate(src)&
          bind(c, name='gdImageNegate')
       import c_int, c_ptr
       implicit none
       integer(c_int):: gdImageNegate
       type(c_ptr), value:: src
     end function gdImageNegate

     function gdImageGrayScale(src)&
          bind(c, name='gdImageGrayScale')
       import c_int, c_ptr
       implicit none
       integer(c_int):: gdImageGrayScale
       type(c_ptr), value :: src
     end function gdImageGrayScale
     
      function gdImageBrightness(src, brightness)&
          bind(c, name='gdImageBrightness')
       import c_int, c_ptr
       implicit none
       integer(c_int):: gdImageBrightness
       type(c_ptr):: src
       integer(c_int), value:: brightness
     end function gdImageBrightness

     function gdImageContrast(src, contrast)&
          bind(c, name='gdImageContrast')
       import c_int, c_double, c_ptr
       implicit none
       integer(c_int):: gdImageContrast
       type(c_ptr), value:: src
       real(c_double), value:: contrast
     end function gdImageContrast

     function gdImageColor(src, red, green, blue, alpha)&
          bind(c, name='gdImageColor')
       import c_int, c_ptr
       implicit none
       integer(c_int) :: gdImageColor
       type(c_ptr), value :: src
       integer(c_int), value:: red, green, blue, alpha
     end function gdImageColor

!!$     function gdImageConvolution(src, filter, filter_div, offset)&
!!$          bind(c, name='gdImageConvolution')
!!$       import c_int, c_float, c_ptr
!!$       implicit none
!!$       integer(c_int):: gdImageConvolution
!!$       type(c_ptr):: src
!!$       real(c_float), value:: filter(0:3)
!!$       real(c_float), value:: filter_div, offset
!!$     end function gdImageConvolution

     function gdImageSelectiveBlur(src) &
          bind(c, name='gdImageSelectiveBlur')
       import c_int, c_ptr
       implicit none
       integer(c_int):: gdImageSelectiveBlur
       type(c_ptr), value:: src
     end function gdImageSelectiveBlur

     function gdImageEdgeDetectQuick(src) &
          bind(c, name='gdImageEdgeDetectQuick')
       import c_int, c_ptr
       implicit none
       integer(c_int):: gdImageEdgeDetectQuick
       type(c_ptr), value:: src
     end function gdImageEdgeDetectQuick

    
     function gdImageGaussianBlur(src) &
          bind(c, name='gdImageGaussianBlur')
       import c_int, c_ptr
       implicit none
       integer(c_int):: gdImageGaussianBlur
       type(c_ptr), value:: src
     end function gdImageGaussianBlur

     function gdImageEmboss(src) &
          bind(c, name='gdImageEmboss')
       import c_int, c_ptr
       implicit none
       integer(c_int):: gdImageEmboss
       type(c_ptr), value:: src
     end function gdImageEmboss
     
     function gdImageMeanRemoval(src) &
          bind(c, name='gdImageMeanRemoval')
       import c_int, c_ptr
       implicit none
       integer(c_int):: gdImageMeanRemoval
       type(c_ptr), value:: src
     end function gdImageMeanRemoval
 
     function gdImageSmooth(im, weight) &
          bind(c, name='gdImageSmooth')
       import c_int, c_float, c_ptr
       implicit none
       integer(c_int):: gdImageSmooth
       real(c_float), value:: weight 
       type(c_ptr), value:: im
     end function gdImageSmooth
 
     function gdImageCopyGaussianBlurred(src, radius, sigma) &
          bind(c, name='gdImageCopyGaussianBlurred')
       import c_int, c_double, c_ptr
       implicit none
       integer(c_int):: gdImageCopyGaussianBlurred
       type(c_ptr), value:: src
       integer(c_int), value:: radius
       real(c_double), value:: sigma 
     end function gdImageCopyGaussianBlurred

     subroutine gdImageFlipVertical(im)&
          bind(c, name ='gdImageFlipVertical')
       import c_ptr
       implicit none
       type(c_ptr):: im
     end subroutine gdImageFlipVertical

     subroutine gdImageFlipHorizontal(im)&
          bind(c, name ='gdImageFlipHorizontal')
       import c_ptr
       implicit none
       type(c_ptr):: im
     end subroutine gdImageFlipHorizontal
     
     subroutine gdImageFlipBoth(im)&
          bind(c, name ='gdImageFlipBoth')
       import c_ptr
       implicit none
       type(c_ptr):: im
     end subroutine gdImageFlipBoth
     
     function gdSupportsFileType(filename, writing)&
          bind(c, name='gdSupportsFileTyp')
       import c_char, c_int
       implicit none
       integer(c_int):: gdSupportsFileType
       character(c_char), intent(in) :: filename(*)
       integer(c_int), value:: writing
     end function gdSupportsFileType

     function gdImageFile(im, filename)&
          bind(c, name='gdImageFile')
       import c_char, c_int, c_ptr
       implicit none
       integer(c_int):: gdImageFile
       type(c_ptr), value:: im
       character(c_char), intent(in) :: filename
     end function gdImageFile

     subroutine getImageSetStyle(im, style, noOfPixels)&
          bind(c, name='getImageSetStyle')
       import c_ptr,c_int
       implicit none
       type(c_ptr), value:: im
       integer(c_int), intent(in):: style(*)
       integer(c_int), value:: noOfPixels
     end subroutine getImageSetStyle

     subroutine gdImageSetThickness(im, thickness)&
          bind(c, name='gdImageSetThickness')
       import c_ptr, c_int
       implicit none
       type(c_ptr), value:: im
       integer(c_int), value:: thickness
     end subroutine gdImageSetThickness

     subroutine gdImageSetBrush(im, brush)&
          bind(c, name='gdImageSetBrush')
       import c_ptr
       implicit none
       type(c_ptr), value :: im, brush
     end subroutine gdImageSetBrush

     subroutine gdImageSetTile(im, tile)&
          bind(c, name='gdImageSetTile')
       import c_ptr
       implicit none
       type(c_ptr), value :: im, brush
     end subroutine gdImageSetTile

     subroutine gdImageSetAntiAliased(im, c)&
          bind(c, name ='gdImageSetAntiAliased')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value:: im
       integer(c_int), value :: c
     end subroutine gdImageSetAntiAliased

     subroutine gdImageSetAntiAliasedDontBlend(im, c, dont_blend)&
          bind(c, name='gdImageSetAntiAliasedDontBlend')
       import c_ptr, c_int
       implicit none
       type(c_ptr), value:: im
       integer(c_int), value:: c, dont_blend
     end subroutine gdImageSetAntiAliasedDontBlend

     subroutine gdImageInterlace(im, interlaceArg)&
          bind(c, name='gdImageInterlace')
       import c_ptr, c_int
       implicit none
       type(c_ptr), value:: im
       integer(c_int), value :: interlaceArg
     end subroutine gdImageInterlace

     function gdImageCompare(im1, im2)&
          bind(c, name='gdImageCompare')
       import c_ptr
       implicit none
       integer(c_int)::gdImageCompare
       type(c_ptr), value:: im1, im2
     end function gdImageCompare

     function gdAlphaBlend(dst, src)&
          bind(c, name='gdAlphaBlend')
       import c_int
       implicit none
       integer(c_int):: gdAlphaBlend
       integer(c_int), value:: dst, src
     end function gdAlphaBlend
       
     function gdLayerOverlay(dst, src)&
          bind(c, name='gdLayerOverlay')
       import c_int
       implicit none
       integer(c_int)::gdLayerOverlay
       integer(c_int), value:: dst, src
     end function gdLayerOverlay

     function gdLayerMultiply(dst, src)&
          bind(c, name='gdLayerOverlay')
       import c_int
       implicit none
       integer(c_int)::gdLayerMultiply
       integer(c_int), value:: dst, src
     end function gdLayerMultiply
     
     
  end interface

contains

  function gdTrueColorGetAlpha(c)
    implicit none
    integer(c_int):: gdTrueColorGetAlpha 
    integer(c_int) :: c
    gdTrueColorGetAlpha = ishft(iand(c, z'7F000000'), 24_c_int)
  end function gdTrueColorGetAlpha

  function gdTrueColorGetRed(c)
    implicit none
    integer(c_int):: gdTrueColorGetRed 
    integer(c_int) :: c
    gdTrueColorGetRed = ishft(iand(c, z'00FF0000'), 16_c_int)
  end function gdTrueColorGetRed
  
  function gdTrueColorGetGreen(c)
    implicit none
    integer(c_int):: gdTrueColorGetGreen 
    integer(c_int) :: c
    gdTrueColorGetGreen = ishft(iand(c, z'0000FF00'), 8_c_int)
  end function gdTrueColorGetGreen
  
  function gdTrueColorGetBlue(c)
    implicit none
    integer(c_int):: gdTrueColorGetBlue 
    integer(c_int) :: c
    gdTrueColorGetBlue = ishft(iand(c, z'000000FF'), 8_c_int)
  end function gdTrueColorGetBlue

end module fortran_libgd


