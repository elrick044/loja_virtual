import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:untitled9/models/cart_model.dart';
import 'package:untitled9/models/user_model.dart';
import 'package:untitled9/screens/home_screen.dart';
import 'firebase_options.dart';
import 'color_schemes.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
        return ScopedModel<CartModel>(
          model: CartModel(model),
          child: MaterialApp(
            title: 'Lojinha',
              theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
              //darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          ),
        );
      }),
    );
  }
}
