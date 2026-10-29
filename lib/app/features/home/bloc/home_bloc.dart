import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/di.dart';
import '../../../../domain/repositories/cars/cars.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.carRepository,
  }) : super(HomeInitial()) {
    on<HomeLoad>(_homeLoad);
  }

  final CarRepositoryInterface carRepository;

  Future<void> _homeLoad(
    HomeLoad event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoadInProgress());

      final cars = await carRepository.getCars();

      emit(
        HomeLoadSuccess(
          cars: cars,
        ),
      );
    } catch (exception, stackTrace) {
      emit(
        HomeLoadFailure(
          exception: exception,
        ),
      );

      talker.handle(
        exception,
        stackTrace,
      );
    }
  }

  @override
  void onError(
    Object error,
    StackTrace stackTrace,
  ) {
    super.onError(error, stackTrace);

    talker.handle(
      error,
      stackTrace,
    );
  }
}