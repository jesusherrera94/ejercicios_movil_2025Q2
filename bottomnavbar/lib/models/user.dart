class User {
  String id;
  String username;
  String fullname;
  String email;
  String password;
  String principalInterest;
  String? profilePicture;
  String? uid;

  User({
    this.id = '',
    this.profilePicture,
    required this.username,
    required this.fullname,
    required this.email,
    required this.password,
    required this.principalInterest,
    this.uid,
  }); 
  
  }