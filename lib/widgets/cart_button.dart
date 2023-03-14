import 'package:flutter/material.dart';
import 'package:untitled9/screens/cart_screen.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white,),
      onPressed: (){
        Navigator.push(context, 
          MaterialPageRoute(builder: (context)=>CartScreen())
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
