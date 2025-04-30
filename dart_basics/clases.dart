abstract class Weapon {
  int _damage = 0;
  int _range = 0;
  Weapon(this._damage, this._range);
  void attack();
}

class Sword extends Weapon {
  Sword(int damage, int range): super(damage,range);
  @override
  void attack() {
    print('swosh!!!! 🤺🤺🤺🤺');
  }
}

class MachineGun extends Weapon {
  MachineGun(int damage, int range): super(damage,range);
  @override
  void attack() {
    print('trrrrrrr!!!! 🔫🔫🔫🔫');
  }
}


class Player {
  String _playerName = '';
  int life = 0;

  Weapon? _wp;

  Player(this._playerName, this.life);

  Player.playerWeapon({ required String playerName, required int life, required Weapon wp}) {
    this._playerName = playerName;
    this.life = life;
    this._wp = wp;
  }

  String get playerName => this._playerName;

  void attack() {
    if (_wp != null) {
      _wp!.attack();
    } else {
      print('No attack available!!!! 😵');
    }
  }

  void changeWeapon( Weapon newWeapon) {
    this._wp = newWeapon;
  }

  void walk() {
    print('walking!!!!');
  }

}


void main() {
  Player player = Player('Gsus', 100);
  print('Player: ${player.playerName}');
  player.attack();
print('=============================================================');
  Sword sw = Sword(3, 1);
  MachineGun mg = MachineGun(70, 100);
  Player player2 = Player.playerWeapon(playerName: 'No name!', life: 100, wp: mg);
  print('Player 2: ${player2.playerName}');
  player2.attack();
  player2.changeWeapon(sw);
  player2.attack();
}