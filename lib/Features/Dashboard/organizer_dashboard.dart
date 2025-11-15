import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management_system/CustomWidget/CustomCard.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/Features/Dashboard/Dashboard_bloc/dashboard_bloc.dart';
import 'package:event_management_system/Features/Profile/profile_view.dart';
import 'package:event_management_system/Features/event/createevent_presentation.dart';
import 'package:event_management_system/Features/event/notification_view.dart';
import 'package:event_management_system/Repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrganizerDashboard extends StatefulWidget {
  const OrganizerDashboard({super.key});

  @override
  State<OrganizerDashboard> createState() => _OrganizerDashboardState();
}

class _OrganizerDashboardState extends State<OrganizerDashboard> {
  late List<dynamic> events;
  late  bool? hasProfilePic;
   String? url;
  XFile ?profilePic;
  final ImagePicker picker=ImagePicker();

  Future<void> chooseFromGalley()async{

    XFile? pickedFile=await picker.pickImage(source:ImageSource.gallery);
    if(pickedFile != null) {
      setState(() {
        profilePic = pickedFile;
      });
    }
    if(mounted) {
      Navigator.pop(context);
      checkProfilePic();
    }

  }
  Future<void> takePhoto()async{
    XFile? pickedFile=await picker.pickImage(source:ImageSource.camera);
    if(pickedFile != null) {
      setState(() {
        profilePic = pickedFile;
      });
    }
    if(mounted) {
      Navigator.pop(context);
      checkProfilePic();
    }
  }

@override
  void dispose() {
    super.dispose();
  }

  Future<void> checkProfilePic() async {
    Map <String ,dynamic> response =await AuthProvider().getUserInfo();


    if(response['success']==true){

      final profileInfo=response['profileData'];
      final result=profileInfo['hasProfilePic'];
      final profileUrl=profileInfo['url'];
      if(profileUrl!=null) {
        final storage = FlutterSecureStorage();
        await storage.write(key: 'profilePicUrl', value: profileUrl);
        url = (await storage.read(key: 'profilePicUrl'))!;
      }
      setState(() {
        hasProfilePic = result;
      });
    }else{
      return;
    }




    if (hasProfilePic == false || hasProfilePic == null) {
      // show dialog safely after build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            title:profilePic==null? const Text("Profile Incomplete",style: TextStyle(
              color: Color(0xFFFF6F61),
              fontWeight: FontWeight.w500
            ),):Text("Photo Selected",style: TextStyle(
                color: Color(0xFFFF6F61),
                fontWeight: FontWeight.w500
            ),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                profilePic==null?const Text(
                  "Please upload a profile picture to continue.",textAlign: TextAlign.start,
                ):Text("Save Profile Picture",textAlign: TextAlign.left),
                SizedBox(
                  height: 5.h,
                ),
                CircleAvatar(
                    radius: 50.sp,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: profilePic != null
                        ? FileImage(File(profilePic!.path))
                        : const AssetImage('assets/images/img_4.png') as ImageProvider,
                  ),

              ],
            ),
             actions: profilePic==null?
             [

              TextButton(
                onPressed:chooseFromGalley,
                child:  Text("Choose from Gallery",style: TextStyle(
                    color: Colors.deepOrange[400]
                ),),
              ),
              TextButton(
                onPressed:takePhoto,
                child:  Text("Take now",style: TextStyle(
                    color: Colors.deepOrange[400]
                ),),
              )]:[TextButton(onPressed: (){
               context.read<DashboardBloc>().add(SaveProfilePicClicked(img: profilePic));
               Navigator.pop(context);
             }, child: Text("Save",style: TextStyle(
                 color: Colors.deepOrange[400]
             ),))

            ]
          ),
        );
      });
    }
  }




  @override @override
  void initState() {
   super.initState();
   checkProfilePic();
   context.read<DashboardBloc>().add(LoadOrganizerEvents());
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if(state is CreateEventButtonState){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>CreateEventView()));
        }
        if (state is ProfileLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator(color: Color(0xFFFF6F61),)),
          );
        }

      },
       buildWhen: (previous,current){
        if(current is ProfileLoadingState||current is ProfilePicUploaded){
          return false;
        }else{
          return true;
        }
       },
      builder: (context, state) {
        Widget bodyContent;

        if (state is LoadingState) {
          // Skeleton loader
          bodyContent = ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Skeletonizer(
                  enabled: true,
                  child: CustomCard(
                    user: 'Org',
                    title: "Loading...",
                    street: '.........',
                    town: '.........',
                    url: '...........',
                    city:'.........',
                    textButton1: "View Detail",
                    textButton2: "Book Now",
                    details: [],
                  ),
                ),
              );
            },
          );
        } else if (state is OrganizerEventLoadedState) {
          events = state.events;

          bodyContent = ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Skeletonizer(
                  enabled: false,
                  child: CustomCard(
                    user: 'Org',
                    title:event.eventName ?? "No Title",
                    category: event.category[0],
                    street: event.street,
                    url: event.url[0],
                    town: event.town,
                    city:event.city,
                    textButton1: "View Detail",
                    textButton2: "Update",
                    details: [event],
                  ),
                ),
              );
            },
          );
        } else {
          bodyContent =  Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Something went wrong",style: TextStyle(
                  color: Colors.redAccent[100],
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500
              ),),
              SizedBox(
                width: 5.w,
              ),
              GestureDetector(
                onTap: ()=>context.read<DashboardBloc>().add(LoadOrganizerEvents()),
                child: Icon(Icons.refresh,
                  color: Colors.green,),
              )
            ],
          ));
        }
        return Scaffold(
          backgroundColor: Colors.grey[100],
            appBar: AppBar(
              automaticallyImplyLeading: true,
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
              ),

              centerTitle: true,
              backgroundColor: const Color(0xFFFF6F61),
              title: Text(
                'EventEase',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationView()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CircleAvatar(
                      radius: 18.h,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.notifications_none, color: Colors.redAccent),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileView()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12), child:CircleAvatar(
                    radius: 18.h, // half of height/width
                    backgroundImage: url != null
                        ? CachedNetworkImageProvider(url!)
                        : const AssetImage('assets/images/img_4.png') as ImageProvider,
                    backgroundColor: Colors.grey[200], // optional placeholder color
                  )

                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Center(child: Column(children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: const Color(0xFFFF6F61).withOpacity(0.2),
                          child: Icon(Icons.event_note_outlined, color: const Color(0xFFFF6F61), size: 20),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                          text: "My Events",
                          color: Color(0xFFFF6F61),
                          weight: FontWeight.w500,
                          size: 20.sp,
                        ),
                      ],
                    ),
                    bodyContent,
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: const Color(0xFFFF6F61).withOpacity(0.2),
                          child: Icon(Icons.home_work_outlined, color: const Color(0xFFFF6F61), size: 20),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                          text: "Bookings",
                          color: Color(0xFFFF6F61),
                          weight: FontWeight.w500,
                          size: 20.sp,
                        ),
                      ],
                    ),
                  ])),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(onPressed: () {
              context.read<DashboardBloc>().add(CreateEventButtonClicked());
            },
              splashColor: Color(0xff918989),

              shape: CircleBorder(),
              tooltip: "Create new event",
              backgroundColor: Color(0xFFFF6F61),
              child: Icon(Icons.add, color: Colors.white,
                size: 35.sp,
                opticalSize: 30,),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        );

      },
    );
  }
}
