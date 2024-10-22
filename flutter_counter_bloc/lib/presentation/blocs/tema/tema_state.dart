import 'package:equatable/equatable.dart';
import 'package:flutter_counter_bloc/config/theme.dart';

class TemaState extends Equatable {
  final AppTheme appTheme;

  const TemaState({
    required this.appTheme,
  });

  @override
  List<Object> get props => [appTheme];

  factory TemaState.initial() {
    return TemaState(
      appTheme: AppTheme(colorSelecionado: 0, modoOscuro: false),
    );
  }

  TemaState estado_actual({
    int? colorSelecionado,
    bool? modoOscuro,
  }) {
    return TemaState(
      appTheme: AppTheme(
        colorSelecionado: colorSelecionado ?? appTheme.colorSelecionado,
        modoOscuro: modoOscuro ?? appTheme.modoOscuro,
      ),
    );
  }
}