import 'package:flutter/material.dart';
import 'package:myapp/memes/memes.dart';

class MemeList extends StatefulWidget {
  const MemeList({Key? key}) : super(key: key);

  @override
  _MemesState createState() => _MemesState();
}

class _MemesState extends State<MemeList> {
  late Future<Memes> _futureMemes;

  @override
  void initState() {
    super.initState();
    _futureMemes = fetchMemes();
  }

  Widget _buildMemes() {
    return Center(
      child: FutureBuilder<Memes>(
        future: _futureMemes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildList(snapshot.data!.memes);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildList(List<Meme> memes) {
    if (memes == null) {
      return Container();
    }
    return ListView.builder(
        itemCount: memes.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          return _buildRow(memes[index]);
        });
  }

  Widget _buildRow(Meme meme) {
    return MemeListItem(
      postLink: meme.postLink,
      ups: meme.ups,
      thumbnail: meme.url,
      title: meme.title,
    );
  }

  void _refreshData() {
    setState(() {
      _futureMemes = fetchMemes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Memes'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _refreshData,
              tooltip: 'Refresh memes',
            ),
          ],
        ),
        body: _buildMemes());
  }
}