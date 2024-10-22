import 'package:equatable/equatable.dart';

abstract class TemaEvent extends Equatable {
  const TemaEvent();

  @override
  List<Object> get props => [];
}

class ThemeChanged extends TemaEvent {
  final int selectedColor;
  final bool modoOscuro;

  const ThemeChanged({
    required this.selectedColor,
    required this.modoOscuro,
  });

  @override
  List<Object> get props => [selectedColor, modoOscuro];
}
