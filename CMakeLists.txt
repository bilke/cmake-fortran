cmake_minimum_required(VERSION 2.8.8)
project(fortranc)
include(CMakeAddFortranSubdirectory)

cmake_add_fortran_subdirectory(fortran
	PROJECT fortran
	ARCHIVE_DIR fortran/lib
	RUNTIME_DIR fortran/bin
	LIBRARIES fortran
	LINK_LIBRARIES
	NO_EXTERNAL_INSTALL
)

add_executable(test cpp_base.cpp)
target_link_libraries(test fortran gfortran)
