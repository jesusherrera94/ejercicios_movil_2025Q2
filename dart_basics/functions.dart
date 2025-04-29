
void sayHello() {
  print('Hello!');
}

String getUserName() {
  return 'uuid!';
}


// funcion  con argumentos posicionales

void printNames(String name, String lastName) {
  print('fullname: ${name} ${lastName}');
}

// funcion con argumentos nombrados: se utilizan cuando los argumentos son 3 o mas!

void printNamesAndAge({required String name, required String lastName, int? age}) {
  if (age != null && age > 0) {
    print('fullname and age: ${name} ${lastName}, ${age}');
  } else {
    print('fullname: ${name} ${lastName}');
  }
}




void main() {
  sayHello();
  print(getUserName());
  printNames('Jesus', 'Herrera');
  printNamesAndAge(name: 'Jesus', lastName: 'Herrera');
  printNamesAndAge(lastName: 'Veliz', name: 'Dario', age: 0);
  printNamesAndAge( age: 23, name: 'Genesis', lastName: 'Suazo');
}