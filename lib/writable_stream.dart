import 'dart:io';

/// Interface for writable streams
abstract interface class WritableStream {
  /// Write a message to the target consumer
  void write(String message);

  /// Checks if the target consumer has terminal attached to it
  bool get hasTerminal;
}

/// Implementation of WritableStream for Stdout
class StdoutWritableStream implements WritableStream {
  final Stdout _stdout;

  StdoutWritableStream([Stdout? stdout_]) : _stdout = stdout_ ?? stderr;

  @override
  void write(String message) => _stdout.write(message);

  @override
  bool get hasTerminal => _stdout.hasTerminal;
}
