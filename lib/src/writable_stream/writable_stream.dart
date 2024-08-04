import 'dart:io';

/// Interface for writable streams
abstract interface class WritableStream {
  /// Write a message to the target consumer
  void write(String message);

  /// Checks if the target consumer has terminal attached to it
  bool get hasTerminal;
}
