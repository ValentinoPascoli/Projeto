import 'package:flutter/material.dart';

void main() => runApp(LavaRapidoApp());

class LavaRapidoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaHome(),
    );
  }
}

class TelaHome extends StatefulWidget {
  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  // Lista para armazenar os carros cadastrados
  List<Map<String, String>> carros = [];

  // Contador para a quantidade de carros a lavar
  int carrosCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlashCar'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaCadastro(
                          onCadastrar: (nome, placa) {
                            setState(() {
                              carros.add({
                                'cliente': nome,
                                'placa': placa,
                                'status': 'A lavar',
                              });
                              carrosCount++; // Incrementa o contador
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: const Text('Adicionar Carro'),
                ),
                Text(
                  'Carros a Lavar: $carrosCount', // Exibe o contador
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cliente', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Placa', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Divider(),
          // Exibir os carros cadastrados
          Expanded(
            child: carros.isEmpty
                ? const Center(child: Text('Nenhum carro cadastrado'))
                : ListView.builder(
                    itemCount: carros.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                carros[index]['cliente']!,
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                carros[index]['placa']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                carros[index]['status']!,
                                textAlign: TextAlign.right,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class TelaCadastro extends StatefulWidget {
  final Function(String, String) onCadastrar;

  TelaCadastro({required this.onCadastrar});

  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _placaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Carro'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Insira o nome do cliente',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                hintText: 'Nome do cliente',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Placa do carro',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _placaController,
              decoration: const InputDecoration(
                hintText: 'Placa do carro',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String nome = _nomeController.text;
                  String placa = _placaController.text;

                  if (nome.isNotEmpty && placa.isNotEmpty) {
                    widget.onCadastrar(nome, placa);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preencha todos os campos!'),
                      ),
                    );
                  }
                },
                child: const Text('Cadastrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
