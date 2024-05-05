import 'package:hive/hive.dart';

class TodoDatabase {
  final _myBox = Hive.box('todobox');

  List todoTasks = [];

  void createInitialData() {
    todoTasks = [
      {'isChecked': true, 'taskName': 'My Task 1'},
      {'isChecked': false, 'taskName': 'My Task 2'},
    ];
  }

  void updateDb() {
    _myBox.put('TODOLIST', todoTasks);
  }

  void loadData() {
    todoTasks = _myBox.get('TODOLIST');
  }
}
