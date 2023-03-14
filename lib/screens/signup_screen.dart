import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:untitled9/models/user_model.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //SignUpScreen({Key? key}) : super(key: key);

  final _nameControler = TextEditingController();
  final _emailControler = TextEditingController();
  final _passControler = TextEditingController();
  final _adressControler = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
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
                    controller: _nameControler,
                    decoration: InputDecoration(
                      hintText: "Nome Completo",
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Nome inválido!";
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailControler,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text!.isEmpty || !(text.contains("@"))) {
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
                    validator: (text) {
                      if (text!.isEmpty || text.length < 6) return "Senha inválida!";
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _adressControler,
                    decoration: InputDecoration(
                      hintText: "Endereço",
                    ),
                    validator: (text) {
                      if (text!.isEmpty) return "Endereço inválido!";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      //backgroundColor:,

                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {

                        Map<String, dynamic> userData = {
                          "name": _nameControler.text,
                          "email": _emailControler.text,
                          "adress": _adressControler.text
                        };

                        model.signUp(
                            userData: userData,
                            pass: _passControler.text,
                            onSucess: _onSucess,
                            onFail: _onFail
                        );
                      }
                    },
                    child: Text(
                      "Criar Conta",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          },
        )
    );
  }

  void _onSucess(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Usuário criado com sucesso"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      )
    );

    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao criar usuário"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }
}

