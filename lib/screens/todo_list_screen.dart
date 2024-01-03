import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/main.dart';

import '../models/todo.dart';
import '../services/todo_service.dart';
import 'add_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late List<Todo> todos = <Todo>[];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    todos = await TodoService().getTodos();
    setState(() {});
  }

  void _toggleTodoStatus(Todo todo) async {
    todo.isDone = !todo.isDone;
    await TodoService().updateTodo(todo);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: <Widget>[
          IconButton(onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool("isLoggedIn", false);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyApp()
                )
            );
          }, icon: const Icon(Icons.logout))
        ]
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            leading: Checkbox(
              value: todos[index].isDone,
              onChanged: (_) => _toggleTodoStatus(todos[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          ).then((value) => _loadTodos());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}