## cli_cursor
> Easily toggle the cursor inside command-line apps


## Usage

```dart
import 'package:cli_cursor/cli_cursor.dart';

Future<void> main() async {
  // Hide the CLI cursor
  CliCursor.hide();

  // Some async operation
  await Future.delayed(Duration(milliseconds: 2000));

  // Show the CLI cursor
  CliCursor.show();
}
```

## Credits
[cli_cursor](https://github.com/sindresorhus/cli-cursor) by Sindre Sorhus
