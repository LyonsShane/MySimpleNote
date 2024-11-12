class Note {
  final int? id;
  final String title;
  final String description;

  Note({
    this.id,
    required this.title,
    required this.description,
  });

  // Convert Note instance to a map for SQLite insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description
    };
  }

  // Create a Note from a Map (for reading from the database)
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}
