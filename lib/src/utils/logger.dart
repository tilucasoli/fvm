import 'dart:async';

import 'package:dart_console/dart_console.dart';
import 'package:fvm/src/services/context.dart';
import 'package:interact/interact.dart';
import 'package:mason_logger/mason_logger.dart';

/// Sets default logger mode
FvmLogger get logger => ctx.get<FvmLogger>();

class FvmLogger extends Logger {
  void get divider {
    info(
      '------------------------------------------------------------',
    );
  }

  void get spacer {
    info('');
  }

  bool get isVerbose => logger.level == Level.verbose;

  void complete(String message) {
    // \u2714
    // info('✅ $message');
    info('${green.wrap('\u2714')} $message');
  }

  @override
  bool confirm(String? message, {bool? defaultValue}) {
    // When running tests, always return true.
    if (ctx.isTest) return true;

    return Confirm(prompt: message ?? '', defaultValue: defaultValue)
        .interact();
  }

  void notice(String message) {
    // Add 2 due to the warning icon.

    final label = yellow.wrap('⚠ $message')!;

    final table = Table()
      ..insertRow([label])
      ..borderColor = ConsoleColor.yellow
      ..borderType = BorderType.outline
      ..borderStyle = BorderStyle.square;

    // print(yellow.wrap(border));
    // info('$pipe $warningIcon $message $pipe');
    // print(yellow.wrap(border));
    logger.info(table.toString());
  }
}

/// Logger for FVM
/// Console controller instance
final consoleController = ConsoleController();

/// Console Controller
class ConsoleController {
  /// stdout stream
  final stdout = StreamController<List<int>>();

  /// sderr stream
  final stderr = StreamController<List<int>>();

  /// warning stream
  final warning = StreamController<List<int>>();

  /// fine stream
  final fine = StreamController<List<int>>();

  /// info streamm
  final info = StreamController<List<int>>();

  /// error stream
  final error = StreamController<List<int>>();
}
