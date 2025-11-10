import 'package:event_management_system/Features/event/event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late List<dynamic> notifications=[];
  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(LoadNotifications());
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventBloc, EventState>(
  listener: (context, state) {

  },
  builder: (context, state) {
    Widget bodyContent;
    if(state is LoadingState){
      bodyContent=ListView.builder(
        shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context,index){
        return Skeletonizer(child: _buildNotificationCard(title: "Loading", icon: Icons.notifications_active));
      });
    }else if(state is NotificationLoadedState){
      notifications=state.notification;
      bodyContent=ListView.builder(
          shrinkWrap: true,
          itemCount: notifications.length,
          itemBuilder: (context,index){
            return _buildNotificationCard(title: notifications[index]['message'], icon: Icons.notifications_active);
          });
    }else {
      bodyContent = Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No Notification Found",
              style: TextStyle(
                color: Colors.redAccent[100],
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5.w),
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25.r),
          ),
        ),
        backgroundColor: const Color(0xFFFF6F61),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:  EdgeInsets.all(20.r),
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                 bodyContent
              ],
            ),
          ),
        ),
      )),
    );
  },
);
  }
}
Widget _buildNotificationCard({
  required final String title,
  required final IconData icon,
   // callback when tapped
}) {
  return InkWell(// handle tap
    borderRadius: BorderRadius.circular(10), // ripple effect border
    child: Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange.shade800,size: 35.sp,),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 17.sp,
                overflow: TextOverflow.visible, // text overflow handling
              ),
            ),
          ),

        ],
      ),
    ),
  );
}

