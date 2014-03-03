
! provide allocatable vars, when needed, ie if c++ coupled
module global
	implicit none
   !real, allocatable, dimension(:) :: Ar
	logical, allocatable :: get_var_from_cpp, send_var_to_cpp
	integer, allocatable :: var_from_cpp

	! interface needed for communication from f90 to c++
	interface
		subroutine call_for_vars() bind(C, NAME="call_for_vars")
			!use iso_c_binding	! needed?
		end subroutine call_for_vars

		subroutine send_vars(var_for_cpp) bind(C, Name="send_vars")
			integer :: var_for_cpp
		end subroutine send_vars
	end interface

end module global


subroutine allocate_vars
	use global
	implicit none
	allocate(get_var_from_cpp)
	allocate(send_var_to_cpp)
	allocate(var_from_cpp)
end subroutine allocate_vars


!program global_var
!    use global
!    implicit none
!    call allocateAr
!    call useAr
!end program global_var





! this gets the call from c++ to start main_fortran
subroutine call_main_fortran() bind(C, NAME="call_main_fortran")
	use global
	implicit none

	print*, "|F| call_main_fortran"

	! first, allocate otherwise not used vars
	call allocate_vars
	! set bool to true, ie request vars from c++ when reading input
	get_var_from_cpp = .TRUE.
	send_var_to_cpp = .TRUE.

	call main_fortran

end subroutine call_main_fortran


! changed from program to subroutine, that no name-mangling is needed
!program main_fortran 		
subroutine main_fortran
	implicit none
	integer :: a_fortran_int
	a_fortran_int = 3

	print*, "|F| main"

	! somewhen, this will read some vars
	call read_vars

	! calculate fancy stuff
	call do_something_with_vars(a_fortran_int)

	! write output
	call write_output(a_fortran_int)

!end program main_fortran
end subroutine main_fortran


! routine to read vars
subroutine read_vars
	use global
	implicit none
	
	print*, "|F| read_vars"

	! check, if flag to read from c++ is set
	if (.NOT. get_var_from_cpp) then
		print*, "continue normal reading"
	else
		call call_for_vars( )
	end if

end subroutine read_vars


! routine to get c++ vars
subroutine pass_variables(pass_from_c) bind(C, NAME="pass_variables")
	use global
	implicit none
	integer, intent(in) :: pass_from_c

	var_from_cpp = pass_from_c
	print*, "|F| pass_variables, var_from_cpp ", var_from_cpp

end subroutine pass_variables


! fancy stuff
subroutine do_something_with_vars(changed_var)
	use global
	implicit none
	integer, intent (out) :: changed_var

	print*, "|F| do_something_with_vars"

	changed_var = var_from_cpp + 1

end subroutine do_something_with_vars


!write some output
subroutine write_output(output_var)
	use global
	implicit none
	integer, intent(in) :: output_var

	! check, if flag to send back to c++ is set
	if (.NOT. send_var_to_cpp) then
		print*, "continue normal output"
	else
		call send_vars(output_var)
	end if

end subroutine write_output