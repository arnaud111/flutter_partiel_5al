import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/widget/drawer_profile/drawer_column_disconnected.dart';
import 'package:flutter_partiel_5al/widget/drawer_profile/drawer_column_logged.dart';

import '../../bloc/user_bloc/auth_bloc.dart';

class DrawerProfile extends StatelessWidget {
  const DrawerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status.status == StateStatusEnum.success) {
            return DrawerColumnLogged(
              authState: state,
            );
          }
          if (state.status.status == StateStatusEnum.loading) {
            return const Center(
              child: SizedBox(
                width: 75,
                height: 75,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          return const DrawerColumnDisconnected();
        },
      ),
    );
  }
}
