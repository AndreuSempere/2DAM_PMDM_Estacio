import 'package:flutter_bloc/flutter_bloc.dart';
import 'tema_event.dart';
import 'tema_state.dart';

class TemaBloc extends Bloc<TemaEvent, TemaState> {
  TemaBloc() : super(TemaState.initial()) {

    on<ThemeChanged>((event, emit) {
      emit(state.estado_actual(
        colorSelecionado: event.selectedColor,
        modoOscuro: event.modoOscuro,
      ));
    });
  }
}
