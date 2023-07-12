#include <iostream>

int main() {
  int insertar_numero, numero = 1, ultimo_numero = 0;
  std::cout << "Insertar un número: ";
  std::cin >> insertar_numero;
  if(insertar_numero <= 0) {
    std::cout << "El número debe de ser mayor que 0 " << std::endl;
    return 0;
  }
  while(insertar_numero >= 0) {
    int numero_en_cabeza = numero + ultimo_numero;
    ultimo_numero = numero;
    numero = numero_en_cabeza;
    int suma = suma + ultimo_numero;
    insertar_numero--;
  }
  std::cout << "La suma de los términos de la serie de fibonacci es: " << ultimo_numero << std::endl;
  return 0;
}