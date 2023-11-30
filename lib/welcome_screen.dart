import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(255, 228, 203, 231),
              Color.fromARGB(255, 203, 176, 243),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/study_wave.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Study Wave',
                      style: TextStyle(
                        fontFamily: 'MinhaFonte',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Sua melhor plataforma de estudo.',
                      style: TextStyle(fontFamily: 'OpenSans', fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 100.0), // Ajuste o valor conforme necessário
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 221, 195, 245),
                        minimumSize: Size(300, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          color: Color.fromARGB(255, 112, 112, 112),
                          width: 0.5,
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'Começar agora',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 221, 195, 245),
                        minimumSize: Size(300, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          color: Color.fromARGB(255, 112, 112, 112),
                          width: 0.5,
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'Já tenho uma conta',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
