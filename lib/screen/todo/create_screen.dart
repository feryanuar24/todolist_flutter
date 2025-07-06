import 'package:flutter/material.dart';
import 'package:todolist_flutter/models/todo_model.dart';
import 'package:todolist_flutter/services/db_helper.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key, required this.title});

  final String title;

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final DBHelper dbHelper = DBHelper();
  final TextEditingController title = TextEditingController();

  void addTodo() async {
    if (title.text.isNotEmpty) {
      try {
        await dbHelper.insertTodo(Todo(title: title.text));

        title.clear();

        if (!mounted) return;

        Navigator.pushReplacementNamed(context, '/todo');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("To Do added successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        if (!mounted) return;
        debugPrint("Insert Failed: $e");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to add To Do"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a title"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => addTodo(),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
