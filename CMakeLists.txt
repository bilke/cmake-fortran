cmake_minimum_required(VERSION 2.8.8)
project(fortranc)

# Load CMake's fortran_subdirectory-function
include(CMakeAddFortranSubdirectory)

# Adds the subdirectory "fortran" to this project
cmake_add_fortran_subdirectory(fortran
	PROJECT fortran
	ARCHIVE_DIR fortran/lib
	RUNTIME_DIR fortran/bin
	LIBRARIES fortran
	LINK_LIBRARIES
	NO_EXTERNAL_INSTALL
)

# Creates an executable "test" from the given C++ source file
add_executable(test cpp_base.cpp)

# Links the custom library "fortran" and the standard fortran library "gfortran"
# (which was previously added as a subdirectory) to the "test"-executable
target_link_libraries(test fortran gfortran)
