import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_sembast/bloc/fruit_event.dart';
import 'package:flutter_fruit_sembast/bloc/fruit_state.dart';
import 'package:flutter_fruit_sembast/data/fruit.dart';
import 'package:flutter_fruit_sembast/data/fruit_dao.dart';

class FruitBloc extends Bloc<FruitEvent, FruitState>{
  FruitDao _fruitDao = FruitDao();

  FruitBloc() : super(FruitsLoading());

  @override
  Stream<FruitState> mapEventToState(FruitEvent event) async*{
    if(event is LoadFruits) {
      yield FruitsLoading();
      yield* _reloadedFruits();
    } else if(event is AddRandomFruit) {
      await _fruitDao.insert(RandomFruitGenerator.getRandomFruit());
      yield* _reloadedFruits();
    } else if(event is UpdateWithRandomFruit){
      final newFruit = RandomFruitGenerator.getRandomFruit();
      newFruit.id = event.fruitUpdate.id;
      await _fruitDao.update(newFruit);
      yield* _reloadedFruits();
    } else if(event is DeleteFruit) {
      await _fruitDao.delete(event.fruit);
      yield* _reloadedFruits();
    }
  }

  Stream<FruitState> _reloadedFruits() async*{
    final fruits =  await _fruitDao.getAllSortedByName();
    yield FruitsLoaded(fruits: fruits);
  }
}

class RandomFruitGenerator{
  static final fruits = [
    Fruit(name: 'Banana', isSweet: true),
    Fruit(name: 'Apple', isSweet: true),
    Fruit(name: 'Kiwi', isSweet: false),
    Fruit(name: 'Strawberry', isSweet: true),
    Fruit(name: 'Lemon', isSweet: false),
  ];

  static Fruit getRandomFruit() {
    return fruits[Random().nextInt(fruits.length)];
  }
}