import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:untitled9/drawer_tiles/cart_tile.dart';
import 'package:untitled9/models/user_model.dart';
import 'package:untitled9/screens/login_screen.dart';
import 'package:untitled9/screens/order_screen.dart';
import 'package:untitled9/widgets/discont_card.dart';
import 'package:untitled9/widgets/ship_card.dart';

import '../models/cart_model.dart';
import '../widgets/cart_price.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(builder: (context, child, model) {
              int p = model.products.length;
              return Text(
                "$p ${p == 1 ? "ITEM": "ITENS"}",//${p ?? 0}
                style: TextStyle(fontSize: 17.0),
              );
            }),),

        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model){
          if(model.isLoading && UserModel.of(context).isLoggedIn()){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(!UserModel.of(context).isLoggedIn()){
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_shopping_cart, size: 80.0, color: Theme.of(context).primaryColor,),
                  SizedBox(height: 16.0,),
                  Text("Faça o login para adicionar produtos!",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0,),
                  ElevatedButton(
                    child: Text("Entrar", style: TextStyle(fontSize: 18.0),),
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>LoginScreen())
                      );
                    },
                  ),
                ],
              ),
            );
          }else if(model.products == null || model.products.length == 0){
            return Center(
              child: Text("Nenhum produto no carrinho!",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          }else{
            return ListView(
              children: [
                Column(
                  children: model.products.map(
                      (product){
                        return CartTile(product);
                      }
                  ).toList(),
                ),
                DiscontCard(),
                ShipCard(),
                CartPrice(() async {
                  String orderId = await model.finishOrder();
                  if(orderId != ""){
                    print(orderId);
                  }
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context)=> OrderScreen(orderId))
                  );
                }),
              ],
            );
          }
          //return Container();
        },
      ),
    );
  }
}
/*
model.products.map(
                      (product){
                        return CartTile(product);
                      }
                  )
 */