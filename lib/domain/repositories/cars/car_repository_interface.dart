import 'model/car.dart';

abstract interface class CarRepositoryInterface {
  Future<List<Car>> getCars();
  Future<Car> getCar(String id);
}