import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
      {super.key,
      required this.done,
      this.onChanged,
      required this.taskName,
      this.deleteFunction});

  final bool done;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final String taskName;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    topRight: Radius.circular(12)),
                backgroundColor: Colors.red.shade300)
          ],
        ),
        child: Container(
            height: 100,
            width: screenSize.width,
            decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              Checkbox(value: done, onChanged: onChanged),
              Text(taskName,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      decoration: done ? TextDecoration.lineThrough : null,
                      decorationColor: Colors.white))
            ])),
      ),
    );
  }
}
