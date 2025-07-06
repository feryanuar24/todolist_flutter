import 'package:flutter/material.dart';
import 'package:todolist_flutter/models/todo_model.dart';
import 'package:todolist_flutter/services/db_helper.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.title});

  final String title;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final DBHelper dbHelper = DBHelper();
  late Todo todo;
  late TextEditingController title = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    todo = ModalRoute.of(context)!.settings.arguments as Todo;

    title = TextEditingController(text: todo.title);
  }

  void editTodo() async {
    if (title.text.isNotEmpty) {
      try {
        await dbHelper.updateTodo(Todo(id: todo.id, title: title.text));

        title.clear();

        if (!mounted) return;

        Navigator.pushReplacementNamed(context, '/todo');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("To Do updated successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        if (!mounted) return;
        debugPrint("Insert Failed: $e");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to update To Do"),
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
              onPressed: () => editTodo(),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
