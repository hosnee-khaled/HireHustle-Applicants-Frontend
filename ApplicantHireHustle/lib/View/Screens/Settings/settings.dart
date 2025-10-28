import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../ViewModel/StateManagement/Settings/settings_screen_cubit.dart';
import '../../Components/Settings/custom_list_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsScreenCubit, SettingsScreenState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        SettingsScreenCubit settingsScreenCubit = BlocProvider.of(context);
        return Container(
          color: Colors.transparent,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/3,
                  height: MediaQuery.of(context).size.width/3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/photo_2_2022-11-25_21-50-26.jpg'),
                        fit: BoxFit.contain
                    ),
                  ),
                ),
                Text("Username", style: Theme.of(context).textTheme.displayLarge,),
                SizedBox(
                  height: 30.h,
                ),
                ListView.separated(
                  itemBuilder: (context, index) => customListTile(
                    context: context,
                    leadingIcon: settingsScreenCubit.settingsTiles[index]
                        ['leadingIcon'],
                    title: settingsScreenCubit.settingsTiles[index]['title'],
                    onPressed: settingsScreenCubit.settingsListNavigation(
                      context: context,
                      title: settingsScreenCubit.settingsTiles[index]['title'],
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.h,
                  ),
                  itemCount: settingsScreenCubit.settingsTiles.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
