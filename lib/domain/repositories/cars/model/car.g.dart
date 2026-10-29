// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) => Car(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  imagePath: json['imagePath'] as String,
  body: json['body'] as String?,
  engine: json['engine'] as String?,
  drive: json['drive'] as String?,
);

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'imagePath': instance.imagePath,
  'body': instance.body,
  'engine': instance.engine,
  'drive': instance.drive,
};
