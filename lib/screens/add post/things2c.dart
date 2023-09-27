import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class Todo {
  final String title;
  bool isDone;

  Todo({
    required this.title,
    this.isDone = false,
  });
}


class Things2Carry extends StatefulWidget {
  @override
  _Things2CarryState createState() => _Things2CarryState();
}

class _Things2CarryState extends State<Things2Carry> {
  List<Todo> todos = [];
  TextEditingController controller = TextEditingController();

  void addTodo() {
    final title = controller.text;
    if (title.isNotEmpty) {
      setState(() {
        todos.add(Todo(
          title: title,
        ));
        controller.clear();
      });
    }
  }

  void toggleTodo(int index) {
    setState(() {
      todos[index].isDone = !todos[index].isDone;
    });
  }

  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Things To Carry',style: GoogleFonts.montserrat()),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'List things',
              ),
              onSubmitted: (_) => addTodo(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  onTap: () => toggleTodo(index),
                  onLongPress: () => removeTodo(index),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: todo.isDone,
                    onChanged: (_) => toggleTodo(index),
                    activeColor: Colors.green.shade100,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
