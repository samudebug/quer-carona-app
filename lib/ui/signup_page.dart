import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quer_carona/blocs/auth/auth_bloc.dart';
import 'package:quer_carona/cubits/signup/signup_cubit.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return BlocProvider(
              create: (context) => SignupCubit(),
              child: SingleChildScrollView(
                child: BlocBuilder<SignupCubit, SignupState>(
                  builder: (context, cubitState) {
                    return Form(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back),
                              iconSize: 24,
                            ),
                            const FittedBox(
                              child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Text(
                                  "Crie sua conta gratuita",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                              decoration: const InputDecoration(
                                  label: Text("Nome"),
                                  hintText: "Ex: João da Silva")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                              onChanged:
                                  context.read<SignupCubit>().updateEmail,
                              decoration: const InputDecoration(
                                  label: Text("Email"),
                                  hintText: "example@email.com")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                              onChanged:
                                  context.read<SignupCubit>().updatePassword,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  label: Text("Senha"), hintText: "Senha")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(AuthUserSignUp(
                                  email: cubitState.email,
                                  password: cubitState.password));
                              ;
                            },
                            child: const Text("Criar Conta"),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              const Text("Já tem uma conta?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Entrar"))
                            ],
                          ),
                        ),
                      ],
                    ));
                  },
                ),
              ),
            );
          },
        ),
      )),
    );
  }
}
