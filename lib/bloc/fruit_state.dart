import 'package:flutter_fruit_sembast/data/fruit.dart';

class FruitState{}

class FruitsLoading extends FruitState{}
class FruitsLoaded extends FruitState{
  final List<Fruit> fruits;

  FruitsLoaded({required this.fruits});
}