
import 'package:flutter/material.dart';
import 'package:inventmarket_app/src/bloc/login_bloc.dart';
import 'package:inventmarket_app/src/models/usuario_model.dart';
import 'package:inventmarket_app/src/pages/home_page.dart';
import 'package:inventmarket_app/src/pages/sing_up_page.dart';
//import 'package:inventmarket_app/src/providers/main_provider.dart';
import 'package:inventmarket_app/src/services/usuario_service.dart';
//import 'dart:developer' as developer;

//import 'package:provider/provider.dart';

late String token;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc bloc;
  UsuarioService usuarioService = UsuarioService();
  bool _obscureText = true;

  @override
  void initState() {
    bloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 400,
              width: 1000,
              color: Colors.transparent,
              child: const Center(
                child: Image(
                  height: 200,
                  image: NetworkImage('https://ugwfupuxmdlxyyjeuzfl.supabase.in/storage/v1/object/public/imagenes/Logo/Logo.jpg'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 350, 50, 0),
              child: Container(
                height: 400,
                width: 1000,
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                   Container(
                      margin: const EdgeInsets.only(left: 0, top: 0,right: 0,bottom:20),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(194,194,194, 30),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: StreamBuilder(
                          stream: bloc.emailStream,
                          builder: (BuildContext context,AsyncSnapshot snapshot) =>
                            TextField(
                              onChanged: bloc.changeEmail,
                              decoration: InputDecoration(
                                errorText: snapshot.error?.toString(),
                                border: InputBorder.none,
                                icon: const Icon(Icons.email_outlined, color: Colors.white,),
                                hintText: "Correo electrónico",
                              ),
                            )
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 0, top: 0,right: 0,bottom: 30),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(194,194,194, 30),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: StreamBuilder<Object>(
                          stream: bloc.passwordStream,
                          builder: (BuildContext context,AsyncSnapshot snapshot) => 
                            TextField(
                              onChanged: bloc.changePassword,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                errorText: snapshot.error?.toString(),
                                border: InputBorder.none,
                                icon: const Icon(Icons.lock, color: Colors.white,),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _obscureText = !_obscureText;
                                    setState(() {});
                                  },
                                  icon: _obscureText
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility)
                                ),
                                hintText: "Contraseña",
                              ),
                            )
                        ),
                      ),
                    ),
                    StreamBuilder<Object>(
                      stream: bloc.loginValidStream,
                      builder: (BuildContext context,AsyncSnapshot snapshot) =>
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(82,255,82, 30),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
                          ),
                          onPressed: snapshot.hasData ? () async {
                            Usuario usuario = Usuario(
                              email: bloc.email,
                              password: bloc.password
                            );
                            String resp = await usuarioService.login(usuario);
                            //mainProvider.token = resp;
                            /*if(resp.containsKey("idToken")){
                              developer.log(resp["idToken"]);
                              mainProvider.token = resp['idToken'];
                            }*/
                            //int resp = await usuarioService.login(usuario);
                            if(resp != ""){
                              token = resp;
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                            }
                          }
                          : null,
                          child: const Text("Iniciar Sesión", style: TextStyle(fontSize: 20)),
                        )
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(150,150,150, 30),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SingUpPage()));
                      }, 
                      child: const Text("Crear Cuenta", style: TextStyle(fontSize: 20)),
                    ),
                    Container(
                      color: Colors.transparent,
                      height: 40,
                      child: Row(
                        children: const <Widget>[
                          Text("¿Olvidaste tu contraseña? ", style: TextStyle(color: Colors.grey)),
                          Text.rich(
                            TextSpan(
                              text: " Entra aqui",
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15),
                              //recognizer:,
                            )
                          ),
                          //Text(" Entra aqui", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15))
                        ],
                      ),
                    )
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}