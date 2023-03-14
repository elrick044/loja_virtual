import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:untitled9/models/user_model.dart';
import 'package:untitled9/screens/signup_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //LoginScreen({Key? key}) : super(key: key);

  final _emailControler = TextEditingController();
  final _passControler = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=> SignUpScreen())
              );
            },
            child: const Text(
              "CRIAR CONTA",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),

          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  controller: _emailControler,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text){
                    if(text!.isEmpty || !(text.contains("@"))){
                      return "Email inválido!";
                    }
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passControler,
                  decoration: InputDecoration(
                    hintText: "Senha",
                  ),
                  obscureText: true,
                  validator: (text){
                    if(text!.isEmpty || text.length < 6) return "Senha inválida!";
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: TextButton(
                      onPressed: (){
                        if(_emailControler.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Insira seu email!"),
                                backgroundColor: Colors.redAccent,
                                duration: Duration(seconds: 2),
                              )
                          );
                        }else{
                          model.recoveryPass(_emailControler.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Verifique seu email"),
                                backgroundColor: Theme.of(context).primaryColor,
                                duration: Duration(seconds: 2),
                              )
                          );
                        }
                      },
                      child: Text("Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0,),
                ElevatedButton(
                  style: ButtonStyle(
                    //backgroundColor:,

                  ),
                  onPressed: (){
                    if(_formKey.currentState!.validate()){

                    }

                    model.signIn(
                        email: _emailControler.text,
                        pass: _passControler.text,
                        onSucess: _onSucess,
                        onFail: _onFail
                    );
                  },
                  child: Text(
                    "Entrar",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),

                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSucess(){
    Navigator.of(context).pop();
  }

  void _onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao entrar!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }
}

