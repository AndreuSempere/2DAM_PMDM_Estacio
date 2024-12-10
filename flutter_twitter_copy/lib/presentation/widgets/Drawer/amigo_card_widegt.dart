import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Auth/auth_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Auth/auth_event.dart';

class AmigoCard extends StatefulWidget {
  final dynamic user;
  const AmigoCard({super.key, required this.user});

  @override
  State<AmigoCard> createState() => _AmigoCardState();
}

class _AmigoCardState extends State<AmigoCard> {
  bool esAmigo = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.user.avatar),
        ),
        title: Text(
          widget.user.username,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              esAmigo = !esAmigo;
            });
            final userid = widget.user.userid;
            final userToFollow = widget.user.id;

            context.read<AuthBloc>().add(
                  FollowUser(userid, userToFollow),
                );
          },
          child: Icon(
            esAmigo ? Icons.check : Icons.add,
            color: esAmigo ? Colors.green : Colors.blue,
          ),
        ),
      ),
    );
  }
}
