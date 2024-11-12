import 'package:flutter/material.dart';
import 'package:mysimplenote/db_helper/sql_helper.dart';
import 'package:mysimplenote/models/note_model.dart';

class NoteEdit extends StatelessWidget {
  const NoteEdit({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: note.title);
    final TextEditingController bodyController =
        TextEditingController(text: note.description);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(
                fontSize: 26,
              ),
              decoration: const InputDecoration(
                hintText: "Title",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(209, 195, 156, 255))
                )
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: bodyController,
              style: const TextStyle(
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                hintText: "Your Note",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(209, 195, 156, 255))
                )
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (titleController.text.isEmpty || bodyController.text.isEmpty) {
            return;
          }
          final updatedNote = Note(
            id: note.id,
            title: titleController.text,
            description: bodyController.text,
          );

          // Update note in the SQLite database
          await DatabaseHelper.instance.updateNote(updatedNote);

          Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
