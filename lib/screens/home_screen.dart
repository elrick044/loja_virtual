import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled9/tabs/category_tab.dart';
import 'package:untitled9/tabs/home_tab.dart';
import 'package:untitled9/widgets/cart_button.dart';
import 'package:untitled9/widgets/custom_drawer.dart';

import '../tabs/orders_tab.dart';
import '../tabs/places_tab.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  //const HomeScreen({Key? key, _pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(pageController:  _pageController,),
            floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Categorias"),
            centerTitle: true,

          ),
          drawer: CustomDrawer(pageController: _pageController,),
          body: CategoryTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(pageController: _pageController,),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(pageController: _pageController,),
        )
      ],
    );
  }
}
