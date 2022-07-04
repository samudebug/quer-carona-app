import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quer_carona/blocs/auth/auth_bloc.dart';
import 'package:quer_carona/ui/give_ride.dart';
import 'package:quer_carona/ui/see_rides.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quer Carona?",
                          style: TextStyle(fontSize: 30),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(AuthUserLogOut());
                          },
                          child: CircleAvatar(child: Icon(Icons.person)),
                        )
                      ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "O que você deseja fazer?",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const GiveRidePage()));
                          },
                          child: const Text(
                            "Dar Carona",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1, color: Colors.grey)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SeeRides()));
                          },
                          child: const Text("Pegar Carona",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1, color: Colors.grey)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
