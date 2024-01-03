import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mongo_dart/mongo_dart.dart';

import '../models/todo.dart';

class TodoService {
  final String mongoUri = 'mongodb+srv://toDoApp:mOe7VlKS2HvunTof@todo.hdebihy.mongodb.net/todosapp?retryWrites=true&w=majority'; // Replace with your MongoDB connection URI

  Future<List<Todo>> getTodos() async {
    final db = await Db.create(mongoUri);
    await db.open();

    final collection = db.collection('todos');
    final List<Map<String, dynamic>> todosData = await collection.find().toList();

    await db.close();

    return todosData.map((todo) => Todo.fromJson(todo)).toList();
  }

  Future<void> addTodo(Todo todo) async {
    final db = await Db.create(mongoUri);
    await db.open();

    final collection = db.collection('todos');
    await collection.insert(todo.toJson());

    await db.close();
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await Db.create(mongoUri);
    await db.open();

    final collection = db.collection('todos');
    await collection.replaceOne({"id" :  todo.id}, todo.toJson());

    await db.close();
  }
}
