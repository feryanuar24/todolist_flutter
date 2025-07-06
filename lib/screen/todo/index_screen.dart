import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:todolist_flutter/models/todo_model.dart';
import 'package:todolist_flutter/services/db_helper.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key, required this.title});

  final String title;

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final DBHelper dbHelper = DBHelper();

  List<Todo> todos = [];
  List<Todo> completedTodos = [];

  @override
  void initState() {
    super.initState();
    refreshTodos();
    getFCMToken();
  }

  void getFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint("FCM Token: $token");
  }

  void refreshTodos() async {
    try {
      todos = await dbHelper.getTodos();
      completedTodos = await dbHelper.getCompletedTodos();
      setState(() {});
    } catch (e) {
      if (!mounted) return;

      debugPrint("Fetch Failed: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to fetch tasks"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void toggleTodoCompletion(Todo todo, bool? value) async {
    try {
      todo.isDone = value!;
      await dbHelper.toggleTodoStatus(todo.id!, todo.isDone);
      refreshTodos();
    } catch (e) {
      if (!mounted) return;

      debugPrint("Update Failed: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to update task"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showTodoOptions(Todo todo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('To Do Options'),
          content: Text('What would you like to do with "${todo.title}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/todo/edit', arguments: todo);
              },
              child: Text('Edit'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                deleteTodo(todo);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void deleteTodo(Todo todo) async {
    try {
      await dbHelper.deleteTodo(todo.id!);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Task deleted successfully"),
          backgroundColor: Colors.green,
        ),
      );

      refreshTodos();
    } catch (e) {
      if (!mounted) return;

      debugPrint("Delete Failed: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete task"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("You have been logged out."),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "List to be completed",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: todos.isEmpty
                  ? const Center(child: Text("No data available."))
                  : ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: todo.isDone,
                              onChanged: (value) =>
                                  toggleTodoCompletion(todo, value),
                            ),
                            title: Text(todo.title),
                            onLongPress: () => showTodoOptions(todo),
                          ),
                        );
                      },
                    ),
            ),
            const Text(
              "Completed List",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: completedTodos.isEmpty
                  ? const Center(child: Text("No data available."))
                  : ListView.builder(
                      itemCount: completedTodos.length,
                      itemBuilder: (context, index) {
                        final todo = completedTodos[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: todo.isDone,
                              onChanged: (value) =>
                                  toggleTodoCompletion(todo, value),
                            ),
                            title: Text(
                              todo.title,
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            onLongPress: () => showTodoOptions(todo),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/todo/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
