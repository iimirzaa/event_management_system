import 'package:event_management_system/Features/Auth/Auth_Bloc/auth_bloc.dart';
import 'package:event_management_system/Features/Auth/Otp/send_otp.dart';
import 'package:event_management_system/Features/Auth/forget_password/change_password.dart';
import 'package:event_management_system/Features/Auth/forget_password/email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 30.sp),
        title: Text(
          "Edit Information",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 25.sp,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFFF6F61),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 25.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileOption(
                          icon: Icons.person,
                          title: "Change Profile Picture",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditProfileView(),
                              ),
                            );
                          },
                        ),
                        _buildProfileOption(
                          icon: Icons.email_outlined,
                          title: "Change Email",
                          onTap: () {},
                        ),
                        _buildProfileOption(
                          icon: Icons.remove_red_eye_outlined,
                          title: "Change Password",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(_)=>BlocProvider(create: (_)=>AuthBloc(),child: ChangePasswordView(),)
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      tileColor: Colors.white,
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, color: color),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: color),
      onTap: onTap,
    ),
  );
}
