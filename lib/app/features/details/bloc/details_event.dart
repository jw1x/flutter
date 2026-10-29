part of 'details_bloc.dart';

sealed class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object?> get props => [];
}

final class DetailsLoad extends DetailsEvent {
  const DetailsLoad({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [id];
}