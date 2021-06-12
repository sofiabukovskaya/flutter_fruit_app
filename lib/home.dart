import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/fruit_bloc.dart';
import 'bloc/fruit_event.dart';
import 'bloc/fruit_state.dart';
import 'data/fruit.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomePageState();

}
class _HomePageState extends State<HomePage>{
  late FruitBloc _fruitBloc;
  @override
  void initState() {
    super.initState();
    _fruitBloc = BlocProvider.of<FruitBloc>(context);
    _fruitBloc.add(LoadFruits());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit app'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _fruitBloc.add(AddRandomFruit());
        },
      ),
    );
  }
  Widget _buildBody() {
    return BlocBuilder(
      bloc: _fruitBloc,
      builder: (BuildContext context, FruitState state) {
        if (state is FruitsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FruitsLoaded) {
          return ListView.builder(
            itemCount: state.fruits.length,
            itemBuilder: (context, index) {
              final displayedFruit = state.fruits[index];
              return ListTile(
                title: Text(displayedFruit.name),
                subtitle:
                Text(displayedFruit.isSweet ? 'Very sweet!' : 'Sooo sour!'),
                trailing: _buildUpdateDeleteButtons(displayedFruit),
              );
            },
          );
        }
        return Container();
      },
    );
  }

  Row _buildUpdateDeleteButtons(Fruit displayedFruit) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            _fruitBloc.add(UpdateWithRandomFruit(fruitUpdate: displayedFruit));
          },
        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            _fruitBloc.add(DeleteFruit(fruit: displayedFruit));
          },
        ),
      ],
    );
  }
}