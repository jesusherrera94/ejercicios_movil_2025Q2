import 'package:flutter/material.dart';
import 'dart:convert' as convert;


import '../models/user.dart';
import '../adapters/local_storage.dart';
import '../adapters/auth.dart';
import '../widgets/wave_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final LocalStorage _localStorage = LocalStorage();
  late  User _user;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    _loadUser();
  }

  void _loadUser() async {
    try {
      final userString = await _localStorage.getUserData('user');
    setState(() {
      _user = User.fromMap(convert.jsonDecode(userString));
    });
    } catch (e) {
      print('Error loading user $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void _editProfile() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Función de edición en desarrollo')));
  }

  void _logout(BuildContext context) async {
    await _localStorage.clearUserData();
    await Auth.signOut();
    Navigator.pushReplacementNamed(context, 'init');
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                color: Color(0xFF4589FF),
              ),
              Expanded(child: Container(color: Colors.white)),
            ],
          ),

          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 100,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Center(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFF4589FF), Color(0xFF6385BF)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF4589FF).withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(4),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  _user.profilePicture != null
                                      ? NetworkImage(_user.profilePicture!)
                                      : null,
                              child:
                                  _user.profilePicture == null
                                      ? Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Color(0xFF4589FF),
                                      )
                                      : null,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Color(0xFF4589FF),
                                ),
                                onPressed: _editProfile,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      FadeTransition(
                        opacity: _animation,
                        child: Text(
                          _user.username,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4589FF),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            _buildInfoCard(
                              'Name',
                              _user.fullname,
                              Color(0xFF6385BF),
                              Icons.person,
                            ),
                            SizedBox(height: 15),
                            _buildInfoCard(
                              'Email',
                              _user.email,
                              Color(0xFFAA9467),
                              Icons.email,
                            ),
                            SizedBox(height: 15),
                            _buildInfoCard(
                              'Principal Interest',
                              _user.principalInterest,
                              Color(0xFF626D80),
                              Icons.interests,
                            ),
                            SizedBox(height: 20),
                            WaveButton(
                            onPressed: () => _logout(context),
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color, width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF555149),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
