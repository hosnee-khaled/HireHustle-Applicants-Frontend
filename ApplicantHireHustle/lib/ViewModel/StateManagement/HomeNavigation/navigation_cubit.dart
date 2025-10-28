import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../View/Screens/Job Posts/job_list.dart';
import '../../../View/Screens/Settings/settings.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

  var index = 0;

  List screenNames = [
    'Job Posts',
    ''
  ];

  List screens = [
    JobList(),
    SettingsScreen(),
  ];

  void navigateBar(index){
    this.index = index;
    emit(NavigationChangePage());
  }
}
