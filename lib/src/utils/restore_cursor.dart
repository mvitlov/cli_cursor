import '../writable_stream/writable_stream.dart';
import 'on_exit.dart';

Future<void> restoreCursor(WritableStream terminal) async {
  await onExit().then((_) {
    terminal.write('\u001B[?25h');
  });
}
