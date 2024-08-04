import 'dart:io';

import './writable_stream.dart';

/// Implementation of WritableStream for Stdout
class StdoutWritableStream implements WritableStream {
  StdoutWritableStream();

  final Stdout _stdout = stdout;

  @override
  void write(String message) => _stdout.write(message);

  @override
  bool get hasTerminal => _stdout.hasTerminal;
}
