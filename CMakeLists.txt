cmake_minimum_required(VERSION 2.8.8)
project(fortranc)
include(CMakeAddFortranSubdirectory)

cmake_add_fortran_subdirectory(fortran
	PROJECT fortran
	ARCHIVE_DIR fortran/lib
	RUNTIME_DIR fortran/bin
)

add_executable(test cpp_base.cpp)
