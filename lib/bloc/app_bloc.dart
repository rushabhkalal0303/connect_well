import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../apiRepository/apis.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState>{
  final _service = Apis();
  BuildContext? _context;
  AppBloc(super.initialState);

}