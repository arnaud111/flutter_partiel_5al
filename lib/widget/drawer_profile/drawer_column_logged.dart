import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_bloc/auth_bloc.dart';

class DrawerColumnLogged extends StatelessWidget {
  const DrawerColumnLogged({
    super.key,
    required this.authState,
  });

  final AuthState authState;

  void disconnect(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(Disconnect());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Color(0xFF31363B),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 96,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(authState.auth!.name!),
              ],
            ),
          ),
        ),
        const ListTile(
          title: Text("My Post"),
        ),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => disconnect(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("Disconnect"),
            ),
          ),
        ),
      ],
    );
  }
}
