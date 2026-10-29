import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../app/features/home/bloc/bloc.dart';
import '../data/dio/set_up.dart';
import '../domain/repositories/cars/cars.dart';

import '../app/features/details/bloc/bloc.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();
final Dio dio = Dio();

Future<void> setupLocator() async {
  setUpDio(dio, talker);

  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton(talker);

  getIt.registerSingleton<CarRepositoryInterface>(
    CarRepository(dio: dio),
  );

  getIt.registerSingleton<HomeBloc>(
    HomeBloc(
      carRepository: getIt<CarRepositoryInterface>(),
    ),
  );

  getIt.registerSingleton<DetailsBloc>(
    DetailsBloc(
      carRepository: getIt<CarRepositoryInterface>(),
    ),
  );
}