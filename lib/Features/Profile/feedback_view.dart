import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 30.sp),
        title: Text(
          "Help and Support",
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
      body: Center(
        child: Padding(
          padding:  EdgeInsets.all(8.r),
          child: Column(
            children: [
               TextFormField(
                cursorColor: const Color(0xFFFF6F61),
                maxLength: 500,
                maxLines: 6, // allows multi-line input
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  hintText: "Write your query here .....",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14.sp,
                  ),
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 14.w,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(color: Colors.deepOrangeAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: const BorderSide(
                      color: Color(0xFFFF6F61),
                      width: 2,
                    ),
                  ),
                  counterText: "", // hides maxLength counter for cleaner look
                ),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 15.h),
           OutlinedButton.icon(
          onPressed: () {
    Navigator.pushNamed(context, "/customize");
    },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(400.w, 40.h),
        padding: EdgeInsets.symmetric(vertical: 14.h),
        side: const BorderSide(color: Colors.green),
        backgroundColor: Colors.green.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      icon:  Icon(
        Icons.done,
        color: Colors.white,
        size: 18.sp,
      ),
      label: Text(
        "Submit",
        style: TextStyle(
          fontSize: 18.sp,
          color:  Colors.white,
        ),
      ),
    )
            ],
          ),
        ),
      ),
    );
  }
}
