/// # Table
/// The abstract table class to provide the data interface for all entities
abstract class Table {
  /// Define the name of the table to use while creating the database table
  ///
  /// @return [String]
  String getClassName();

  /// Converting the class to JSON representation
  ///
  /// @return [Map<String, dynamic>]
  Map<String, dynamic> toJson();

  /// Create the query string for creating the database table
  ///
  /// @return [String]
  String createQuery();
}
