import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:untitled9/drawer_tiles/drawer_tile.dart';
import 'package:untitled9/models/user_model.dart';
import 'package:untitled9/screens/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  final PageController? pageController;

  const CustomDrawer({Key? key, this.pageController}) : super(key: key);


  Widget _buildDrawerBack  () => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 203, 236, 241),
          Colors.white
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height:170.0,
                child: Stack(
                  children: [
                    Positioned(
                        top: 8.0,
                        left: 0.0,
                        child: Text("Loja \nvirtual",
                          style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),

                ),
              ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          print(model.isLoggedIn());
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn() ?
                                  "Entre ou cadastre-se >"
                                  : "Sair",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: (){
                                  if(!model.isLoggedIn()){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
                                  }else{
                                    model.signOut();
                                  }
                                },
                              )

                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(icon: Icons.home, text: "Início", controller: pageController, page: 0,),
              DrawerTile(icon: Icons.list, text: "Produtos", controller: pageController, page: 1,),
              DrawerTile(icon: Icons.location_on, text: "Loja", controller: pageController, page: 2,),
              DrawerTile(icon: Icons.playlist_add_check, text: "Meus pedidos", controller: pageController, page: 3,),
            ],

          )
        ],
      ),
    );
  }
}
