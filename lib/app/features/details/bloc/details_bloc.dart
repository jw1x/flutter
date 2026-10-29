import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/di.dart';
import '../../../../domain/repositories/cars/cars.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc({
    required this.carRepository,
  }) : super(DetailsInitial()) {
    on<DetailsLoad>(_detailsLoad);
  }

  final CarRepositoryInterface carRepository;

  Future<void> _detailsLoad(
    DetailsLoad event,
    Emitter<DetailsState> emit,
  ) async {
    try {
      emit(DetailsLoadInProgress());

      final car = await carRepository.getCar(
        event.id,
      );

      emit(
        DetailsLoadSuccess(
          car: car,
        ),
      );
    } catch (exception, stackTrace) {
      emit(
        DetailsLoadFailure(
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