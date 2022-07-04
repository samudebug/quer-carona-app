import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quer_carona/blocs/auth/auth_bloc.dart';
import 'package:quer_carona/cubits/login/login_cubit.dart';
import 'package:quer_carona/ui/main_page.dart';
import 'package:quer_carona/ui/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return BlocProvider(
                create: (context) => LoginCubit(),
                child: SingleChildScrollView(
                  child: BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, cubitState) {
                      return Form(
                          child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 32),
                            child: Text(
                              "Fazer Login",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: context.read<LoginCubit>().updateEmail,
                              decoration: const InputDecoration(
                                  label: Text("Email"),
                                  hintText: "example@email.com"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged:
                                  context.read<LoginCubit>().updatePassword,
                              obscureText: true,
                              decoration: const InputDecoration(
                                label: Text("Senha"),
                                hintText: "Sua senha",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Esqueceu sua senha?",
                                  textAlign: TextAlign.start,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(AuthUserLogIn(
                                    email: cubitState.email,
                                    password: cubitState.password));
                              },
                              child: const Text("Entrar"),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Expanded(
                                    child: Divider(
                                  height: 10,
                                  color: Colors.yellow,
                                )),
                                Text("OU"),
                                Expanded(
                                    child: Divider(
                                  height: 10,
                                  color: Colors.yellow,
                                ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const SignupPage()));
                              },
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text(
                                      "Criar nova conta",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ]),
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      width: 1, color: Colors.grey)),
                            ),
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                      ));
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
