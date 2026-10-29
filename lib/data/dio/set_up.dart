import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void setUpDio(Dio dio, Talker talker) {
  dio.options.baseUrl = 'https://httpbin.org';

  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 10);

  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
        printResponseData: true,
      ),
    ),
  );
}