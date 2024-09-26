import 'package:flutter/material.dart';
import 'package:projetolista/model/pessoa.dart';
import 'package:projetolista/sextou.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App Lista para Widget",
      home: Tela1(),
    );
  }
}

class Tela1 extends StatefulWidget {
  const Tela1({super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  List<Pessoa> lista = [
    Pessoa(nome: "Victor", idade: 37, sobrenome: "Alves", cpf: "000.000.000-00"),
    // Você pode adicionar mais pessoas aqui
  ];

  void removerItem(int index) {
    setState(() {
      lista.removeAt(index);
    });
  }

  void adicionarPessoa(Pessoa pessoa) {
    setState(() {
      lista.add(pessoa);
    });
  }

  void abrirModalCadastro() {
    final nomeController = TextEditingController();
    final sobrenomeController = TextEditingController();
    final idadeController = TextEditingController();
    final cpfController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: sobrenomeController,
                decoration: InputDecoration(labelText: 'Sobrenome'),
              ),
              TextField(
                controller: idadeController,
                decoration: InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final nome = nomeController.text;
                  final sobrenome = sobrenomeController.text;
                  final idade = int.tryParse(idadeController.text) ?? -1;
                  final cpf = cpfController.text;

                  if (nome.isNotEmpty && sobrenome.isNotEmpty && idade > 0 && cpf.isNotEmpty) {
                    final novaPessoa = Pessoa(nome: nome, idade: idade, sobrenome: sobrenome, cpf: cpf);
                    adicionarPessoa(novaPessoa);
                    Navigator.of(context).pop(); // Fecha o modal
                  }
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Lista para Widget"),
        backgroundColor: Colors.cyan,
      ),
      body: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, index) {
          return Sextou(
            nome: lista[index].nome,
            sobrenome: lista[index].sobrenome,
            onRemove: () => removerItem(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: abrirModalCadastro,
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
