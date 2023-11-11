import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_management_bloc/post_management_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';

class SendingPostAlert extends StatefulWidget {
  const SendingPostAlert({super.key});

  @override
  State<SendingPostAlert> createState() => _SendingPostAlertState();
}

class _SendingPostAlertState extends State<SendingPostAlert> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: BlocBuilder<PostManagementBloc, PostManagementState>(
          builder: (context, state) {
            if (state.status.status == StateStatusEnum.loading) {
              return const SizedBox(
                width: 75,
                height: 75,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            Navigator.pop(context);
            return Container();
          },
        ),
      ),
    );
  }
}
