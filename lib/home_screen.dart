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
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return GestureDetector(
            onTap: () {
              task.showDetails(context);
            },
            child: Card(
              elevation: 2,
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteTask(task.id!);
                  },
                ),
              ),
            ),
          );
        },
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
