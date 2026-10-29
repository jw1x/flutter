part of 'details_bloc.dart';

sealed class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object?> get props => [];
}

final class DetailsInitial extends DetailsState {}

final class DetailsLoadInProgress extends DetailsState {}

final class DetailsLoadSuccess extends DetailsState {
  const DetailsLoadSuccess({
    required this.car,
  });

  final Car car;

  @override
  List<Object?> get props => [car];
}

final class DetailsLoadFailure extends DetailsState {
  const DetailsLoadFailure({
    required this.exception,
  });

  final Object exception;

  @override
  List<Object?> get props => [exception];
}