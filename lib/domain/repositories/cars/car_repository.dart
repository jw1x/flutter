import 'package:dio/dio.dart';

import '../../../data/endpoints.dart';
import 'car_repository_interface.dart';
import 'model/car.dart';

class CarRepository implements CarRepositoryInterface {
  CarRepository({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<List<Car>> getCars() async {
    try {
      final carsToSend = [
        const Car(
          id: 'granta',
          title: 'Lada Granta',
          description:
              'Компактный и доступный автомобиль для повседневных поездок.',
          imagePath: 'assets/images/granta.jpg',
        ),
        const Car(
          id: 'vesta',
          title: 'Lada Vesta',
          description:
              'Современный седан с просторным салоном и комфортной подвеской.',
          imagePath: 'assets/images/vesta.jpg',
        ),
        const Car(
          id: 'niva',
          title: 'Lada Niva',
          description:
              'Полноприводный автомобиль для города и поездок по бездорожью.',
          imagePath: 'assets/images/niva.jpg',
        ),
      ];

      final response = await dio.post(
        Endpoints.cars,
        data: {
          'cars': carsToSend.map((car) => car.toJson()).toList(),
        },
      );

      final jsonCars =
          response.data['json']['cars'] as List<dynamic>;

      return jsonCars
          .map(
            (json) => Car.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.message ?? 'Ошибка загрузки автомобилей',
      );
    }
  }

  @override
  Future<Car> getCar(String id) async {
    try {
      final car = _getCarById(id);

      final response = await dio.post(
        Endpoints.cars,
        data: {
          'car': car.toJson(),
        },
      );

      final jsonCar =
          response.data['json']['car'] as Map<String, dynamic>;

      return Car.fromJson(jsonCar);
    } on DioException catch (e) {
      throw Exception(
        e.message ?? 'Ошибка загрузки автомобиля',
      );
    }
  }

  Car _getCarById(String id) {
    switch (id) {
      case 'granta':
        return const Car(
          id: 'granta',
          title: 'Lada Granta',
          description:
              'Lada Granta — компактный и доступный автомобиль, предназначенный для повседневной эксплуатации. Модель отличается простой конструкцией, практичностью и невысокой стоимостью обслуживания.',
          imagePath: 'assets/images/granta.jpg',
          body: 'Седан',
          engine: '1.6 л',
          drive: 'Передний',
        );

      case 'vesta':
        return const Car(
          id: 'vesta',
          title: 'Lada Vesta',
          description:
              'Lada Vesta — современный автомобиль с просторным салоном, комфортной подвеской и хорошей управляемостью. Подходит как для города, так и для дальних поездок.',
          imagePath: 'assets/images/vesta.jpg',
          body: 'Седан',
          engine: '1.6 л',
          drive: 'Передний',
        );

      case 'niva':
        return const Car(
          id: 'niva',
          title: 'Lada Niva',
          description:
              'Lada Niva — компактный полноприводный внедорожник. Автомобиль рассчитан на эксплуатацию как в городе, так и на сложных дорожных покрытиях.',
          imagePath: 'assets/images/niva.jpg',
          body: 'Внедорожник',
          engine: '1.7 л',
          drive: 'Полный',
        );

      default:
        throw Exception(
          'Автомобиль с идентификатором $id не найден',
        );
    }
  }
}