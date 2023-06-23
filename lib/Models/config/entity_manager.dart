import 'package:sqflite/sqflite.dart';
import 'table.dart';

/// The entity manager class for analyzing the database
class EntityManager {
  late Database _database;

  /// Initializes the entity manager and the sqflite library
  EntityManager() {
    _initSqflite();
  }

  /// Initializes the sqflite library
  void _initSqflite() async {
    // ignore: deprecated_member_use
    await Sqflite.devSetDebugModeOn(true);
    _database = await openDatabase('item.db');
  }

  /// Initializes the database with the provided tables
  Future<void> initDatabase(List<Table> tables) async {
    await _checkTables(tables);
  }

  /// Checks if the tables exist in the database and creates them if necessary
  Future<void> _checkTables(List<Table> tables) async {
    final dbTables = await _tablesName();
    for (final table in tables) {
      if (!dbTables.contains(table.getClassName())) {
        await _database.execute(table.createQuery());
        // ignore: avoid_print
        print('Table with the name ${table.getClassName()} created');
      }
    }
  }

  /// Retrieves the names of all tables in the database
  Future<List<String>> _tablesName() async {
    final tables = await _database
        .query('sqlite_master', where: 'type = ?', whereArgs: ['table']);
    return tables.map((row) => row['name'] as String).toList();
  }

  /// Retrieves the current database
  Database get database => _database;
}
