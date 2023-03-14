import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  //const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBack() => Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 181, 168)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );

    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return Stack(
            children: [
              _buildBodyBack(),
              CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    flexibleSpace:  FlexibleSpaceBar(
                      title: Text("Novidades"),
                      centerTitle: true,
                    ),
                  ),
                  FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance.collection("home").orderBy("pos").get(),
                    builder: (context, snapshot){
                      if(!snapshot.hasData){
                        return SliverToBoxAdapter(
                          child: Container(
                            height: 200.0,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        );
                      }else{
                        print(snapshot.data?.docs.length);
                        return SliverStaggeredGrid.count(//para futuras mudanças no projeto substituir por um algoritmo mais eficiente
                            crossAxisCount: 2,
                            mainAxisSpacing: 1.0,
                            crossAxisSpacing: 1.0,
                            staggeredTiles: snapshot.data!.docs.map((doc){
                              int a = doc["x"] as int;
                              double? b = double.parse(doc["y"]);
                            return StaggeredTile.count(a, b);
                          }).toList(),
                          children: snapshot.data!.docs.map(
                                (doc){
                                  return FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: doc["image"],
                                  fit: BoxFit.cover,
                                  );
                                }
                            ).toList(),

                        );
                      }
                    },
                  )
                ],
              )

            ],
          );
        }

        return Container();
      },
    );
  }
}


