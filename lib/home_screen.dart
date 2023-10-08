import 'package:flutter/material.dart';
import 'package:integrador2/task_detail.dart';
import 'database.dart';
import 'task.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final db = await DatabaseHelper().db;
    final tasks = await db!.query('tasks');

    final List<Task> highPriorityTasks = [];
    final List<Task> mediumPriorityTasks = [];
    final List<Task> lowPriorityTasks = [];

    tasks.forEach((taskMap) {
      final task = Task.fromMap(taskMap);
      if (task.priority == 'Alta') {
        highPriorityTasks.add(task);
      } else if (task.priority == 'Média') {
        mediumPriorityTasks.add(task);
      } else if (task.priority == 'Baixa') {
        lowPriorityTasks.add(task);
      }
    });

    setState(() {
      _tasks.clear();
      _tasks.addAll(highPriorityTasks);
      _tasks.addAll(mediumPriorityTasks);
      _tasks.addAll(lowPriorityTasks);
    });
  }

  Future<void> _deleteTask(int taskId) async {
    final db = await DatabaseHelper().db;
    await db!.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Wave'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 13.0, left: 8.0, right: 8.0), // Adicione margem apenas no topo
        child: ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            final task = _tasks[index];
            return GestureDetector(
              onTap: () {
                task.showDetails(context);
              },
              child: Card(
                elevation: 3,
                margin: EdgeInsets.all(8),
                color: Color.fromARGB(181, 255, 254, 254),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0), // Arredonda as bordas
                ),
                child: ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      height: 2,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10), // Ajuste o tamanho deste espaço em branco
                      Text(
                        'Data de Entrega: ${task.dueDate}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10), // Adicione a margem inferior aqui
                        child: Text(
                          'Hora de Entrega: ${task.dueTime}',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Container(
                    margin: EdgeInsets.all(5), // Adicione margens ao redor do ícone
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteTask(task.id!);
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createTask(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _createTask(BuildContext context) async {
    final createdTask = await Task.createTask(context);
    if (createdTask != null) {
      final db = await DatabaseHelper().db;
      await db!.insert('tasks', createdTask.toMap());
      _loadTasks();
    }
  }
}
