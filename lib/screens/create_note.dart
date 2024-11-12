import 'package:flutter/material.dart';
import 'package:mysimplenote/models/note_model.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key, required this.onNewNoteCreated});

  final Function(Note) onNewNoteCreated;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  //Future<void> _saveNote() async {
   // if (titleController.text.isEmpty || bodyController.text.isEmpty) {
    //  return;
   // }
   // final note = Note(
  //    description: bodyController.text,
  //    title: titleController.text,
  //  );
  //  await DatabaseHelper.instance.insertNote(note);
  //  widget.onNewNoteCreated(note);
 //   Navigator.of(context).pop();
//  }

void _saveNote(){
    if (titleController.text.isEmpty || bodyController.text.isEmpty) {
      return;
    }
    final note = Note(
      description: bodyController.text,
      title: titleController.text,
    );
   Navigator.of(context).pop(note);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(fontSize: 28),
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Title"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: bodyController,
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Description"),
                  maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveNote,
        child: const Icon(Icons.save),
      ),
    );
  }
}
