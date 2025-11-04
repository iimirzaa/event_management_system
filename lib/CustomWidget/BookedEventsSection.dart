import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookedEventsSection extends StatelessWidget {
  final bool isLoading;
  final List<dynamic> bookedEvents;

  const BookedEventsSection({
    Key? key,
    required this.isLoading,
    required this.bookedEvents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),

          if (!isLoading && bookedEvents.isEmpty)
            Center(
              child: Text(
                "You haven’t booked any events yet.",
                style: TextStyle(color: Colors.grey, fontSize: 16.sp),
              ),
            ),

          if (bookedEvents.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bookedEvents.length,
              itemBuilder: (context, index) {
                final event = bookedEvents[index];

                return Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🖼️ Event Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                        child: Image.network(
                          event['images'] != null && event['images'].isNotEmpty
                              ? event['images'][0]
                              : "https://via.placeholder.com/400x200",
                          height: 180.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['eventname'] ?? 'Unnamed Event',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "Organizer: ${event['organizerName'] ?? 'Unknown'}",
                              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 16, color: Colors.redAccent),
                                SizedBox(width: 4.w),
                                Expanded(
                                  child: Text(
                                    "${event['location'] ?? 'Unknown Location'}, ${event['city'] ?? ''}",
                                    style: TextStyle(color: Colors.black54, fontSize: 14.sp),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            if (event['service'] != null)
                              Text(
                                "Services: ${event['service'].join(', ')}",
                                style: TextStyle(color: Colors.black87, fontSize: 14.sp),
                              ),
                            SizedBox(height: 6.h),
                            Text(
                              "Capacity: ${event['capacity'] ?? 'N/A'} People",
                              style: TextStyle(color: Colors.black87, fontSize: 14.sp),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "Additional Info: ${event['additionalInfo'] ?? 'None'}",
                              style: TextStyle(color: Colors.black87, fontSize: 14.sp),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Booking ID: ${event['bookingId'] ?? ''}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
