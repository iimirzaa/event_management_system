class Event {
  final String id;                  // Firestore doc id
  final String eventId;             // Collection/type marker
  final String uid;                 // Organizer/User ID
  final String eventName;           // Event name
  final List<String> category;      // Multiple categories
  final int capacity;               // Max participants
  final String street;              // Address
  final String town;                // Sub-area
  final String city;
  final List<String> url;// City
  final DateTime createdAt;         // Firestore timestamp

  Event({
    required this.id,
    required this.eventId,
    required this.uid,
    required this.eventName,
    required this.category,
    required this.capacity,
    required this.street,
    required this.town,
    required this.city,
    required this.url,
    required this.createdAt,
  });

  /// Convert Map -> Event (from Firestore/API)
  factory Event.fromMap(Map<String, dynamic> map) {
    final createdAtMap = map['createdAt'];
    DateTime parsedDate = DateTime.now();

    if (createdAtMap is Map<String, dynamic>) {
      final seconds = createdAtMap['_seconds'] ?? 0;
      final nanoseconds = createdAtMap['_nanoseconds'] ?? 0;
      parsedDate = DateTime.fromMillisecondsSinceEpoch(
        seconds * 1000 + (nanoseconds ~/ 1000000),
      );
    }

    return Event(
      id: map['id'] ?? '',
      eventId: map['eventId'] ?? '',
      uid: map['uid'] ?? '',
      eventName: map['eventname'] ?? '',
      category: List<String>.from(map['category'] ?? []),
      capacity: (map['capacity'] ?? 0) is int
          ? map['capacity']
          : int.tryParse(map['capacity'].toString()) ?? 0,
      street: map['street'] ?? '',
      town: map['town'] ?? '',
      city: map['city'] ?? '',
      url:List<String>.from(map['images']??[]),
      createdAt: parsedDate,
    );
  }
}
