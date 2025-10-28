import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ViewModel/StateManagement/JobList/job_list_cubit.dart';
import '../../../constants.dart';
import '../../Components/snack_bar.dart';


class JobViewScreen extends StatelessWidget {
  JobViewScreen({super.key, required this.jobPostIndex});

  int jobPostIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              Statics.background(),
            ),
            fit: BoxFit.fill),
      ),
      child: BlocConsumer<JobListCubit, JobListState>(
        listener: (context, state) {
          if (state is ApplySucceeded){
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                icon: Icons.mood_outlined,
                text: 'Congratulations!! ',
                backgroundColor: Colors.green,
              ),
            );
          } else if(state is ApplyFailed){
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                icon: Icons.mood_bad_outlined,
                text: 'Sorry, you need to provide CV in your profile.',
                backgroundColor: Colors.red,
              ),
            );
          } else if(state is ApiRequestFailed){
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                icon: Icons.mood_bad_outlined,
                text: state.apiRequestErrorMessage,
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          JobListCubit jobListCubit = BlocProvider.of(context);
          var jobDetails = [
            'jobDescription',
            'jobRequirements',
            'overtime',
            'benefits',
            'additionalRequirements',
            'expirationPeriod',
            'creationTime'
          ];
          var jobDetailsLabel = [
            'Job Description',
            'Job Requirements',
            'Overtime',
            'Benefits',
            'Additional Requirements',
            'Expiration Period',
            'Creation Time'
          ];
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: Image.asset(
                      'assets/images/${jobListCubit.jobList[jobPostIndex]['jobCategory']}.png',
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(43, 42, 57, 1.0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  jobListCubit.jobList[jobPostIndex]
                                      ['jobTitle'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge,
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.category_outlined,
                                  color: Color.fromRGBO(177, 83, 126, 1.0),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.01,
                                ),
                                Text(
                                  jobListCubit.jobList[jobPostIndex]
                                      ['jobCategory'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.height *
                                      0.04,
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Color.fromRGBO(177, 83, 126, 1.0),
                                ),
                                Text(
                                  jobListCubit.jobList[jobPostIndex]
                                      ['jobLocation'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium,
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              height:
                                  MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Color.fromRGBO(97, 165, 207, 1.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.work_history_outlined,
                                        color:
                                            Color.fromRGBO(177, 83, 126, 1.0),
                                      ),
                                      Text(
                                        jobListCubit.jobList[jobPostIndex]
                                                ['workingHours'] +
                                            ' hours',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height,
                                    color: Color.fromRGBO(97, 165, 207, 1.0),
                                    width:
                                        MediaQuery.of(context).size.height *
                                            0.003,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.attach_money_outlined,
                                        color:
                                            Color.fromRGBO(177, 83, 126, 1.0),
                                      ),
                                      Text(
                                        jobListCubit.jobList[jobPostIndex]
                                            ['salary'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04,
                            ),
                            ListView.separated(
                              itemBuilder: (context, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    jobDetailsLabel[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  Text(
                                    jobDetailsLabel[index] ==
                                                'Expiration Period' ||
                                            jobDetailsLabel[index] ==
                                                'Creation Time'
                                        ? jobListCubit.convertDateTimeFormat(
                                            jobListCubit.jobList[jobPostIndex]
                                                [jobDetails[index]])
                                        : jobListCubit.jobList[jobPostIndex]
                                            [jobDetails[index]],
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ],
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              itemCount: jobDetailsLabel.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color.fromRGBO(177, 83, 126, 1.0),
                                        const Color(0xFF00CCFF)
                                      ],
                                      begin: Alignment.center,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () => jobListCubit.applyForJob(jobPostId: jobListCubit.jobList[jobPostIndex]['id']),
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    child: Text(
                                      'Apply',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
