import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../../../ViewModel/StateManagement/Settings/DarkMode/dark_mode_cubit.dart';
import '../../../../constants.dart';

class DarkMode extends StatelessWidget {
  const DarkMode({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DarkModeCubit, DarkModeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        DarkModeCubit darkModeCubit = BlocProvider.of(context);
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                Statics.background(),
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              onTap: () => darkModeCubit.triggerDarkMode(),
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                color: Colors.transparent,
                child: Center(
                  child: darkModeCubit.riveArtBoard == null
                      ? SizedBox.shrink()
                      : Rive(
                    artboard: darkModeCubit.riveArtBoard!,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
