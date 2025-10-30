import 'package:event_management_system/Features/GetStarted/get_started_view.dart';
import 'package:event_management_system/Features/Profile/edit_profile_view.dart';
import 'package:event_management_system/Features/Profile/profile_bloc.dart';
import 'package:event_management_system/Services/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 30.sp
        ),
        title: Text("Profile",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 25.sp
        ),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFFF6F61),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40.h),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFF6F61),
                      Color(0xFFFF9472),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 55.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                            NetworkImage("https://res.cloudinary.com/dtvniftzh/image/upload/v1759558770/event_images/szmqwu9cwfy5r6gipn5a.jpg"),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: Container(
                            height: 40.r,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.edit,
                                  color: Color(0xFFFF6F61), size: 20),
                              onPressed: () {
                                // Add image edit action
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    FutureBuilder<String?>(future: TokenStorage.getName(), builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Text("Welcome ...",
                            style: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.white, fontWeight: FontWeight.bold
                            ),
                        );
                      }
                      else if (snapshot.hasError) {
                        return Text(
                          "Error",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      }else{
                        return Text(
                          "${snapshot.data}",
                          style: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.white, fontWeight: FontWeight.bold
                          ),
                        );
                      }


                    }),
                    FutureBuilder<String?>(future: TokenStorage.getEmail(), builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Text("...",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white.withOpacity(0.9),
                            ),
                        );
                      }
                      else if (snapshot.hasError) {
                        return Text(
                          "Error",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      }else{
                        return Text(
                          softWrap: true,
                          overflow:TextOverflow.ellipsis,
                          "${snapshot.data}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        );
                      }


                    }),
                    FutureBuilder<String?>(future: TokenStorage.getRole(), builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Text("...",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            );
                      }
                      else if (snapshot.hasError) {
                        return Text(
                          "Error",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      }else{
                        return Text(
                          "Event ${snapshot.data}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        );
                      }


                    })
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileOption(
                      icon: Icons.person,
                      title: "Edit Profile",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>EditProfileView()));
                      },
                    ),
                    _buildProfileOption(
                      icon: Icons.settings,
                      title: "Settings",
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      icon: Icons.help_outline,
                      title: "Help & Support",
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      icon: Icons.logout,
                      title: "Logout",
                      color: Colors.red,
                      onTap: () {
                        TokenStorage.storage.deleteAll();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>GetStartedView()),(route)=>false);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  },
);
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        tileColor: Colors.white,
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(fontSize: 16.sp, color: color)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16,color: color,),
        onTap: onTap,
      ),
    );
  }
}
