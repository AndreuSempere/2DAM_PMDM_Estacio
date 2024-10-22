import 'package:dartz/dartz.dart';
import 'package:flutter_harry_potter/domain/repositories/character_repository.dart';
import 'package:flutter_harry_potter/domain/entities/character.dart';

class GetAllCharacters {
   final CharacterRepository repository;

 GetAllCharacters(this.repository);

 Future<Either<Exception, List<Character>>> call() async {
   return await repository.getAllCharacters();
 }
}