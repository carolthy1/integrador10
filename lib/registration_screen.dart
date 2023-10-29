import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UsersDatabaseHelper _databaseHelper = UsersDatabaseHelper();
  String _errorMessage = '';

  void _registerUser() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      return;
    }

    final db = await _databaseHelper.db;
    final user = await db!.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (user.isEmpty) {
      await db.insert(
        'users',
        {'email': email, 'password': password},
      );

      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('user_logged_in', true);
      prefs.setString('user_email', email);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      setState(() {
        _errorMessage = 'Usuário já existe. Tente outro email.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _registerUser,
              child: Text('Cadastrar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Já tem uma conta? Faça login'),
            ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
