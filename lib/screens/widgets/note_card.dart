import 'package:flutter/material.dart';
import 'package:mysimplenote/models/note_model.dart';
import 'package:mysimplenote/screens/note_view.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.onNoteDeleted,
    required this.index,
  });

  final Note note;
  final int index;
  final Function(int) onNoteDeleted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NoteView(
              note: note,
              index: index,
              onNoteDeleted: onNoteDeleted,
            ),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title.isNotEmpty ? note.title : "Untitled",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                note.description.isNotEmpty ? note.description : "No content",
                style: const TextStyle(fontSize: 20),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
