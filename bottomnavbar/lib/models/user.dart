class User {
  String id; // coleccion de firebase
  String username;
  String fullname;
  String email;
  String password;
  String principalInterest;
  String? profilePicture;
  String? uid; // firebase, para el futuro!

  User({
    this.id = '',
    this.profilePicture,
    required this.username,
    required this.fullname,
    required this.email,
    required this.password,
    required this.principalInterest,
    this.uid
  });
}
