import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

import 'di/di.dart';
import 'flutter_application_1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      enabled: true,
      printCreations: true,
      printEvents: true,
      printTransitions: true,
      printChanges: true,
      printClosings: true,
      printEventFullData: true,
      printStateFullData: true,
    ),
  );

  await setupLocator();

  FlutterError.onError = (details) {
    talker.handle(
      details.exception,
      details.stack,
    );
  };

  runApp(const FlutterApplication1());
}