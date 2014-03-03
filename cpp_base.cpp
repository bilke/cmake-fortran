

#include <iostream>


//extern "C" void main_fortran_caller(int &pass_to_fortran);

// used by c++ to call f90
extern "C" void call_main_fortran(void);	
extern "C" void pass_variables(int &pass_to_fortran);

// used by f90 to call c++
extern "C" void call_for_vars();	
extern "C" void send_vars(int &var_from_f90);


using namespace std;

int main() {

	std::cout << "|C| main " << std::endl;
	call_main_fortran();

	std::cout << "|C| main - done " << std::endl;
	return 0;
}




void call_for_vars(void) {

	// gather vars here to be pushed
	int pass_int = 42;
	//, then:

	std::cout << "|C| call_for_vars, pass_int = " << pass_int << std::endl;
	pass_variables(pass_int);

}


void send_vars(int &var_from_f90){

	std::cout << "|C| send_vars, var_from_f90 = " << var_from_f90 << std::endl;

}
