import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SettingEvent extends Equatable {}

class SettingEventToggleUnit extends SettingEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SettingEventDropdown extends SettingEvent {
  final String language;
  SettingEventDropdown({@required this.language});
  @override
  // TODO: implement props
  List<Object> get props => null;
}
