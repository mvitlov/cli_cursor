import 'package:cli_cursor/cli_cursor.dart';

void main() async {
  // Hide the CLI cursor
  CliCursor.hide();

  // Some async operation
  await Future<void>.delayed(const Duration(milliseconds: 2000));

  // Show the CLI cursor
  CliCursor.show();
}
