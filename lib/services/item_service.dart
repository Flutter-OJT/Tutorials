import 'package:todocrudlist/main.dart';
import '../Models/Todo/todo_model.dart';

/// The service to perform CRUD operations on items
class ItemService {
  /// Get all items from the database
  Future<List> getAllItems() async {
    final data = await entityManager.database.query('item');
    return data.map((item) => Item.fromJson(item)).toList();
  }

  /// Get item by ID
  Future<Item?> getItemById(int id) async {
    final data = await entityManager.database
        .query('item', where: 'id = ?', whereArgs: [id]);
    if (data.isEmpty) return null;
    return Item.fromJson(data.single);
  }

  /// Create a new item
  Future<void> createItem(Item item) async {
    await entityManager.database.insert(item.getClassName(), item.toJson());
  }

  /// Update an item
  Future<void> updateItem(Item item) async {
    await entityManager.database.update(
      item.getClassName(),
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  /// Delete an item
  Future<void> deleteItem(int id) async {
    await entityManager.database
        .delete('items', where: 'id = ?', whereArgs: [id]);
  }
}
