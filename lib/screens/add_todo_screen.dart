import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/todo_service.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _titleController = TextEditingController();

  void _addTodo() async {
    String title = _titleController.text.trim();

    if (title.isNotEmpty) {
      Todo todo = Todo(id: 0, title: title, isDone: false, userId: 'test');
      await TodoService().addTodo(todo);
      Navigator.pop(context); // Go back to the todo list screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Todo Title'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addTodo,
              child: Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
