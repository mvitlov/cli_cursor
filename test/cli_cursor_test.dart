import 'package:cli_cursor/cli_cursor.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

const show = '\u001B[?25h';
const hide = '\u001B[?25l';

// Mock class for WritableStream
class MockIOSink extends Mock implements WritableStream {
  @override
  bool get hasTerminal => true;
}

void main() {
  group('CliCursor', () {
    late MockIOSink mockIOSink;

    var result = '';

    String getResult(void Function() fn) {
      result = '';
      when(() => mockIOSink.write(any())).thenAnswer((Invocation invocation) {
        result += invocation.positionalArguments[0] as String;
      });

      fn();
      return result;
    }

    setUp(() {
      mockIOSink = MockIOSink();
    });

    test('show', () {
      expect(getResult(() => CliCursor.show(mockIOSink)), show);
      verify(() => mockIOSink.write(show)).called(1);
    });

    test('hide', () {
      expect(getResult(() => CliCursor.hide(mockIOSink)), hide);
      verify(() => mockIOSink.write(hide)).called(1);
    });

    test('toggle - hide to show', () {
      CliCursor.isHidden = true;
      expect(getResult(() => CliCursor.toggle(null, mockIOSink)), show);
      verify(() => mockIOSink.write(show)).called(1);
    });

    test('toggle - show to hide', () {
      CliCursor.isHidden = false;
      expect(getResult(() => CliCursor.toggle(null, mockIOSink)), hide);
      verify(() => mockIOSink.write(hide)).called(1);
    });

    test('toggle force show', () {
      CliCursor.isHidden = false;
      expect(getResult(() => CliCursor.toggle(true, mockIOSink)), show);
      verify(() => mockIOSink.write(show)).called(1);
    });

    test('toggle force show (already hidden)', () {
      CliCursor.isHidden = true;
      expect(getResult(() => CliCursor.toggle(true, mockIOSink)), show);
      verify(() => mockIOSink.write(show)).called(1);
    });

    test('toggle force hide', () {
      CliCursor.isHidden = false;
      expect(getResult(() => CliCursor.toggle(false, mockIOSink)), hide);
      verify(() => mockIOSink.write(hide)).called(1);
    });
  });
}
