import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable()
class Car {
  final String id;
  final String title;
  final String description;
  final String imagePath;

  final String? body;
  final String? engine;
  final String? drive;

  const Car({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    this.body,
    this.engine,
    this.drive,
  });

  factory Car.fromJson(Map<String, dynamic> json) =>
      _$CarFromJson(json);

  Map<String, dynamic> toJson() => _$CarToJson(this);
}