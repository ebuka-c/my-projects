import 'package:_myprojects/todo_app/components/my_alert.dart';
import 'package:_myprojects/todo_app/components/todo_tile.dart';
import 'package:_myprojects/todo_app/hive_database/database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  TodoDatabase db = TodoDatabase();
  final _taskController = TextEditingController();

  final _myBox = Hive.box('todobox');

  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoTasks[index]['isChecked'] = !db.todoTasks[index]['isChecked'];
    });
    db.updateDb();
  }

  void createNewTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        db.todoTasks
            .add({'isChecked': false, 'taskName': _taskController.text});
      });
      db.updateDb();
      Navigator.pop(context);
      _taskController.clear();
    } else {
      print('no task created');
    }
  }

  void deleteFn(int index) {
    setState(() {
      db.todoTasks.removeAt(index);
    });
    db.updateDb();
  }

  void dialogFn() {
    showDialog(
        context: context,
        builder: (context) => MyAlert(
            onSaved: createNewTask,
            onCancel: () => Navigator.pop(context),
            controller: _taskController));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'TO-DO',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true),
      body: ListView.builder(
          itemBuilder: (context, index) => TodoTile(
                done: db.todoTasks[index]['isChecked'],
                onChanged: (value) => checkBoxChanged(value, index),
                taskName: db.todoTasks[index]['taskName'],
                deleteFunction: (context) => deleteFn(index),
              ),
          itemCount: db.todoTasks.length),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: dialogFn,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
