#include <ctime>
#include <string>
#include <iostream>

std::string get_greet(const std::string& who) {
  return "Hello " + who;
}

void print_localtime() {
  std::time_t result = std::time(nullptr);
  std::cout << std::asctime(std::localtime(&result));
}

int main(int argc, char** argv) {
  wprintf(L"\n");

  std::string who = "world";
  if (argc > 1) {
    who = argv[1];
  }
  std::cout << get_greet(who) << std::endl;

if (sizeof(void*) == 8) {
  wprintf(L"Bitness = 64\n");
}
if (sizeof(void*) == 4) {
  wprintf(L"Bitness = 32\n");
}

#ifdef _DEBUG
  wprintf(L"compilation_mode = _DEBUG\n");
#endif
#ifdef NDEBUG
  wprintf(L"compilation_mode = NDEBUG\n");
#endif


  //print_localtime();
  return 0;
}
