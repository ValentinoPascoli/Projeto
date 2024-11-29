import 'package:flutter/material.dart';
import 'home.dart'; // Importa a tela de home

void main() => runApp(LavaRapidoApp());

class LavaRapidoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaLogin(), // Inicia pela tela de login
    );
  }
}

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _senhaController = TextEditingController();

  // Senha do administrador
  final String senhaValida = 'valen123';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Digite a senha do administrador',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _senhaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Valida a senha digitada
                if (_senhaController.text == senhaValida) {
                  // Se a senha for correta, navega para a TelaHome
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TelaHome()),
                  );
                } else {
                  // Caso a senha seja incorreta, exibe uma mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Senha incorreta!'),
                    ),
                  );
                }
              },
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
