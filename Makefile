COMPILEROPTIONS = -O0 -g -fbacktrace -fPIC

CC      = gcc $(COMPILEROPTIONS)
FORTRAN = gfortran $(COMPILEROPTIONS)
LINKER = gfortran
ARCHIVER = ar rcs
SHAREDARCHIVER = gcc
LIBRARIES = -lgd -lpng -lz -ljpeg -lfreetype -lm

OBJEXT = .o
EXEEXT =
MODEXT = .mod
ARCHIVEEXT = .a
SHAREDEXT = .so

NOCOMPILE = -c
CREATEOBJECT = -o
CREATESHARED = -shared
REMOVE = rm

MODULEPATH = -I .

LIBGD_H_WRAPPER_C = libgd_h_wrapper.c
LIBGD_H_WRAPPER_OBJ = libgd_f_wrapper$(OBJEXT)

FORTRAN_LIBGD_F90 = fortran_libgd.f90
FORTRAN_LIBGD_MOD = fortran_libgd$(MODEXT)
FORTRAN_LIBDG_OBJ = fortran_libgd$(OBJEXT)

TEST_FORTRAN_GD_F90 = tests/test_fortran_gd.f90
TEST_FORTRAN_GD_OBJ = tests/test_fortran_gd$(OBJEXT)
TEST_FORTRAN_GD_EXE = tests/test_fortran_gd$(EXEEXT)

TEST_FORTRAN_GD_EXTENDED_F90 = tests/test_fortran_gd_extended.f90
TEST_FORTRAN_GD_EXTENDED_OBJ = tests/test_fortran_gd_extended$(OBJEXT)
TEST_FORTRAN_GD_EXTENDED_EXE = tests/test_fortran_gd_extended$(EXEEXT)

TEST_POLYGON_F90 = tests/test_polygon.f90
TEST_POLYGON_OBJ = tests/test_polygon$(OBJEXT)
TEST_POLYGON_EXE = tests/test_polygon$(EXEEXT)

TEST_ALL_COLORS_F90 = tests/test_all_colors.f90
TEST_ALL_COLORS_OBJ = tests/test_all_colors$(OBJEXT)
TEST_ALL_COLORS_EXE = tests/test_all_colors$(EXEEXT)

TEST_FONTS_F90 = tests/test_fonts.f90
TEST_FONTS_OBJ = tests/test_fonts$(OBJEXT)
TEST_FONTS_EXE = tests/test_fonts$(EXEEXT)

TEST_ANALYZE_IMAGE_F90 = tests/test_analyze_image.f90
TEST_ANALYZE_IMAGE_OBJ = tests/test_analyze_image$(OBJEXT)
TEST_ANALYZE_IMAGE_EXE = tests/test_analyze_image$(EXEEXT)

TEST_EDGE_F90 = tests/test_edge.f90
TEST_EDGE_OBJ = tests/test_edge$(OBJEXT)
TEST_EDGE_EXE = tests/test_edge$(EXEEXT)

TEST_EDGE_F90 = tests/test_edge.f90
TEST_EDGE_IMAGE_OBJ = tests/test_edge$(OBJEXT)
TEST_EDGE_EXE = tests/test_edge$(EXEEXT)

TEST_ANIMATION_F90 = tests/test_animation.f90
TEST_ANIMATION_OBJ = tests/test_animation$(OBJEXT)
TEST_ANIMATION_EXE = tests/test_animation$(EXEEXT)

TEST_IM_INT_ARRAY_F90 = tests/test_im_int_array.f90
TEST_IM_INT_ARRAY_OBJ = tests/test_im_int_array$(OBJEXT)
TEST_IM_INT_ARRAY_EXE = tests/test_im_int_array$(EXEEXT)

FORTRAN_LIBGD_ARCHIVE = fortran_libgd$(ARCHIVEEXT)
FORTRAN_LIBGD_SHARED = fortran_libgd$(SHAREDEXT)


all: $(TEST_FORTRAN_GD_EXE) $(TEST_FORTRAN_GD_EXTENDED_EXE) $(TEST_POLYGON_EXE) $(TEST_ALL_COLORS_EXE) \
     $(TEST_FONTS_EXE) $(TEST_ANALYZE_IMAGE_EXE) $(TEST_EDGE_EXE) $(TEST_ANIMATION_EXE) $(TEST_IM_INT_ARRAY_EXE)\
     $(FORTRAN_LIBGD_ARCHIVE) $(FORTRAN_LIBGD_SHARED)


$(TEST_FORTRAN_GD_EXE): $(TEST_FORTRAN_GD_OBJ)
	$(LINKER) $(CREATEOBJECT) $(TEST_FORTRAN_GD_EXE)  $(TEST_FORTRAN_GD_OBJ) $(LIBRARIES)

$(TEST_FORTRAN_GD_OBJ): $(FORTRAN_LIBGD_MOD) $(TEST_FORTRAN_GD_F90)
	$(FORTRAN)  $(NOCOMPILE) $(TEST_FORTRAN_GD_F90) $(CREATEOBJECT) $(TEST_FORTRAN_GD_OBJ)  $(MODULEPATH)


$(TEST_FORTRAN_GD_EXTENDED_EXE): $(TEST_FORTRAN_GD_EXTENDED_OBJ)
	$(LINKER) $(CREATEOBJECT) $(TEST_FORTRAN_GD_EXTENDED_EXE)  $(TEST_FORTRAN_GD_EXTENDED_OBJ) $(LIBRARIES)

$(TEST_FORTRAN_GD_EXTENDED_OBJ): $(FORTRAN_LIBGD_MOD) $(TEST_FORTRAN_GD_EXTENDED_F90)
	$(FORTRAN)  $(NOCOMPILE) $(TEST_FORTRAN_GD_EXTENDED_F90) $(CREATEOBJECT) $(TEST_FORTRAN_GD_EXTENDED_OBJ) $(MODULEPATH)


$(TEST_POLYGON_EXE): $(TEST_POLYGON_OBJ)
	$(LINKER) $(CREATEOBJECT) $(TEST_POLYGON_EXE)  $(TEST_POLYGON_OBJ) $(LIBRARIES)

$(TEST_POLYGON_OBJ): $(FORTRAN_LIBGD_MOD) $(TEST_POLYGON_F90)
	$(FORTRAN)  $(NOCOMPILE) $(TEST_POLYGON_F90) $(CREATEOBJECT) $(TEST_POLYGON_OBJ) $(MODULEPATH)


$(TEST_ALL_COLORS_EXE): $(TEST_ALL_COLORS_OBJ)
	$(LINKER) $(CREATEOBJECT) $(TEST_ALL_COLORS_EXE)  $(TEST_ALL_COLORS_OBJ) $(LIBRARIES)

$(TEST_ALL_COLORS_OBJ): $(FORTRAN_LIBGD_MOD) $(TEST_ALL_COLORS_F90)
	$(FORTRAN)  $(NOCOMPILE) $(TEST_ALL_COLORS_F90) $(CREATEOBJECT) $(TEST_ALL_COLORS_OBJ) $(MODULEPATH)

$(TEST_FONTS_EXE): $(TEST_FONTS_OBJ)
	$(LINKER) $(CREATEOBJECT) $(TEST_FONTS_EXE)  $(TEST_FONTS_OBJ) $(LIBRARIES)

$(TEST_FONTS_OBJ): $(FORTRAN_LIBGD_MOD) $(TEST_FONTS_F90)
	$(FORTRAN)  $(NOCOMPILE) $(TEST_FONTS_F90) $(CREATEOBJECT) $(TEST_FONTS_OBJ) $(MODULEPATH)

$(TEST_ANALYZE_IMAGE_EXE): $(TEST_ANALYZE_IMAGE_OBJ) $(FORTRAN_LIBGD_ARCHIVE)
	$(LINKER) $(CREATEOBJECT) $(TEST_ANALYZE_IMAGE_EXE)  $(TEST_ANALYZE_IMAGE_OBJ) $(FORTRAN_LIBGD_ARCHIVE)  $(LIBRARIES)

$(TEST_ANALYZE_IMAGE_OBJ): $(FORTRAN_LIBGD_MOD) $(TEST_ANALYZE_IMAGE_F90)
	$(FORTRAN)  $(NOCOMPILE) $(TEST_ANALYZE_IMAGE_F90) $(CREATEOBJECT) $(TEST_ANALYZE_IMAGE_OBJ) $(MODULEPATH)

$(TEST_EDGE_EXE): $(TEST_EDGE_OBJ) $(FORTRAN_LIBGD_ARCHIVE)
	$(LINKER) $(CREATEOBJECT) $(TEST_EDGE_EXE)  $(TEST_EDGE_OBJ) $(FORTRAN_LIBGD_ARCHIVE)  $(LIBRARIES)

$(TEST_EDGE_OBJ): $(FORTRAN_LIBGD_MOD) $(TEST_EDGE_F90)
	$(FORTRAN)  $(NOCOMPILE) $(TEST_EDGE_F90) $(CREATEOBJECT) $(TEST_EDGE_OBJ) $(MODULEPATH)

$(TEST_ANIMATION_EXE): $(TEST_ANIMATION_OBJ) $(FORTRAN_LIBGD_ARCHIVE)
	$(LINKER) $(CREATEOBJECT) $(TEST_ANIMATION_EXE)  $(TEST_ANIMATION_OBJ) $(FORTRAN_LIBGD_ARCHIVE)  $(LIBRARIES)

$(TEST_ANIMATION_OBJ): $(FORTRAN_LIBGD_MOD) $(TEST_ANIMATION_F90)
	$(FORTRAN)  $(NOCOMPILE) $(TEST_ANIMATION_F90) $(CREATEOBJECT) $(TEST_ANIMATION_OBJ) $(MODULEPATH)

$(TEST_IM_INT_ARRAY_EXE): $(TEST_IM_INT_ARRAY_OBJ) $(FORTRAN_LIBGD_ARCHIVE)
	$(LINKER) $(CREATEOBJECT) $(TEST_IM_INT_ARRAY_EXE)  $(TEST_IM_INT_ARRAY_OBJ) $(FORTRAN_LIBGD_ARCHIVE)  $(LIBRARIES)

$(TEST_IM_INT_ARRAY_OBJ): $(FORTRAN_LIBGD_MOD) $(TEST_IM_INT_ARRAY_F90)
	$(FORTRAN)  $(NOCOMPILE) $(TEST_IM_INT_ARRAY_F90) $(CREATEOBJECT) $(TEST_IM_INT_ARRAY_OBJ) $(MODULEPATH)

$(FORTRAN_LIBGD_OBJ): $(FORTRAN_LIBGD_MOD) 

$(FORTRAN_LIBGD_MOD): $(FORTRAN_LIBGD_F90)
	$(FORTRAN) $(NOCOMPILE) fortran_libgd.f90

$(LIBGD_H_WRAPPER_OBJ): $(LIBGD_H_WRAPPER_C)
	$(CC) $(NOCOMPILE) $(LIBGD_H_WRAPPER_C)

$(FORTRAN_LIBGD_ARCHIVE): $(FORTRAN_LIBGD_OBJ) $(LIBGD_H_WRAPPER_OBJ)
	$(ARCHIVER) $(FORTRAN_LIBGD_ARCHIVE)  *$(OBJEXT)

$(FORTRAN_LIBGD_SHARED):  $(FORTRAN_LIBGD_OBJ) $(LIBGD_H_WRAPPER_OBJ)
	$(SHAREDARCHIVER) *$(OBJEXT) $(CREATESHARED) $(CREATEOBJECT) $(FORTRAN_LIBGD_SHARED)

clean:
	$(REMOVE) *$(OBJEXT) *$(MODEXT) *$(ARCHIVEEXT) \
	$(TEST_FORTRAN_GD_EXE) $(TEST_FORTRAN_GD_OBJ)  \
	$(TEST_FORTRAN_GD_EXTENDED_EXE) $(TEST_FORTRAN_GD_EXTENDED_EXE) \
	$(TEST_POLYGON_EXE) $(TEST_POLYGON_OBJ) \
	$(TEST_ALL_COLORS_EXE) $(TEST_ALL_COLORS_OBJ) \
	$(TEST_FONTS_EXE) $(TEST_FONTS_OBJ) \
	$(TEST_ANALYZE_IMAGE_EXE) $(TEST_ANALYZE_IMAGE_OBJ) \
	$(TEST_EDGE_EXE) $(TEST_EDGE_OBJ)  \
	$(TEST_ANIMATION_EXE) $(TEST_ANIMATION_OBJ) \
        $(TEST_IM_INT_ARRAY_EXE) $(TEST_IM_INT_ARRAY_OBJ) \
        tests/outpics/*
