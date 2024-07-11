/// This library contains functionality to help toggle CLI cursor easily
library;

import 'dart:io';

/// A small utility class to make it easier to hide/show CLI cursor
class CliCursor {
  /// Control flag
  static bool isHidden = false;

  ///	Show cursor
  ///
  /// [writableStream] - Defaults to `stderr`.
  static void show([IOSink? writableStream]) {
    writableStream ??= stderr;
    if (writableStream is! Stdout || !writableStream.hasTerminal) {
      return;
    }

    isHidden = false;
    writableStream.write('\u001B[?25h');
  }

  ///	Hide cursor
  ///
  /// [writableStream] - Defaults to `stderr`.
  static void hide([IOSink? writableStream]) {
    writableStream ??= stderr;
    if (writableStream is! Stdout || !writableStream.hasTerminal) {
      return;
    }

    isHidden = true;
    writableStream.write('\u001B[?25l');
  }

  ///	Toggle cursor visibility.
  ///
  /// [force] - Is useful to show or hide the cursor based on a boolean.
  ///
  /// [writableStream] - Defaults to `stderr`.
  static void toggle([bool? force, Stdout? writableStream]) {
    if (force != null) {
      isHidden = force;
    }

    if (isHidden) {
      show(writableStream);
    } else {
      hide(writableStream);
    }
  }
}
