

void main() {
  int age = 18;
  // esta variable es opcional por el simbolo de interrogacion
  double? money = 0.00;
  bool isAuthenticated = false;
  String name = 'Dario';
  const double PI = 3.1415;
  var unknown = true;
  dynamic dynVar = 'cadena';

  // colecciones
  List<int> a = [10,20,30,40];
  List<String> names = ['Juan', 'Pedro', 'Manuel', 'Alguien random!'];
  Map<String, dynamic> b = {
    "foo": 1,
    "foo2": 3.14,
    "name": "Carlos",
  };

  print('age: $age, money: $money, $isAuthenticated, $name');
  print(unknown);

  // if, else, switch
  if (isAuthenticated) {
    print("login!");
  } else {
    print("access denied!");
  }

  for(int i=0; i<4; i++) {
    print(a[i]);
  }
  for(int i = 0; i<names.length; i++)  {
    print('name: ${names[i]}');
  }
  print('===================================================');
  for(int j in a) {
    print(j);
  }
  for (var name in names) {
    print('2name: ${name}');
  }
  print(b["foo2"]);



}