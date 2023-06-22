class ListItem {
  int id;
  String title;
  String description;

  ListItem({required this.id, required this.title, required this.description});

  @override
  String toString() {
    return '{id: $id, title: $title, description: $description}';
  }
}
