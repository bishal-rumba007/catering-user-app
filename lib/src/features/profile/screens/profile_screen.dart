import 'package:catering_user_app/src/features/auth/screens/auth_provider.dart';
import 'package:catering_user_app/src/features/profile/data/update_image_provider.dart';
import 'package:catering_user_app/src/features/profile/screens/widgets/option_card.dart';
import 'package:catering_user_app/src/shared/data/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userStream = ref.watch(singleUserProvider);
    return Scaffold(
      body: userStream.when(
        data: (data) {
          final username = data.firstName!.split(' ');
          final String displayName = "${username[0][0]}${username[1][0]}";
          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 280.h,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          height: 220.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffffde8b),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(34.r),
                            child: SvgPicture.asset(
                              'assets/backdrops/food.svg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        data.imageUrl == null ? Positioned(
                          left: 124.w,
                          bottom: 5.h,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).secondaryHeaderColor,
                            radius: 70.r,
                            child: Text(
                              displayName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ) : Positioned(
                          left: 124.w,
                          bottom: 5.h,
                          child: CircleAvatar(
                            radius: 70.r,
                            backgroundImage: NetworkImage(
                              data.imageUrl!,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 226.w,
                          bottom: 10.h,
                          child: Container(
                            height: 36.h,
                            width: 36.h,
                            decoration: BoxDecoration(
                                color: const Color(0xfffec734).withOpacity(0.9),
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Center(
                              child: IconButton(
                                onPressed: () async{
                                  final ImagePicker picker = ImagePicker();
                                  final myImage = await picker.pickImage(source: ImageSource.gallery);
                                  if(myImage != null){
                                    ref.read(updateImageProvider(myImage));
                                  }else {
                                    return;
                                  }
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20.w,
                          bottom: 70.h,
                          child: Container(
                            height: 32.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Text(
                                'EDIT',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Text(
                    "${data.firstName}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "${data.metadata?['role']}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "${data.metadata!["email"]}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "${data.metadata!["phone"]}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Column(
                      children: [
                        OptionCard(
                          iconData: Icons.rate_review_outlined,
                          text: 'Reviews & Feedback',
                          subText: 'View reviews and feedbacks',
                          onPressed: (){},
                        ),
                        SizedBox(height: 14.h,),
                        OptionCard(
                          iconData: Icons.history,
                          text: 'History',
                          subText: 'Service history',
                          onPressed: (){},
                        ),
                        SizedBox(height: 14.h,),
                        OptionCard(
                          iconData: Icons.attach_money,
                          text: 'Payment',
                          subText: 'Payment history',
                          onPressed: (){
                            Navigator.pushNamed(context, '/payment-history');
                          },
                        ),
                        SizedBox(height: 14.h,),
                        OptionCard(
                          iconData: Icons.help_outline,
                          text: 'Support',
                          subText: 'Request for help & support ',
                          onPressed: (){},
                        ),
                        SizedBox(height: 14.h,),
                        OptionCard(
                          iconData: Icons.power_settings_new_rounded,
                          text: 'Logout',
                          subText: 'Sign out of the application',
                          onPressed: (){
                            ref.read(authProvider).logOut();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => Center(child: Text('$error'),),
        loading: () => const Center(child: CircularProgressIndicator(),),
      )
    );
  }
}
