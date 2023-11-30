import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _resetPasswordRequested = false;
  final _formKey = GlobalKey<FormState>();

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _loginUser() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Após o login bem-sucedido, defina o estado de login no SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('user_logged_in', true);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = _getFirebaseAuthErrorMessage(e.code);
        });
        _showErrorDialog(_errorMessage);
      } catch (e) {
        setState(() {
          _errorMessage = 'Ocorreu um erro inesperado: $e';
        });
        _showErrorDialog(_errorMessage);
      }
    }
  }

  void _resetPassword() async {
    if (_resetPasswordRequested) {
      return;
    }

    final email = _emailController.text;

    try {
      setState(() {
        _resetPasswordRequested = true;
      });

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Um e-mail de redefinição de senha foi enviado para $email'),
        ),
      );
    } catch (e) {
      print('Erro ao enviar e-mail de redefinição de senha: $e');
    } finally {
      setState(() {
        _resetPasswordRequested = false;
      });
    }
  }

  String _getFirebaseAuthErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'O email fornecido não é válido.';
      case 'user-not-found':
        return 'Nenhuma conta encontrada com este email.';
      case 'wrong-password':
        return 'Senha incorreta. Verifique sua senha e tente novamente.';
      default:
        return 'Erro ao fazer login. Tente novamente mais tarde.';
    }
  }

  Widget _buildInputField({
    required String labelText,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
    required String? Function(String?) validator,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          icon: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(icon),
          ),
          border: InputBorder.none,
        ),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }

  Widget _buildResetPasswordButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: InkWell(
        onTap: _resetPassword,
        child: Text(
          'Esqueci minha senha',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 100),
              Text(
                'Study Wave',
                style: TextStyle(
                  fontFamily: 'MinhaFonte',
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 220),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildInputField(
                        labelText: 'Email',
                        controller: _emailController,
                        icon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe seu email';
                          }
                          return null;
                        },
                      ),
                      _buildInputField(
                        labelText: 'Senha',
                        controller: _passwordController,
                        icon: Icons.lock,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe sua senha';
                          }
                          if (value.length < 6) {
                            return 'A senha deve conter pelo menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      _buildResetPasswordButton(),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _resetPasswordRequested ? null : _loginUser,
                        child: Text('Login'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 191, 162, 211),
                          ),
                          overlayColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 177, 156, 202)!,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: Color.fromARGB(255, 221, 195, 245),
                              ),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                              horizontal: 40.0,
                              vertical: 10.0,
                            ),
                          ),
                        ),
                      ),
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _errorMessage,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
