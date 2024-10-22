import 'package:dartz/dartz.dart';
import 'package:flutter_harry_potter/data/datasouerces/character_remoto_datasource.dart';
import 'package:flutter_harry_potter/domain/entities/character.dart';
import 'package:flutter_harry_potter/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
 final CharacterRemoteDataSource remoteDataSource;

 CharacterRepositoryImpl(this.remoteDataSource);

 @override
 Future<Either<Exception, List<Character>>> getAllCharacters() async {
   try {
     final characterModels = await remoteDataSource.getAllCharacters();
     return Right(characterModels
         .map((model) => Character(
             name: model.name, house: model.house, image: model.image, species: model.species, edad: model.edad))
       .toList());
   } catch (e) {
     return Left(Exception('Error al cargar personajes'));
   }
 }
}
