#include <iostream>
#include <cmath>

int main() {
  /**
   * Como short tiene una capacidad para 16 bits y el número colocado sobrepasa el límite, entonces por eso da un resultado negativo
  */
  short a = 32767;
  a += 1;
  std::cout << a << std::endl;
  return 0;
}
