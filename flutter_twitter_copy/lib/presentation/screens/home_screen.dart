import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Tweet/tweet_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Tweet/tweet_event.dart';
import 'package:flutter_twitter_copy/presentation/widgets/Drawer/drawer_widget.dart';
import 'package:flutter_twitter_copy/presentation/widgets/Tweets/lista_tweets_widget.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _filter = '';

  @override
  void initState() {
    super.initState();
    context.read<TweetBloc>().add(GetAllTweet(_filter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TweetStacio'),
          centerTitle: true,
        ),
        endDrawer: const DrawerWidget(),
        body: _buildInventariBody());
  }

  Widget _buildInventariBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    _filter = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Filtrar por usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                onPressed: () {
                  context.read<TweetBloc>().add(GetAllTweet(_filter));
                },
                child: const Icon(Icons.search),
              ),
            ],
          ),
        ),
        const Expanded(child: InventariWidget()),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.push('/crear_tweet');
              },
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              height: 80,
              width: 10,
            )
          ],
        )
      ],
    );
  }
}
