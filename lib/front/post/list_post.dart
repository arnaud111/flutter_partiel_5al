import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_list_bloc/post_list_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/front/post/post_item.dart';
import 'package:flutter_partiel_5al/front/widget/error_refresh.dart';
import 'package:flutter_partiel_5al/front/widget/loading.dart';

class ListPost extends StatefulWidget {
  const ListPost({
    super.key,
    required this.refreshListFunction,
  });

  final Function? refreshListFunction;

  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final postListBloc = BlocProvider.of<PostListBloc>(context);

    if (_scrollController.position.extentAfter < 500 &&
        postListBloc.state.status.status != StateStatusEnum.loading &&
        postListBloc.state.status.status != StateStatusEnum.loadingNewItems) {
      postListBloc.add(AddListPost());
    }
  }

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
                controller: _scrollController,
                itemCount: state.postList!.itemsReceived,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PostItem(
                      post: state.postList!.items![index],
                      refreshFunction: widget.refreshListFunction,
                    ),
                  );
                },
              ),
            );
          case StateStatusEnum.loadingNewItems:
            return RefreshIndicator(
              onRefresh: () async {
                final postListBloc = BlocProvider.of<PostListBloc>(context);
                postListBloc.add(GetListPost());
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.postList!.itemsReceived! + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == state.postList!.itemsReceived!) {
                    return const Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PostItem(
                      post: state.postList!.items![index],
                      refreshFunction: widget.refreshListFunction,
                    ),
                  );
                },
              ),
            );
          case StateStatusEnum.error:
            return ErrorRefresh(
              onRefresh: () async {
                if (widget.refreshListFunction != null) {
                  widget.refreshListFunction!();
                }
              },
              errorMessage: state.status.message!,
            );
        }
      },
    );
  }
}
