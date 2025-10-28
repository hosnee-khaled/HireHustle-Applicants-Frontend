import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../ThemeData/app_theme.dart';
import '../../../../ViewModel/StateManagement/Settings/Profile/profile_cubit.dart';
import '../../../../constants.dart';
import '../../../Components/Registration/registration_textFormField_component.dart';
import '../../../Components/Registration/secondary_button.dart';
import '../../../Components/main_button.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Statics.background()),
          fit: BoxFit.fill,
        ),
      ),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          ProfileCubit profileCubit = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              actions: [
                !profileCubit.editable
                    ? Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.03),
                        child: PopupMenuButton(
                          splashRadius: 0,
                          color: AppColorLight.contactUsTextFieldColor,
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              onTap: () => profileCubit.editProfile(),
                              value: 'edit',
                              child: Text(
                                'Edit Profile',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ],
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/photo_2_2022-11-25_21-50-26.jpg'),
                          fit: BoxFit.contain),
                    ),
                  ),
                  profileCubit.editable
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0.w,
                            vertical: 10.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SecondaryButton(
                                buttonLabel: 'Upload Image',
                                onPressed: () {},
                              ),
                              SecondaryButton(
                                  buttonLabel: 'Take Image', onPressed: () {}),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 20.h,
                        ),
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0.w,
                            vertical: 10.h,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomRegistrationTextFormField(
                                  labelText: 'Nour',
                                  labelColor: Colors.white,
                                  textColor: Colors.white,
                                  cursorColor: Colors.white,
                                  borderColor: Colors.transparent,
                                  borderWidth: 2.sp,
                                  borderRadius: 10.sp,
                                  focusedBorderColor:
                                      Color.fromRGBO(22, 208, 227, 1),
                                  focusedBorderWidth: 2.sp,
                                  focusedBorderRadius: 10.sp,
                                  controller: null,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 30,
                              ),
                              Expanded(
                                child: CustomRegistrationTextFormField(
                                  labelText: 'Amr',
                                  labelColor: Colors.white,
                                  textColor: Colors.white,
                                  cursorColor: Colors.white,
                                  borderColor: Colors.transparent,
                                  borderWidth: 2.sp,
                                  borderRadius: 10.sp,
                                  focusedBorderColor:
                                      Color.fromRGBO(22, 208, 227, 1),
                                  focusedBorderWidth: 2.sp,
                                  focusedBorderRadius: 10.sp,
                                  controller: null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          itemBuilder: (context, index) =>
                              CustomRegistrationTextFormField(
                            labelText: 'Alo',
                            labelColor: Colors.white,
                            textColor: Colors.white,
                            cursorColor: Colors.white,
                            borderColor: Colors.transparent,
                            borderWidth: 2.sp,
                            borderRadius: 10.sp,
                            focusedBorderColor: Color.fromRGBO(22, 208, 227, 1),
                            focusedBorderWidth: 2.sp,
                            focusedBorderRadius: 10.sp,
                            controller: null,
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10.h),
                          itemCount: 7,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          physics: NeverScrollableScrollPhysics(),
                        ),
                        SizedBox(height: 10.h),
                        SecondaryButton(
                          buttonLabel: 'Show CV',
                          onPressed: () {},
                        ),
                        profileCubit.editable ? SizedBox(
                          height: MediaQuery.of(context).size.height / 25,
                        ) : SizedBox(),
                        profileCubit.editable ? MainButton(
                          context: context,
                          buttonLabel: 'Cancel',
                          onPressed: () => profileCubit.editProfile(),
                        ) : SizedBox(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 25,
                        ),
                        profileCubit.editable ? MainButton(
                          context: context,
                          buttonLabel: 'Update Profile',
                          onPressed: () {},
                        ) : SizedBox(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
