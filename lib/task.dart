import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task {
  int? id;
  String title;
  String description;
  String priority;
  String dueDate;
  String dueTime;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    required this.dueTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'dueDate': dueDate,
      'dueTime': dueTime,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
      dueDate: map['dueDate'],
      dueTime: map['dueTime'],
    );
  }

  Future<void> showDetailsDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalhes da Tarefa'),
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
                    title,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Descrição:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    description,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Prioridade:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    priority,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Data de Entrega:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '$dueTime $dueDate',
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
      },
    );
  }

  static Future<Task?> createTask(BuildContext context) async {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();
    String selectedPriority = 'Alta';
    String selectedDate = '';
    String selectedTime = '';

    return await showDialog<Task>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Criar Tarefa'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: null,
                    ),
                    SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          selectedPriority = value!;
                        });
                      },
                      items: ['Alta', 'Média', 'Baixa']
                          .map((priority) => DropdownMenuItem<String>(
                                value: priority,
                                child: Text(priority),
                              ))
                          .toList(),
                      decoration: InputDecoration(
                        labelText: 'Prioridade',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      readOnly: true,
                      controller: TextEditingController(text: selectedDate),
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            selectedDate =
                                DateFormat('dd/MM/yyyy').format(pickedDate);
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Data de Entrega',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      readOnly: true,
                      controller: TextEditingController(text: selectedTime),
                      onTap: () async {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          setState(() {
                            selectedTime = pickedTime.format(context);
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Hora de Entrega',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final newTask = Task(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      priority: selectedPriority,
                      dueDate: selectedDate,
                      dueTime: selectedTime,
                    );

                    if (_validateForm(
                        newTask.title,
                        newTask.description,
                        newTask.priority,
                        newTask.dueDate,
                        newTask.dueTime)) {
                      Navigator.of(context).pop(newTask);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Por favor, preencha todos os campos.'),
                        ),
                      );
                    }
                  },
                  child: Text('Criar Tarefa'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static bool _validateForm(
    String title,
    String description,
    String priority,
    String dueDate,
    String dueTime,
  ) {
    return title.isNotEmpty &&
        description.isNotEmpty &&
        priority.isNotEmpty &&
        dueDate.isNotEmpty &&
        dueTime.isNotEmpty;
  }
}