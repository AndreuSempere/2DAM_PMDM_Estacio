import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Tweet/tweet_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Tweet/tweet_state.dart';

class InventariWidget extends StatelessWidget {
  const InventariWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TweetBloc, TweetState>(
      builder: (context, tweetState) {
        if (tweetState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (tweetState.errorMessage.isNotEmpty) {
          return Center(child: Text(tweetState.errorMessage));
        } else if (tweetState.tweets.isNotEmpty) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total Tweets mostrados: ${tweetState.tweets.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tweetState.tweets.length,
                  itemBuilder: (context, index) {
                    final tweet = tweetState.tweets[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            tweet.userAvatar ??
                                'https://via.placeholder.com/150',
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(
                              tweet.userId,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.check_circle,
                                size: 16, color: Colors.blue),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tweet.content),
                            Image.network(
                              tweet.image ?? '',
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: Text('No hay inventarios que coincidan con el filtro.'),
          );
        }
      },
    );
  }
}
