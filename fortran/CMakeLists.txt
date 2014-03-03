cmake_minimum_required (VERSION 2.8.8)
project(fortran)

# Enable CMake's fortran features
enable_language(Fortran)

# Creates a fortran library with the name "fortran"
# from the specified fortran source files
add_library(fortran
	fortran_base.f90
)
