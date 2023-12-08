import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_list_bloc/post_list_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/front/post/post_item.dart';
import 'package:flutter_partiel_5al/front/widget/error_refresh.dart';
import 'package:flutter_partiel_5al/front/widget/loading.dart';

class ListPost extends StatelessWidget {
  const ListPost({
    super.key,
    required this.refreshListFunction,
  });

  final Function? refreshListFunction;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostListBloc, PostListState>(
      builder: (context, state) {
        switch (state.status.status) {
          case StateStatusEnum.initial:
            return Container();
          case StateStatusEnum.loading:
            return const Loading();
          case StateStatusEnum.success:
            return RefreshIndicator(
              onRefresh: () async {
                final postListBloc = BlocProvider.of<PostListBloc>(context);
                postListBloc.add(GetListPost());
              },
              child: ListView.builder(
                itemCount: state.postList?.itemsTotal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PostItem(
                      post: state.postList!.items![index],
                      refreshFunction: refreshListFunction,
                    ),
                  );
                },
              ),
            );
          case StateStatusEnum.error:
            return ErrorRefresh(
              onRefresh: () async {
                if (refreshListFunction != null) {
                  refreshListFunction!();
                }
              },
              errorMessage: state.status.message!,
            );
        }
      },
    );
  }
}
