import 'dart:async';
import 'dart:io';

/// Returns a [Future] that completes when the process receives a
/// [ProcessSignal] requesting a shutdown.
///
/// [ProcessSignal.sigint] is listened to on all platforms.
///
/// [ProcessSignal.sigterm] is listened to on all platforms except Windows.
Future<void> onExit() {
  final completer = Completer<void>.sync();

  StreamSubscription<ProcessSignal>? sigIntSub, sigTermSub;

  Future<void> cancelSubscriptions() async {
    await sigIntSub?.cancel();
    await sigTermSub?.cancel();
    sigIntSub = null;
    sigTermSub = null;
  }

  Future<void> signalHandler(ProcessSignal signal) async {
    await cancelSubscriptions();
    completer.complete();
  }

  sigIntSub = ProcessSignal.sigint.watch().listen(signalHandler);

  // SIGTERM is not supported on Windows. Attempting to register a SIGTERM
  // handler raises an exception.
  if (!Platform.isWindows) {
    sigTermSub = ProcessSignal.sigterm.watch().listen(signalHandler);
  }

  return completer.future;
}
