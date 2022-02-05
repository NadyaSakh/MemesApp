import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/memes/memes.dart';
import 'package:myapp/memes/widgets/bottom_loader.dart';
import 'package:myapp/memes/widgets/refresh_button.dart';

class MemeList extends StatefulWidget {
  const MemeList({Key? key}) : super(key: key);

  @override
  _MemesState createState() => _MemesState();
}

class _MemesState extends State<MemeList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  Widget _buildRow(Meme meme) {
    return MemeListItem(
      postLink: meme.postLink,
      ups: meme.ups,
      thumbnail: meme.url,
      title: meme.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemesBloc, MemesState>(
      builder: (context, state) {
        switch (state.status) {
          case MemesStatus.failure:
            return Stack(
              children: const [
                Center(
                    child: Text('Failed to fetch memes. Please, try again.')),
                RefreshButton(),
              ],
            );
          case MemesStatus.success:
            if (state.memes.isEmpty) {
              return const Center(child: Text('No memes.'));
            }
            return Stack(
              children: [
                ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.memes.length
                        ? const BottomLoader()
                        : _buildRow(state.memes[index]);
                  },
                  itemCount: state.hasReachedMax
                      ? state.memes.length
                      : state.memes.length + 1,
                  controller: _scrollController,
                ),
                const RefreshButton(),
              ],
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<MemesBloc>().add(MemesFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
