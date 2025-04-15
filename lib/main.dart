import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ListaDeTarefas(),
    debugShowCheckedModeBanner: false,
  ));
}

class Tarefa {
  String nome;
  bool concluida;

  Tarefa({required this.nome, this.concluida = false});
}

class ListaDeTarefas extends StatefulWidget {
  @override
  State<ListaDeTarefas> createState() => _ListaDeTarefasState();
}

class _ListaDeTarefasState extends State<ListaDeTarefas> {
  List<Tarefa> tarefas = [];
  TextEditingController controller = TextEditingController();

  void adicionarTarefa(String nome) {
    setState(() {
      tarefas.add(Tarefa(nome: nome));
      controller.clear();
    });
  }

  void removerTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
  }

  void alternarConcluida(int index) {
    setState(() {
      tarefas[index].concluida = !tarefas[index].concluida;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(7),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(labelText: 'Nova tarefa'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      adicionarTarefa(controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = tarefas[index];
                return ListTile(
                  title: Text(
                    tarefa.nome,
                    style: TextStyle(
                      decoration: tarefa.concluida
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: tarefa.concluida,
                    onChanged: (_) => alternarConcluida(index),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => removerTarefa(index),
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