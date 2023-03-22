#include <iostream>
#include <cmath>

using namespace std;

int main() {
  int iteraciones = 0;
  double numero;
  cout << "Introducir un número para saber cuántas iteracciones son necesarias para que este al dividir su valor absoluto entre 2 sea menor que 0.00005: ";
  cin >> numero;
  double valor_absoluto = fabs(numero);
  for(iteraciones = 0; valor_absoluto >= 0.00005; iteraciones++) {
    valor_absoluto /= 2;
  }
  cout << "Hacen falta: " << iteraciones << " iteraciones" << endl; 
  return 0;
}