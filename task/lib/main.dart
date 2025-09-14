// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:task/model/tarefa.dart';
import 'package:task/telas/list_item.dart';

void main() {
  runApp(const MaterialApp(
    home: Task(),
  ));
}

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  TextEditingController tarefaController = TextEditingController();

  List<Tarefa> tarefas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: tarefaController,
                            decoration: const InputDecoration(
                                labelText: "Nome tarefa",
                                border: OutlineInputBorder(),
                                hintText: "Ex. Estudar Flutter"),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        // ignore: duplicate_ignore
                        ElevatedButton(
                          onPressed: () {
                            String nomeTarefa = tarefaController.text;
                            DateTime dataTarefa = DateTime.now();
                            setState(() {
                              Tarefa tarefa = Tarefa(nomeTarefa, dataTarefa);
                              tarefas.add(tarefa);
                            });
                            tarefaController.clear();
                          },
                          child: const Icon(
                            Icons.add,
                            size: 30,
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 5, 227, 239),
                              padding: const EdgeInsets.all(14)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (Tarefa tarefa in tarefas)
                            ListItem(tarefa, onDelete)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("Você possui 0 tarefas")),
                        ElevatedButton(
                          onPressed: showDeleteTarefaAll,
                          child: const Text("Limpa tudo"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(231, 6, 6, 1),
                              padding: const EdgeInsets.all(14)),
                        )
                      ],
                    )
                  ],
                ))));
  }

  void onDelete(Tarefa tarefa) {
    setState(() {
      tarefas.remove(tarefa);
    });

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tarefa ${tarefa.nome} foi removida")));
  }

  void showDeleteTarefaAll() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Limpa tudo"),
              content: Text("Tem certeza que deseja apagar todas as tarefas?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child:
                        Text("Cancela", style: TextStyle(color: Colors.green))),
                TextButton(
                    onPressed: limparTarefas,
                    child: Text("Limpar tudo",
                        style: TextStyle(
                            color: Color.fromARGB(255, 241, 10, 10)))),
              ],
            ));
  }

  void limparTarefas() {
    setState(() {
      tarefas.clear();
  }
    );
    Navigator.pop(context);
    
  }
}
