import '../config/table.dart';

/// # items
/// The item table.
///
/// @author TintLwinOo
class Item extends Table {
  /// The item id
  int? id;

  /// The item title
  String? title;

  /// The item description
  String? description;

  /// ## Constructor
  /// The item constructor with all arguments
  ///
  /// [Parameters]:
  ///  - id       [int]
  ///  - title     [String]
  ///  - description      [String]
  Item(this.id, this.title, this.description) : super();

  /// ## Constructor
  /// The named constructor for car
  Item.empty();

  /// fromJson
  ///
  /// the class factory method to convert json object to class member object
  ///
  /// Parameters:
  /// - json [Map<String, dynamic>]
  ///
  /// @return [Item]
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(json['id'], json['title'], json['description']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description
    };
  }

  @override
  String getClassName() {
    return "item";
  }

  @override
  String createQuery() {
    return '''
    CREATE TABLE item (
      id INTEGER PRIMARY KEY,
      title VARCHAR(100),
      description VARCHAR(100)
    )
    ''';
  }

  @override
  String toString() {
    return '${this.toJson()}';
  }
}
