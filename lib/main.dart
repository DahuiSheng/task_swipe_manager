import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_swipe_manager/database/task_database.dart';
import 'package:task_swipe_manager/models/task.dart';
import 'package:task_swipe_manager/widgets/task_swipe_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Swipe Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => TaskNotifier(),
        child: TaskSwipeManagerScreen(),
      ),
    );
  }
}

class TaskSwipeManagerScreen extends StatefulWidget {
  @override
  _TaskSwipeManagerScreenState createState() => _TaskSwipeManagerScreenState();
}

class _TaskSwipeManagerScreenState extends State<TaskSwipeManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Swipe Manager'),
      ),
      body: Consumer<TaskNotifier>(
        builder: (context, taskNotifier, _) {
          return TaskSwipeCard(
            tasks: taskNotifier.tasks,
            onSwipe: (task, isSwipeRight) {
              setState(() {
                taskNotifier.swipeTask(task, isSwipeRight);
              });
            },
          );
        },
      ),
    );
  }
}

class TaskNotifier extends ChangeNotifier {
  final TaskDatabase _taskDatabase = TaskDatabase.instance;
  List<Task> _tasks = [];

  TaskNotifier() {
    _fetchTasks();
  }

  List<Task> get tasks => _tasks;

  Future<void> _fetchTasks() async {
    _tasks = await _taskDatabase.readAllTasks();
    notifyListeners();
  }

  void swipeTask(Task task, bool isSwipeRight) {
    if (isSwipeRight) {
      task = task.copy(status: 'completed');
      _taskDatabase.update(task);
    } else {
      _taskDatabase.delete(task.id!);
    }
    _tasks.remove(task);
    notifyListeners();
  }
}
