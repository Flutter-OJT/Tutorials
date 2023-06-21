class Items {
  late int id; // Changed the type to int
  late String title;
  late String description;

  Items({
    required int id, // Updated the parameter type to int
    required String title,
    required String description,
  }) {
    // ignore: prefer_initializing_formals
    this.id = id;
    // ignore: prefer_initializing_formals
    this.title = title;
    // ignore: prefer_initializing_formals
    this.description = description;
  }
}
