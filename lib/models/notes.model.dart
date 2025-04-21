class Notes {
  final String id, title, content;

  Notes({required this.id, required this.title, required this.content});

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }
}
