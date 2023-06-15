module fortran_libgd
  use, intrinsic ::  iso_c_binding
  implicit none

  type, bind(c):: gdPoint
     integer(c_int):: x
     integer(c_int):: y
  end type gdPoint

  type, bind(c):: gdRect
     integer(c_int):: x
     integer(c_int):: y
     integer(c_int):: width
     integer(c_int):: height
  end type gdRect

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

 !===============================================================================
        ! Functions thet are _not_ part of libgd but of the standard C library,
        ! but still required to access the functionality of libgd. 
        
        function gd_fclose(filepointer)&
             bind(c, name = 'fclose')
          import:: c_ptr,c_int
          implicit none
          type(c_ptr), value  :: filepointer
          integer(c_int) :: gd_fclose
        end function gd_fclose
        
        function gd_fopen(filename, modus)&
             bind(c, name = 'fopen')
          import::  c_ptr, c_char
          implicit none
          type(c_ptr) :: gd_fopen
          character(kind= c_char),   intent(in) :: filename(*), modus(*) 
        end function gd_fopen

        function gd_fflush(stream)&
             bind(c, name = 'fflush')
          import c_ptr, c_int
          implicit none
          integer(c_int):: gd_fflush
          type(c_ptr), value :: stream
        end function gd_fflush

        function gd_popen(stream)&
             bind(c, name = 'wrap_popen')
          import c_ptr, c_int
          integer(c_int):: gd_popen
          type(c_ptr), value :: stream
        end function gd_popen
 !==============================================================================
        
        
        function gdAlphaBlend(dst, src)&
             bind(c, name='gdAlphaBlend')
          import c_int
          implicit none
          integer(c_int):: gdAlphaBlend
          integer(c_int), value:: dst, src
        end function gdAlphaBlend
                
        function gdFontGetGiant()&
             bind(c, name = 'gdFontGetGiant')
          import c_ptr
          implicit none
          type(c_ptr) :: gdFontGetGiant
        end function gdFontGetGiant
        
        function gdFontGetLarge() bind(c, name = 'gdFontGetLarge')
          import c_ptr
          implicit none
          type(c_ptr) :: gdFontGetLarge
        end function gdFontGetLarge
        
        function gdFontGetMediumBold()&
             bind(c, name = 'gdFontGetMediumBold')
          import c_ptr
          implicit none
          type(c_ptr) :: gdFontGetMediumBold
        end function gdFontGetMediumBold
        
        function gdFontGetSmall()&
             bind(c, name = 'gdFontGetSmall')
          import c_ptr
          implicit none
          type(c_ptr) :: gdFontGetSmall
        end function gdFontGetSmall
        
        function gdFontGetTiny()&
             bind(c, name = 'gdFontGetTiny')
          import c_ptr
          implicit none
          type(c_ptr) :: gdFontGetTiny
        end function gdFontGetTiny
        
        subroutine gdFontCacheShutdown() &
             bind(c, name = 'gdFontCacheShutdown')
        end subroutine gdFontCacheShutdown
        

        subroutine gdImageArc (im, mx, my, w, h, a1, a2, color)&
             bind(c, name = 'gdImageArc')
          import c_int, c_ptr
          implicit none
          type(c_ptr)   , value :: im
          integer(c_int), value :: mx, my, w, h, a1, a2, color
        end subroutine gdImageArc
        
        function gdImageAlpha(im, c) &
             bind(c, name = ' wrap_gdImageAlpha')
          import c_int, c_ptr
          implicit none
          type(c_ptr), value :: im
          integer(c_int), value :: c
          integer(c_int) :: gdImageAlpha
        end function gdImageAlpha

        subroutine gdImageAlphaBlending(im, alphaBlendingArg) &
             bind(c, name='gdImageAlphaBlending')
          import c_ptr, c_int
          implicit none
          type(c_ptr), value:: im
          integer(c_int):: alphaBlendingArg
        end subroutine gdImageAlphaBlending

        function gdImageBlue (im, c) &
             bind(c, name = ' wrap_gdImageBlue')
          import c_int, c_ptr
          implicit none
          type(c_ptr), value :: im
          integer(c_int), value :: c
          integer(c_int) :: gdImageBlue
        end function gdImageBlue

        subroutine gdImageBmp (im, filepointer, compression)&
             bind(c, name = 'gdImageBmp')
          import c_ptr, c_int
          implicit none
          type(c_ptr), value :: im
          type(c_ptr), value :: filepointer
          integer(c_int), value :: compression
        end subroutine gdImageBmp

        function gdImageBmpPtr(im, size, compression)&
             bind(c, name = 'gdImageBmpPtr')
          import c_ptr, c_int
          implicit none
          type(c_ptr) :: gdImageBmpPtr
          type(c_ptr), value:: im
          integer(c_int) :: size
          integer (c_int), value :: compression
        end function gdImageBmpPtr
        
        function gdImageBoundsSafe(im, x, y)&
             bind(c, name='gdImageBoundsSave')
          import c_ptr, c_int
          implicit none
          integer(c_int)::  gdImageBoundsSafe
          type(c_ptr), value:: im
          integer(c_int), value:: x, y
        end function gdImageBoundsSafe

        function gdImageBrightness(src, brightness)&
             bind(c, name='gdImageBrightness')
          import c_int, c_ptr
          implicit none
          integer(c_int):: gdImageBrightness
          type(c_ptr):: src
          integer(c_int), value:: brightness
        end function gdImageBrightness

        subroutine gdImageChar(im,f, x, y, c, color)&
             bind(c, name='gdImageChar')
          import c_ptr, c_int
          implicit none
          type(c_ptr), value:: im, f
          integer(c_int):: x, y, c, color
        end subroutine gdImageChar
        
        subroutine gdImageCharUp(im,f, x, y, c, color)&
             bind(c, name='gdImageCharUp')
          import c_ptr, c_int
          implicit none
          type(c_ptr), value:: im, f
          integer(c_int):: x, y, c, color
        end subroutine gdImageCharUp
      
        function gdImageColorAllocate (im, r, g, b)&
             bind(c, name = 'gdImageColorAllocate')
          import c_int, c_ptr
          implicit none
          integer(c_int) :: gdImageColorAllocate
          type(c_ptr), value :: im
          integer(c_int), value :: r, g, b
        end function gdImageColorAllocate
        
        function gdImageColorAllocateAlpha (im, r, g, b, a)&
             bind(c, name = 'gdImageColorAllocateAlpha')
          import c_int, c_ptr
          implicit none
          integer(c_int) :: gdImageColorAllocateAlpha
          type(c_ptr), value :: im
          integer(c_int), value :: r, g, b, a
        end function gdImageColorAllocateAlpha
        
        function gdImageColorReplace (im, src, dst)&
             bind(c, name='gdImageColorReplace')
          import c_ptr, c_int
          implicit none
          integer(c_int)::  gdImageColorReplace
          type(c_ptr), value:: im
          integer(c_int):: src, dst
      end function gdImageColorReplace

      function gdImageColorReplaceThreshold (im, src, dst, threshold)&
           bind(c, name='gdImageColorReplaceThreshold')
        import c_ptr, c_int, c_float
        implicit none
        integer(c_int):: gdImageColorReplaceThreshold
        type(c_ptr), value:: im
        integer(c_int), value:: src, dst
        real(c_float), value:: threshold
      end function gdImageColorReplaceThreshold
      
      function gdImageColorReplaceArray (im, len, src, dst)&
           bind(c, name='gdImageColorReplaceArray')
        import c_ptr, c_int
        implicit none
        integer(c_int):: gdImageColorReplaceArray
        type(c_ptr), value:: im
        integer(c_int), value::len
        integer(c_int) :: src(*), dst(*)
      end function gdImageColorReplaceArray
      
      function gdImageClone(src) bind(c, name = 'gdImageClone')
        import c_ptr, c_int
        implicit none
        type(c_ptr):: gdImageClone
        type(c_ptr), value:: src
      end function gdImageClone
     
      function gdImageColor(src, red, green, blue, alpha)&
           bind(c, name='gdImageColor')
        import c_int, c_ptr
        implicit none
        integer(c_int) :: gdImageColor
        type(c_ptr), value :: src
        integer(c_int), value:: red, green, blue, alpha
      end function gdImageColor

      function gdImageColorClosest(im, r, g, b )&
           bind(c, name='gdImageColorClosest')
        import c_ptr, c_int
        implicit none
        integer(c_int):: gdImageColorClosest 
        type(c_ptr), value:: im
        integer(c_int), value:: r,g,b
      end function gdImageColorClosest

      function gdImageColorClosestAlpha(im, r, g, b, a)&
           bind(c, name='gdImageColorClosestAlpha')
        import c_ptr, c_int
        implicit none
        integer(c_int):: gdImageColorClosestAlpha
        type(c_ptr), value:: im
        integer(c_int), value:: r,g,b,a
      end function gdImageColorClosestAlpha

      function gdImageColorClosestHWB(im, r, g, b)&
           bind(c, name='gdImageColorClosestHWB')
        import c_ptr, c_int
        implicit none
        integer(c_int):: gdImageColorClosestHWB
        type(c_ptr), value:: im
        integer(c_int), value:: r,g,b 
      end function gdImageColorClosestHWB

      subroutine gdImageColorDeallocate(im, color)&
           bind(c, name='gdImageColorDeallocate')
        import c_ptr, c_int
        implicit none
        type(c_ptr), value:: im
        integer(c_int), value:: color
      end subroutine gdImageColorDeallocate

      function gdImageColorExact(im, r, g, b)&
           bind(c, name='gdImageColorExact')
        import c_ptr, c_int
        implicit none
        integer(c_int):: gdImageColorExact
        type(c_ptr), value:: im
        integer(c_int):: r, g, b
      end function gdImageColorExact
      
      function gdImageColorExactAlpha(im, r, g, b)&
           bind(c, name='gdImageColorExact')
        import c_ptr, c_int
        implicit none
        integer(c_int):: gdImageColorExactAlpha
        type(c_ptr), value:: im
        integer(c_int):: r, g, b
      end function gdImageColorExactAlpha

      function gdImageColorResolve(im, r, g, b)&
           bind(c, name ='gdImageColorResolve')
        import c_ptr, c_int
        implicit none
        integer(c_int):: gdImageColorResolve
        type(c_ptr), value:: im
        integer(c_int), value:: r, g, b
      end function gdImageColorResolve

      function gdImageColorResolveAlpha(im, r, g, b, a)&
           bind(c, name='gdImageColorResolveAlpha')
        import c_ptr, c_int
        implicit none
        integer(c_int)::  gdImageColorResolveAlpha
        type(c_ptr), value:: im
        integer(c_int), value:: r, g, b, a
      end function gdImageColorResolveAlpha
      
      function gdImageColorsTotal (im) &
           bind(c, name = 'wrap_gdImageColorsTotal')
        import c_int, c_ptr
        implicit none
        type(c_ptr), value :: im
        integer(c_int) ::  gdImageColorsTotal
      end function gdImageColorsTotal

!!$      subroutine gdImageColorTransparent &
!!$           bind(c, name = 'gdImageColorTransparent')
!!$        import c_int, c_ptr
!!$        type(c_ptr), value:: im
!!$        integer(c_int), value:: color
!!$      end subroutine gdImageColorTransparent
      
      function gdImageCompare(im1, im2)&
           bind(c, name='gdImageCompare')
        import c_int, c_ptr
        implicit none
        integer(c_int)::gdImageCompare
        type(c_ptr), value:: im1, im2
      end function gdImageCompare
      
      function gdImageContrast(src, contrast)&
           bind(c, name='gdImageContrast')
        import c_int, c_double, c_ptr
        implicit none
        integer(c_int):: gdImageContrast
        type(c_ptr), value:: src
        real(c_double), value:: contrast
      end function gdImageContrast
      
!!$     function gdImageConvolution(src, filter, filter_div, offset)&
!!$          bind(c, name='gdImageConvolution')
!!$       import c_int, c_float, c_ptr
!!$       implicit none
!!$       integer(c_int):: gdImageConvolution
!!$       type(c_ptr):: src
!!$       real(c_float), value:: filter(0:3)
!!$       real(c_float), value:: filter_div, offset
!!$     end function gdImageConvolution
    
      subroutine gdImageCopy(dst, src, dstX, dstY, srcX, srcY, w, h)&
           bind(c, name = 'gdImageCopy')
        import c_ptr, c_int
        implicit none
        type(c_ptr), value :: dst, src
        integer(c_int), value :: dstX, dstY, srcX, srcY, w ,h
      end subroutine gdImageCopy
      
      function gdImageCopyGaussianBlurred(src, radius, sigma) &
           bind(c, name='gdImageCopyGaussianBlurred')
        import c_int, c_double, c_ptr
        implicit none
        integer(c_int):: gdImageCopyGaussianBlurred
        type(c_ptr), value:: src
        integer(c_int), value:: radius
        real(c_double), value:: sigma 
      end function gdImageCopyGaussianBlurred
      
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
      
      subroutine gdImageCopyResampled(dst, src, dstX, dstY, srcX, srcY,&
           srcW, srcH, angle) &
           bind(c, name='gdImageCopyResampled')
        import c_ptr, c_int
        implicit none
        type(c_ptr):: dst, src
        integer(c_int)::  dstX, dstY, srcX, srcY,srcW, srcH, angle
      end subroutine gdImageCopyResampled
      
      subroutine gdImageCopyResized(dst, src, dstX, dstY, srcX, srcY,&
           dstW, dstH, srcW, srcH) &
           bind(c, name = 'gdImageCopyResized')
        import c_ptr, c_int
        implicit none
        type(c_ptr), value:: dst, src
        integer(c_int), value :: dstX, dstY,srcX, srcY, dstW, dstH, srcW, srcH
      end subroutine gdImageCopyResized
      
      subroutine gdImageCopyRotated(dst, src, dstX, dstY, srcX, srcY, srcWidth,&
           srcHeight, angle) &
           bind(c, name='gdImageCopyRotated')
        import c_int, c_ptr, c_double
        implicit none
        type(c_ptr), value:: dst, src
        real(c_double), value:: dstX, dstY
        integer(c_int), value:: srcX, srcY, srcWidth, srcHeight, angle
      end subroutine gdImageCopyRotated
      
      function gdImageCreate(xsize, ysize) bind(c, name = 'gdImageCreate')
        import:: c_ptr, c_int
        implicit none
        type(c_ptr) :: gdImageCreate
        integer(c_int), value :: xsize, ysize
      end function gdImageCreate

      function gdImageCreateFromBmp(inFile) &
           bind(c, name = 'gdImageCreateFromBmp')
        import c_ptr, c_char
        implicit none
        type(c_ptr) :: gdImageCreateFromBmp
        type(c_ptr), value :: inFile
      end function gdImageCreateFromBmp

      function gdImageCreateFromBmpPtr(size, data) &
           bind(c, name = 'gdImageCreateFromBmpPtr')
        import c_ptr, c_int
        implicit none
        type(c_ptr) :: gdImageCreateFromBmpPtr
        integer(c_int), value:: size
        type(c_ptr), value ::data
      end function gdImageCreateFromBmpPtr
                
      function gdImageCreateFromFile(filename) &
           bind(c, name = 'gdImageCreateFromFile')
        import c_ptr, c_char
        implicit none
        type(c_ptr) :: gdImageCreateFromFile
        character(kind= c_char),   intent(in) :: filename(*)
      end function gdImageCreateFromFile
       
      function gdImageCreateFromGif(fdFile) &
           bind(c, name = 'gdImageCreateFromGif')
        import c_ptr, c_char
        implicit none
        type(c_ptr) :: gdImageCreateFromGif
        type(c_ptr), value:: fdFile 
      end function gdImageCreateFromGif
      
      function gdImageCreateFromGifPtr(size, data) &
           bind(c, name = 'gdImageCreateFromGif')
        import c_ptr, c_int, c_char
        implicit none
        type(c_ptr) :: gdImageCreateFromGifPtr
        integer(c_int), value:: size
        character(c_char):: data(*)
      end function gdImageCreateFromGifPtr
       
      function gdImageCreateFromPng(fdFile) &
           bind(c, name = 'gdImageCreateFromPng')
        import c_ptr, c_char
        implicit none
        type(c_ptr) :: gdImageCreateFromPng
        type(c_ptr), value:: fdFile 
      end function gdImageCreateFromPng

      function gdImageCreateFromTiff(fdFile) &
           bind(c, name = 'gdImageCreateFromTiff')
        import c_ptr, c_char
        implicit none
        type(c_ptr) :: gdImageCreateFromTiff
        type(c_ptr), value:: fdFile 
      end function gdImageCreateFromTiff

      function gdImageCreateFromTiffPtr(size, data) &
           bind(c, name = 'gdImageCreateFromTiffPtr')
        import c_ptr, c_int
        implicit none
        type(c_ptr):: gdImageCreateFromTiffPtr
        integer(c_int), value :: size
        type(c_ptr), value:: data
      end function gdImageCreateFromTiffPtr
     
      function gdImageCreatePaletteFromTrueColor(im, dither, colorsWanted)&
           bind(c, name = 'gdImageCreatePaletteFromTrueColor')
        import c_int, c_ptr
        implicit none
        integer(c_int):: gdImageCreatePaletteFromTrueColor
        type(c_ptr), value :: im
        integer(c_int), value:: dither, colorsWanted
      end function gdImageCreatePaletteFromTrueColor
      
      function gdImageCreateTrueColor(xsize, ysize)&
           bind(c, name = 'gdImageCreateTrueColor')
        import:: c_ptr, c_int
        implicit none
        type(c_ptr) :: gdImageCreateTrueColor
        integer(c_int), value :: xsize, ysize
      end function gdImageCreateTrueColor

      function gdImageCrop(src, crop)&
           bind(c, name='gdImageCrop')
        import:: c_ptr, gdRect
        implicit none
        type(c_ptr):: gdImageCrop
        type(c_ptr), value:: src
        type(gdRect):: crop
      end function gdImageCrop

      function gdImageCropAuto(im, mode)&
           bind(c, name='gdImageCropAuto')
        import:: c_ptr, c_int, gdImageCrop
        implicit none
        type(c_ptr):: gdImageCropAuto 
        type(c_ptr), value:: im
        integer(c_int), value:: mode
      end function gdImageCropAuto

      function gdImageCropThreshold(im, color, threshold)&
           bind(c, name='gdImageCropThreshold')
        import:: c_ptr, c_float, c_int
        implicit none
        type(c_ptr):: gdImageCropThreshold
        type(c_ptr), value:: im
        integer(c_int), value:: color
        real(c_float), value:: threshold
      end function gdImageCropThreshold
            
      subroutine gdImageDashedLine (im, x1, y1, x2, y2, color)&
           bind(c, name = 'gdImageDashedLine')
        import c_int, c_ptr
        implicit none
        type(c_ptr)   , value :: im
        integer(c_int), value :: x1, y1, x2, y2, color
      end subroutine gdImageDashedLine
      
      subroutine gdImageDestroy(im) bind(c, name = 'gdImageDestroy')
        import:: c_ptr
        implicit none
        type(c_ptr), value :: im
      end subroutine gdImageDestroy
      
      function gdImageEdgeDetectQuick(src) &
           bind(c, name='gdImageEdgeDetectQuick')
        import c_int, c_ptr
        implicit none
        integer(c_int):: gdImageEdgeDetectQuick
        type(c_ptr), value:: src
      end function gdImageEdgeDetectQuick
      
      subroutine gdImageEllipse (im, mx, my, w, h, color) bind(c, name = 'gdImageEllipse')
        import c_int, c_ptr
        implicit none
        type(c_ptr)   , value :: im
        integer(c_int), value :: mx, my, w, h, color
      end subroutine gdImageEllipse
      
      function gdImageEmboss(src) &
           bind(c, name='gdImageEmboss')
        import c_int, c_ptr
        implicit none
        integer(c_int):: gdImageEmboss
        type(c_ptr), value:: src
      end function gdImageEmboss
      
      function gdImageFile(im, filename)&
           bind(c, name='gdImageFile')
        import c_char, c_int, c_ptr
        implicit none
        integer(c_int):: gdImageFile
        type(c_ptr), value:: im
        character(c_char), intent(in) :: filename
      end function gdImageFile
      
      subroutine gdImageFill (im, x,y , color) bind(c, name = 'gdImageFill')
        import c_int, c_ptr
        implicit none
        type(c_ptr)   , value :: im
        integer(c_int), value :: x,y , color
      end subroutine gdImageFill
      
      subroutine gdImageFilledArc (im, mx, my, w, h, a1, a2, color, s)&
           bind(c, name = 'gdImageFilledArc')
        import c_int, c_ptr
        implicit none
        type(c_ptr)   , value :: im
        integer(c_int), value :: mx, my, w, h, a1, a2, color,s 
      end subroutine gdImageFilledArc
     
      subroutine gdImageFilledEllipse (im, mx, my, w, h, color)&
           bind(c, name = 'gdImageFilledEllipse')
        import c_int, c_ptr
        implicit none
        type(c_ptr)   , value :: im
        integer(c_int), value :: mx, my, w, h, color
      end subroutine gdImageFilledEllipse

      subroutine gdImageFilledPolygon(im, p, n, c)&
           bind(c, name=' gdImageFilledPolygon')
        import c_ptr, c_int, gdPoint
        implicit none
        type(c_ptr), value:: im
        type(gdPoint):: p(*)
        integer(c_int), value:: n, c
      end subroutine gdImageFilledPolygon

      
      subroutine gdImageFilledRectangle (im, x1, y1, x2, y2, color)&
           bind(c, name = 'gdImageFilledRectangle')
        import c_int, c_ptr
        implicit none
        type(c_ptr)   , value :: im
        integer(c_int), value :: x1, y1, x2, y2, color
      end subroutine gdImageFilledRectangle
      
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
      
      function gdImageGaussianBlur(src) &
           bind(c, name='gdImageGaussianBlur')
        import c_int, c_ptr
        implicit none
        integer(c_int):: gdImageGaussianBlur
        type(c_ptr), value:: src
      end function gdImageGaussianBlur
      
      function gdImageGetInterlaced (im) &
           bind(c, name = 'wrap_gdImageGetInterlaced')
        import c_int, c_ptr
        implicit none
        type(c_ptr), value :: im
        integer(c_int) ::  gdImageGetInterlaced 
      end function gdImageGetInterlaced
      
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

      subroutine gdImageGif (im, outFile)&
           bind(c, name='gdImageGif')
        import c_ptr
        implicit none
        type(c_ptr), value:: im, outFile
      end subroutine gdImageGif

      subroutine gdImageGifAnimAdd(im, outFile, LocalCM, LeftOfs, TopOfs, Delay, Disposal, previm)&
           bind(c, name='gdImageGifAnimAdd')
        import c_ptr, c_int
        implicit none
        type(c_ptr), value:: im, outFile, previm
        integer(c_int), value:: LocalCM, LeftOfs, TopOfs, Delay, Disposal
      end subroutine gdImageGifAnimAdd

      subroutine gdImageGifAnimAddPtr(im, size, LocalCM, LeftOfs, TopOfs, Delay, Disposal, previm)&
           bind(c, name='gdImageGifAnimAddPtr')
        import c_ptr, c_int
        implicit none
        type(c_ptr), value:: im, previm
        integer(c_int) :: size
        integer(c_int), value:: LocalCM, LeftOfs, TopOfs, Delay, Disposal
      end subroutine gdImageGifAnimAddPtr

      subroutine gdImageGifAnimBegin(im, outFile, GlobalCM, Loops)&
           bind(c, name='gdImageGifAnimBegin')
        import c_ptr, c_int
        implicit none
        type(c_ptr), value:: im, outFile
        integer(c_int), value:: GlobalCM, Loops
      end subroutine gdImageGifAnimBegin

      function gdImageAnimBeginPtr(im, size, GlobalCM, Loops)&
           bind(c, name='gdImageAnimBeginPtr')
        import c_ptr, c_char, c_int
        implicit none
        type(c_ptr)::  gdImageAnimBeginPtr
        type(c_ptr), value:: im
        integer(c_int):: size
        integer(c_int), value :: GlobalCM, Loops
      end function gdImageAnimBeginPtr

      subroutine gdImageGifAnimEnd(outFile)&
           bind(c, name='gdImageGifAnimEnd')
        import c_ptr
        implicit none
        type(c_ptr), value:: outFile
      end subroutine gdImageGifAnimEnd

      function gdImageGifPtr(im, size)&
           bind(c, name = 'gdImageGifPtr')
        import c_ptr, c_int
        implicit none
        type(c_ptr) :: gdImageGifPtr 
        type(c_ptr), value:: im
        integer(c_int) :: size
      end function gdImageGifPtr
      
      function gdImageGrayScale(src)&
           bind(c, name='gdImageGrayScale')
        import c_int, c_ptr
        implicit none
        integer(c_int):: gdImageGrayScale
        type(c_ptr), value :: src
      end function gdImageGrayScale
      
      function gdImageGreen (im, c) &
           bind(c, name = ' wrap_gdImageGreen')
        import c_int, c_ptr
        implicit none
        type(c_ptr), value :: im
        integer(c_int), value :: c
        integer(c_int) :: gdImageGreen
      end function gdImageGreen
      
      subroutine gdImageInterlace(im, interlaceArg)&
           bind(c, name='gdImageInterlace')
        import c_ptr, c_int
        implicit none
        type(c_ptr), value:: im
        integer(c_int), value :: interlaceArg
      end subroutine gdImageInterlace
      
      subroutine gdImageJpeg (im, filepointer, quality) bind(c, name = 'gdImageJpeg')
        import c_ptr, c_int
        implicit none
        type(c_ptr), value :: im
        type(c_ptr), value :: filepointer
        integer(c_int), value :: quality
      end subroutine gdImageJpeg
      
      subroutine gdImageLine (im, x1, y1, x2, y2, color) bind(c, name = 'gdImageLine')
        import c_int, c_ptr
        implicit none
        type(c_ptr)   , value :: im
        integer(c_int), value :: x1, y1, x2, y2, color
      end subroutine gdImageLine
      
      function gdImageMeanRemoval(src) &
           bind(c, name='gdImageMeanRemoval')
        import c_int, c_ptr
        implicit none
        integer(c_int):: gdImageMeanRemoval
        type(c_ptr), value:: src
      end function gdImageMeanRemoval
      
      function gdImageNegate(src)&
           bind(c, name='gdImageNegate')
        import c_int, c_ptr
        implicit none
        integer(c_int):: gdImageNegate
        type(c_ptr), value:: src
      end function gdImageNegate

      function gdImageNeuQuant(im, max_color, sample_factor)&
           bind(c, name='gdImageNeuQuant')
        import c_int, c_ptr
        implicit none
        type(c_ptr) :: gdImageNeuQuant
        type(c_ptr), value:: im
        integer(c_int), value:: max_color, sample_factor
      end function gdImageNeuQuant

      subroutine gdImageOpenPolygon(im, p, n, c)&
           bind(c, name=' gdImageOpenPolygon')
        import c_ptr, c_int, gdPoint
        implicit none
        type(c_ptr), value:: im
        type(gdPoint):: p(*)
        integer(c_int), value:: n, c
      end subroutine gdImageOpenPolygon

      subroutine gdImagePaletteCopy(to, from) &
           bind(c, name='gdImagePaletteCopy')
        import c_int, c_ptr
        implicit none
        type(c_ptr), value:: to, from
      end subroutine gdImagePaletteCopy
      
      function gdImagePalettePixel (im,x,y) &
           bind(c, name = 'wrap_gdImagePalettePixel')
        import c_int, c_ptr
        implicit none
        type(c_ptr), value :: im
        integer(c_int), value:: x,y
        integer(c_int) ::  gdImagePalettePixel 
      end function gdImagePalettePixel

      function gdImagePixelate(im, block_size, mode)&
           bind(c, name='gdImagePixelate')
        import c_int, c_ptr
        implicit none
        integer(c_int):: gdImagePixelate
        type(c_ptr), value:: im
        integer(c_int), value ::  block_size, mode
      end function gdImagePixelate
          
      subroutine gdImagePng (im, filepointer)&
           bind(c, name = 'gdImagePng')
        import c_ptr
        implicit none
        type(c_ptr), value :: im
        type(c_ptr), value :: filepointer
      end subroutine gdImagePng

      subroutine gdImagePolygon(im, p, n, c)&
           bind(c, name=' gdImagePolygon')
        import c_ptr, c_int, gdPoint
        implicit none
        type(c_ptr), value:: im
        type(gdPoint):: p(*)
        integer(c_int), value:: n, c
      end subroutine gdImagePolygon

      subroutine gdImageRectangle (im, x1, y1, x2, y2, color) bind(c, name = 'gdImageRectangle')
        import c_int, c_ptr
        implicit none
        type(c_ptr)   , value :: im
        integer(c_int), value :: x1, y1, x2, y2, color
      end subroutine gdImageRectangle
      
      function gdImageRed (im, c) &
           bind(c, name = ' wrap_gdImageRed')
        import c_int, c_ptr
        implicit none
        type(c_ptr), value :: im
        integer(c_int), value :: c
        integer(c_int) :: gdImageRed
      end function gdImageRed

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

      function gdImageScale (src, new_width, new_height) &
           bind(c, name = 'gdImageScale')
        import c_int, c_ptr
        implicit none
        type(c_ptr):: gdImageScale
        type(c_ptr), value:: src
        integer(c_int), value:: new_width, new_height
      end function gdImageScale

      function gdImageRotateInterpolated (src, angle, bgcolor) &
           bind(c, name = 'gdImageRotateIntedrpolatzed')
        import c_int, c_ptr, c_float
        implicit none
        type(c_ptr):: gdImageRotateInterpolated
        type(c_ptr), value:: src
        real(c_float), value:: angle
        integer(c_int), value:: bgcolor
      end function 
    
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
     
     function gdImageSelectiveBlur(src)&
          bind(c, name='gdImageSelectiveBlur')
       import c_int, c_ptr
       implicit none
       integer(c_int):: gdImageSelectiveBlur
       type(c_ptr), value:: src
     end function gdImageSelectiveBlur

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
          
     subroutine gdImageSetBrush(im, brush)&
          bind(c, name='gdImageSetBrush')
       import c_ptr
       implicit none
       type(c_ptr), value :: im, brush
     end subroutine gdImageSetBrush

     subroutine gdImageSetPixel(im, x, y, color)&
          bind(c, name = 'gdImageSetPixel')
       import c_ptr, c_int
       implicit none
       type(c_ptr), value :: im
       integer(c_int), value :: x,y,color
     end subroutine gdImageSetPixel
     
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
     
     subroutine gdImageSetTile(im, tile)&
          bind(c, name='gdImageSetTile')
       import c_ptr
       implicit none
       type(c_ptr), value :: im, tile
     end subroutine gdImageSetTile
     
     function gdImageSmooth(im, weight) &
          bind(c, name='gdImageSmooth')
       import c_int, c_float, c_ptr
       implicit none
       integer(c_int):: gdImageSmooth
       real(c_float), value:: weight 
       type(c_ptr), value:: im
     end function gdImageSmooth
     
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
     
     subroutine gdImageStringUp (im, fontpointer, x,y, s, color)&
          bind(c, name='gdImageStringUp')
       import c_int, c_char, c_ptr
       implicit none
       type(c_ptr), value        :: im
       type(c_ptr), value        :: fontpointer
       integer(c_int),value      :: x,y
       character(kind= c_char),   intent(in) :: s(*)       
       integer(c_int), value     :: color
     end subroutine gdImageStringUp
     
     subroutine gdImageString16 (im, fontpointer, x,y, s, color)&
          bind(c, name='gdImageString16')
       import c_int, c_short, c_char, c_ptr
       implicit none
       type(c_ptr), value        :: im
       type(c_ptr), value        :: fontpointer
       integer(c_int),value      :: x,y
       integer(kind= c_short), intent(in) :: s(*)       
       integer(c_int), value     :: color
     end subroutine gdImageString16
     
     subroutine gdImageStringUp16 (im, fontpointer, x,y, s, color)&
          bind(c, name='gdImageStringUp16')
       import c_int, c_short, c_char, c_ptr
       implicit none
       type(c_ptr), value        :: im
       type(c_ptr), value        :: fontpointer
       integer(c_int),value      :: x,y
       integer(kind= c_short), intent(in) :: s(*)       
       integer(c_int), value     :: color
     end subroutine gdImageStringUp16
     
     
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
     end subroutine gdImageStringFT
     
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

     subroutine gdImageTiff(im, outfile)&
          bind(c, name ='gdImageTiff')
       import c_ptr
       implicit none
       type(c_ptr), value :: im, outfile
     end subroutine gdImageTiff

     function gdImageTiffPtr (im, size)&
          bind(c, name = 'gdImageTiffPtr')
       import c_ptr, c_int
       implicit none
       type(c_ptr):: gdImageTiffPtr
       type(c_ptr), value::im
       integer(c_int) :: size
     end function gdImageTiffPtr
       
     function gdImageTrueColor (im)&
          bind(c, name = 'wrap_gdImageTrueColor')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im
       integer(c_int) ::  gdImageTrueColor
     end function gdImageTrueColor
     
     function gdImageTrueColorPixel (im,x,y)&
          bind(c, name = 'wrap_gdImageTrueColorPixel')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im 
       integer(c_int), value:: x,y
       integer(c_int) ::  gdImageTrueColorPixel 
     end function gdImageTrueColorPixel

     function gdImageTrueColorToPalette(im, dither, colorsWanted)&
          bind(c, name = 'gdImageTrueColorTopPalette')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value :: im
       integer(c_int):: gdImageTrueColorToPalette
       integer(c_int), value :: dither, colorsWanted
     end function gdImageTrueColorToPalette

     function gdImageTrueColorToPaletteSetMethod(im, method, speed)&
       bind(c, name='gdImageTrueColorToPaletteSetMethod')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value:: im
       integer(c_int):: gdImageTrueColorToPaletteSetMethod
       integer(c_int), value:: method, speed
     end function gdImageTrueColorToPaletteSetMethod

     function gdImageTrueColorToPaletteSetQuality(im, min_quality, max_quality)&
       bind(c, name='gdImageTrueColorToPaletteSetQuality')
       import c_int, c_ptr
       implicit none
       type(c_ptr), value:: im
       integer(c_int):: gdImageTrueColorToPaletteSetQuality
       integer(c_int), value:: min_quality, max_quality
     end function gdImageTrueColorToPaletteSetQuality
    
     function gdLayerMultiply(dst, src)&
          bind(c, name='gdLayerOverlay')
       import c_int
       implicit none
       integer(c_int)::gdLayerMultiply
       integer(c_int), value:: dst, src
     end function gdLayerMultiply
     
     function gdLayerOverlay(dst, src)&
          bind(c, name='gdLayerOverlay')
       import c_int
       implicit none
       integer(c_int)::gdLayerOverlay
       integer(c_int), value:: dst, src
     end function gdLayerOverlay
     
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
     
     function gdSupportsFileType(filename, writing)&
          bind(c, name='gdSupportsFileTyp')
       import c_char, c_int
       implicit none
       integer(c_int):: gdSupportsFileType
       character(c_char), intent(in) :: filename(*)
       integer(c_int), value:: writing
     end function gdSupportsFileType
     
  end interface

contains

  function gdTrueColorGetAlpha(c)
    implicit none
    integer(c_int):: gdTrueColorGetAlpha 
    integer(c_int) :: c
    gdTrueColorGetAlpha = ishft(iand(c, z'7F000000'), -24_c_int)
  end function gdTrueColorGetAlpha
  
  function gdTrueColorGetRed(c)
    implicit none
    integer(c_int):: gdTrueColorGetRed 
    integer(c_int) :: c
    gdTrueColorGetRed = ishft(iand(c, z'00FF0000'), -16_c_int)
  end function gdTrueColorGetRed

  function gdTrueColorGetGreen(c)
    implicit none
    integer(c_int):: gdTrueColorGetGreen 
    integer(c_int) :: c
    gdTrueColorGetGreen = ishft(iand(c, z'0000FF00'), -8_c_int)
  end function gdTrueColorGetGreen
    
  function gdTrueColorGetBlue(c)
    implicit none
    integer(c_int):: gdTrueColorGetBlue 
    integer(c_int) :: c
    gdTrueColorGetBlue = ishft(iand(c, z'000000FF'), 0_c_int)
  end function gdTrueColorGetBlue

  subroutine gdReadIntArrayFromIm(im, intArray, w, h)
    implicit none
    ! 1-st dimenstion: color channel (1=red, 2= green, 3= blue, values from 1 to 255)
    ! 2-nd dimenstion: column (starting with 0)
    ! 3-rd dimension:  line(starting with 1) 
    
    integer(c_int) :: IntArray(1:3,0:w-1,0:h-1)
    type(c_ptr), value :: im
    integer(c_int), value:: w, h
    integer:: x_counter, y_counter, pixelvalue

    intArray = 0

    do y_counter= 0,h-1
       do x_counter=0,w-1
          pixelvalue = gdImageGetTrueColorPixel(im,x_counter, y_counter)
          IntArray(1,x_counter, y_counter) = gdTrueColorGetRed(pixelvalue)
          IntArray(2,x_counter, y_counter) = gdTrueColorGetGreen(pixelvalue)
          IntArray(3,x_counter, y_counter) = gdTrueColorGetBlue(pixelvalue)
       enddo
    enddo   
  end subroutine gdReadIntArrayFromIm

  subroutine gdWriteImFromIntArray(im, IntArray, w, h)
    implicit none
    type(c_ptr), value:: im
    integer(c_int):: IntArray(1:3, 0:w-1, 0:h-1)
    integer(c_int), value:: w, h  
    integer:: x_counter, y_counter, current_color

    do y_counter=0,h-1
       do x_counter=0,w-1
          current_color = gdImageColorAllocate(im,&
                                               IntArray(1,x_counter, y_counter),&
                                               IntArray(2,x_counter, y_counter),&
                                               IntArray(3,x_counter, y_counter))
          call gdImageSetPixel(im,x_counter, y_counter, current_color)
       enddo
    enddo
  end subroutine gdWriteImFromIntArray


end module fortran_libgd


