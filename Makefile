FORTRAN = gfortran
LINKER = gfortran
LIBRARIES = -lgd -lpng -lz -ljpeg -lfreetype -lm

OBJEXT = .o
EXEEXT =
MODEXT = .mod

NOCOMPILE = -c
MAKEEXE = -o
REMOVE = rm

MODULEPATH = -I .

FORTRAN_LIBGD_F90 = fortran_libgd.f90
FORTRAN_LIBGD_MOD = fortran_libgd$(MODEXT)

TEST_FORTRAN_GD_F90 = test_fortran_gd.f90
TEST_FORTRAN_GD_OBJ = test_fortran_gd$(OBJEXT)
TEST_FORTRAN_GD_EXE = test_fortran_gd$(EXEEXT)


$(TEST_FORTRAN_GD_EXE): $(TEST_FORTRAN_GD_OBJ)
	$(LINKER) $(MAKEEXE) test_fortran_gd$(EXEEXT)  $(TEST_FORTRAN_GD_OBJ) $(LIBRARIES)

$(TEST_FORTRAN_GD_OBJ): $(FORTRAN_LIBGD_MOD)
	$(FORTRAN)  $(NOCOMPILE) test_fortran_gd.f90 $(MODULEPATH)

$(FORTRAN_LIBGD_MOD): $(FORTRAN_LIBGD_F90)
	$(FORTRAN) $(NOCOMPILE) fortran_libgd.f90
clean:
	$(REMOVE) *$(OBJEXT) *$(MODEXT) $(TEST_FORTRAN_GD) *.jpeg *.png
