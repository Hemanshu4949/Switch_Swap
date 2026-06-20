abstract class BaseActionHandler {
  /// Executes the given command. 
  /// Returns [true] if the execution was successful, [false] otherwise.
  Future<bool> execute(String command);
}
