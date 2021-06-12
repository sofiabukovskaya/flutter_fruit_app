import 'package:flutter_fruit_sembast/data/fruit.dart';

class FruitEvent {}

class LoadFruits extends FruitEvent{}
class AddRandomFruit extends FruitEvent{}
class UpdateWithRandomFruit extends FruitEvent{
  final Fruit fruitUpdate;

  UpdateWithRandomFruit({required this.fruitUpdate});
}

class DeleteFruit extends FruitEvent{
  final Fruit fruit;

  DeleteFruit({required this.fruit});
}