//import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled9/datas/cart_product.dart';
import 'package:untitled9/datas/product_data.dart';
import 'package:untitled9/models/cart_model.dart';
import 'package:untitled9/models/user_model.dart';
import 'package:untitled9/screens/cart_screen.dart';
import 'package:untitled9/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData productData;

  ProductScreen(this.productData);

  @override
  State<ProductScreen> createState() => _ProductScreenState(productData);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData productData;
  String size = '';

  _ProductScreenState(this.productData);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(productData.title!),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
              options: CarouselOptions(
                //aspectRatio: 0.9,
                autoPlay: true,
              ),
              items: productData.images!.map((url) {
                return Image(image: NetworkImage(url), height: 10.0,);
                //NetworkImage(url) as Widget;
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  productData.title!,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${productData.price!.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: productData.sizes!.map((s) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            size = s;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                  color: s == size ? primaryColor : Colors.grey,
                                  width: s == size ? 3.0 : 1.0)),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(s),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                    onPressed: size != ''
                        ? () {
                            if (UserModel.of(context).isLoggedIn()) {

                              CartProduct cartProduct = CartProduct();
                              cartProduct.size = size;
                              cartProduct.quantidy = 1;
                              cartProduct.pid = productData.id;
                              cartProduct.category = productData.category;
                              cartProduct.productData = productData;

                              CartModel.of(context).addCartItem(cartProduct);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CartScreen()));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            }
                          }
                        : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn()
                          ? "Adicionar ao Carrinho"
                          : "Entre para Comprar",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Descrição: ",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  productData.description!,
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
Carousel(
              images: productData.images!.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: true,
              autoplayDuration: Duration(seconds: 3),
            )
 */
