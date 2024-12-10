import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Auth/auth_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Tweet/tweet_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Tweet/tweet_event.dart';

class CrearTweetWidget extends StatefulWidget {
  const CrearTweetWidget({super.key});

  @override
  DialogoState createState() => DialogoState();
}

class DialogoState extends State<CrearTweetWidget> {
  final _contentController = TextEditingController();
  final _imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Añadir Nuevo Tweet'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Contenido'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Introduce un contenido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'Añade una imagen'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Introduce una imagen';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              final myLoginState = context.read<AuthBloc>().state;
              final userid = myLoginState.user?.id;
              if (userid == null) {
                return;
              }

              final content = _contentController.text;
              final imagen = _imageController.text;

              if (content.isEmpty || imagen.isEmpty) {
                return;
              }

              context.read<TweetBloc>().add(
                    CreateTweet(userid, content, imagen),
                  );

              Navigator.of(context).pop(); // Cerrar el diálogo
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    _imageController.dispose();
    super.dispose();
  }
}
