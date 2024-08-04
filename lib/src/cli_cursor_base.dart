import 'utils/restore_cursor.dart';
import 'writable_stream/stdout_writable_stream.dart';
import 'writable_stream/writable_stream.dart';

/// A small utility class to make it easier to hide/show CLI cursor
class CliCursor {
  /// Control flag
  static bool isHidden = false;

  ///	Show cursor
  ///
  /// [writableStream] - Defaults to [StdoutWritableStream].
  static void show([WritableStream? writableStream]) {
    writableStream ??= StdoutWritableStream();

    if (!writableStream.hasTerminal) return;

    isHidden = false;
    writableStream.write('\u001B[?25h');
  }

  ///	Hide cursor
  ///
  /// [writableStream] - Defaults to [StdoutWritableStream].
  static void hide([WritableStream? writableStream]) {
    writableStream ??= StdoutWritableStream();

    if (!writableStream.hasTerminal) return;
    restoreCursor(writableStream);

    isHidden = true;
    writableStream.write('\u001B[?25l');
  }

  ///	Toggle cursor visibility.
  ///
  /// [force] - Is useful to show or hide the cursor based on a boolean.
  ///
  /// [writableStream] - Defaults to `stderr`.
  static void toggle([bool? force, WritableStream? writableStream]) {
    if (force != null) isHidden = force;

    return isHidden ? show(writableStream) : hide(writableStream);
  }
}
