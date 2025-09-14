// ignore_for_file: use_key_in_widget_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:task/model/tarefa.dart';

class ListItem extends StatefulWidget {
  const ListItem(this.tarefa, this.onDelete);
  final Tarefa tarefa;
  final Function(Tarefa) onDelete;
  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.green[200],
          ),


          padding: const EdgeInsets.all(12),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
           children:[ Text(
              DateFormat('dd/MM/yyy').format(widget.tarefa.data),
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)
                ),
            Text(widget.tarefa.nome,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                ),
        ]),
        ),
        actionPane: const SlidableBehindActionPane(),
        secondaryActions: [
          IconSlideAction(
              color: Colors.red,
              caption: "Deletar",
              icon: Icons.delete,
              onTap: () {
                widget.onDelete(widget.tarefa);
              }),
          
        ]);
  }
}
