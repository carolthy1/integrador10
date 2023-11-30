// task_detail.dart
import 'package:flutter/material.dart';
import 'task.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;

  TaskDetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(16.0),
      title: Row(
        children: [
          Icon(Icons.info_outline, size: 30.0),
          SizedBox(width: 8.0),
          Text(
            'Detalhes da Tarefa',
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                'Título:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                task.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              title: Text(
                'Descrição:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                task.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              title: Text(
                'Prioridade:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                task.priority,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              title: Text(
                'Data de Entrega:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                task.dueDate,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              title: Text(
                'Hora de Entrega:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                task.dueTime,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Fechar'),
        ),
      ],
    );
  }
}
