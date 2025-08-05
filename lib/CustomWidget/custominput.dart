import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInput extends StatefulWidget {
  final String hint;
  final bool obsecure;
  final IconData? icon;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  const CustomInput({
    super.key,
    required this.hint,
    this.controller,
    this.icon,
    this.obsecure = false,
    this.onTap,
  });

  @override
  State<CustomInput> createState() => _State();
}

class _State extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      expands: false,
      obscureText: widget.obsecure,

      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
      ),
      cursorHeight: 30,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: widget.onTap,
          child: Icon(widget.icon, size: 30.sp, color: Colors.white54),
        ),
        constraints: BoxConstraints(
          maxWidth: 320.w,
          minWidth: 320.w,
          maxHeight: 40.h,
          minHeight: 40.h,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.r),
        ),

        filled: true,
        fillColor: Color(0xFF7C7171),
        hintText: widget.hint,
        contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        hintStyle: TextStyle(
          color: Colors.white54,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
