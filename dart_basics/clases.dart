/*
 * Crea un juego de rol simple donde los jugadores puedan equiparse con diferentes tipos de armas. 
 * Implementa una clase abstracta Arma y varias clases concretas que hereden de ella 
 * (por ejemplo, Espada, Arco, Varita).
 *  Cada arma debe tener atributos como daño, rango y velocidad de ataque.
 *  La clase Player debe tener un atributo para almacenar el arma equipada y 
 *  métodos para atacar y cambiar de arma.
 * */

abstract class Weapon {
  int _damage = 0;
  int _range = 0;
  int _speed = 0;

  Weapon(this._damage, this._range, this._speed);
  void attack();
}

class Sword extends Weapon {
  Sword(int damage, int range, int speed) : super(damage, range, speed);
  @override
  void attack() {
    print('swosh!!!!!! 🤺🤺🤺🤺🤺🤺🤺');
  }
}

class MachineGun extends Weapon {
  MachineGun(int damage, int range, int speed) : super(damage, range, speed);
  @override
  void attack() {
    print('TRRRRRRRR!!!!! 🔫🔫🔫🔫🔫🔫🔫🔫');
  }
}

class Rock extends Weapon {
  Rock(int damage, int range, int speed) : super(damage, range, speed);
  @override
  void attack() {
    print('dust!!!!!!!! 🪨🪨🪨🪨🪨🪨🪨🪨🪨');
  }
}


class Player {
  String _playerName = '';
  int life = 0;
  Weapon? _wp;

  //constructor por defecto
  Player(this._playerName, this.life);

  // constructor nombrado con argumentos nombrados
  Player.playerWeapon({required String playername, required int life, required Weapon wp}) {
    this._playerName = playername;
    this.life = life;
    this._wp = wp;
  }

  String get playerName => this._playerName;

  void attack() {
    if (_wp != null) {
      _wp!.attack();
    } else {
      // default
      print('👊👊👊👊👊👊👊👊👊👊👊👊👊');
    }
  }

  void changeWeapon(Weapon newWeapon) {
    this._wp = newWeapon;
  }

  void walk() {
    print('Walking!!!!! 🚶');
  }

}



void main() {
print('============ Initalize! =========');

Player player1 = Player('Gsus', 100);
  print('Player 1: ${player1.playerName}');
  player1.attack();
  player1.walk();

  print('======================================================');
  Sword sw = Sword(2, 1, 15);
  MachineGun mg = MachineGun(100, 200, 1000);
  Rock rock = Rock(10, 2, 1);
  // invocando constructor nombrando con argumentos nombrados
  Player player2 = Player.playerWeapon(playername: 'Dario', life: 100, wp: mg);

  print('Player 2: ${player2.playerName}');
  player2.attack();
  player2.changeWeapon(sw);
  player2.attack();
  player2.changeWeapon(rock);
  player2.attack();

}
