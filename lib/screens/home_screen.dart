import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mysimplenote/db_helper/sql_helper.dart';
import 'package:mysimplenote/models/note_model.dart';
import 'package:mysimplenote/screens/create_note.dart';
import 'package:mysimplenote/screens/widgets/note_card.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  final StreamController<SwipeRefreshState> _controller =  StreamController<SwipeRefreshState>.broadcast();

  @override
  void initState() {
    super.initState();
    _loadNotes(); // Load notes from database when the screen initializes
  }

  Future<void> _loadNotes() async {
    _controller.sink.add(SwipeRefreshState.loading); // Show refresh indicator
    final loadedNotes = await DatabaseHelper.instance.getNotes();
    setState(() {
      notes = loadedNotes;
    });
    _controller.sink.add(SwipeRefreshState.hidden);
    notes = await DatabaseHelper.instance.getNotes();
    if (notes.isEmpty) {
      await DatabaseHelper.instance.insertNote(Note(
        title: 'Welcome',
        description: 'Thank you for using MySimpleNote! This app is designed to save your day to day notes. Start by clicking below create button and create your first note and make the most out of your day!',
      ));
      notes = await DatabaseHelper.instance.getNotes();
    }

  }

  Future<void> _refresh() async {
    await _loadNotes();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Notes"),
      ),
      body: notes.isEmpty
          ? const Center(child: Text("No notes available"))
          :SwipeRefresh.material(
              stateStream: _controller.stream,
              onRefresh: _refresh,
              padding: const EdgeInsets.symmetric(vertical: 10),

          children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return NoteCard(
                      note: notes[index],
                      index: index,
                      onNoteDeleted: onNoteDeleted,
                );
              },
           ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add),
            ),
    );
  }

  void onNewNoteCreated(Note note) async {
    await DatabaseHelper.instance.insertNote(note);
    _loadNotes();
  }

  void onNoteDeleted(int index) async {
    final noteToDelete = notes[index];
    await DatabaseHelper.instance.deleteNote(noteToDelete.id!);
    _loadNotes();
  }

  Future<void> _addNote() async {
       final newNote = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateNote(
                onNewNoteCreated: onNewNoteCreated,
              ),
            ),
          );
          if (newNote != null) onNewNoteCreated(newNote);
}

}
