import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft, // Começa da esquerda
            end: Alignment.centerRight, // Termina na direita
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
                      borderRadius:
                          BorderRadius.circular(20), // Borda arredondada
                      child: Image.asset(
                        'assets/study_wave.png',
                        width: 150,
                        height: 150,
                      ),
                    ), // Substitua pelo caminho da sua imagem

                    SizedBox(height: 30), // Espaço entre a imagem e o texto

                    Text(
                      'Study Wave', // Nome do seu aplicativo
                      style: TextStyle(
                        fontFamily: 'MinhaFonte',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10), // Espaço entre o título e a descrição

                    Text(
                      'Sua melhor plataforma de estudo.',
                      style: TextStyle(fontFamily: 'OpenSans', fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          228, 184, 119, 202), // Cor personalizada
                      minimumSize: Size(400, 40), // Tamanho do botão
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Borda arredondada
                      ),
                      side: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0), // Cor da borda
                        width: 1.0, // Largura da borda
                      ),
                    ),
                    child: Text(
                      'Começar agora',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 17,
                        color: Color.fromARGB(255, 0, 0, 0), // Cor do texto
                      ),
                    ),
                  ),

                  SizedBox(height: 5), // Espaço entre os botões

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          186, 151, 110, 183), // Cor personalizada
                      minimumSize: Size(400, 40), // Tamanho do botão
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Borda arredondada
                      ),
                      side: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0), // Cor da borda
                        width: 1.0, // Largura da borda
                      ),
                    ),
                    child: Text(
                      'Já tenho uma conta',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 17,
                        color: Color.fromARGB(255, 0, 0, 0), // Cor do texto
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
