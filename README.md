# 🎉 Event Management System App

The **Event Management System** is a cross-platform mobile application built to simplify event organization and participation.  
It enables users to **browse, book, and manage events**, while organizers can **create and manage their own events** efficiently.

---

## 🚀 Features

### 👤 **User Features**
- **Sign Up / Sign In:** Secure account creation and login.
- **OTP Verification:** Email or SMS-based verification for user authentication.
- **Change Password:** Update password securely within the app.
- **View All Events:** Browse all available events with detailed information.
- **Book Event:** Instantly reserve your spot for any event.
- **Profile Management:**
  - Update profile picture  
  - Change email address  
  - Edit personal details
- **Send Feedback:** Provide feedback directly from the app.
- **Notification Control:** Option to turn on/off event notifications.

---

### 🧑‍💼 **Organizer Features**
- **Create Event:** Organizers can create and manage new events (title, date, venue, description, price, etc.).
- **Manage Profile:** Update organizer information and profile picture.
- **View Created Events:** Easily monitor all events they’ve organized.
- **Send Announcements (Coming Soon):** Notify users about event updates.

---

## 🛠️ Tech Stack

| Layer | Technology |
|--------|-------------|
| **Frontend** | Flutter |
| **Backend** | Node.js / Express.js |
| **Database** | Firebase Firestore |
| **Authentication** | Firebase Auth or JWT-based custom auth |
| **Notifications** | Firebase Cloud Messaging (FCM) |
| **Hosting / Deployment** | (Optional) Firebase Hosting or AWS / Railway |

---

## 🔐 Authentication Flow

1. **User Registration:**  
   User signs up using email and password.  
2. **OTP Verification:**  
   A one-time password is sent to verify the account.  
3. **Sign In:**  
   User logs in with verified credentials.  
4. **Password Management:**  
   - Change password option inside settings.  
   - Secure hashing and backend validation.

---

## 🧾 Event Flow

1. User signs in and views all available events.  
2. User books an event → booking confirmation appears.  
3. Organizer creates new events from their dashboard.  
4. Users receive notifications for updates or reminders (if enabled).

---

## ⚙️ Settings & Profile Options
- Edit Profile (name, email, picture)  
- Change Password  
- Send Feedback  
- Toggle Notifications  

---



---

## 💬 Feedback & Support
Users can send feedback directly from the app.  
For developer support or bug reports, please contact the development team.

---

## 🔮 Future Enhancements
- Event chat or discussion section  
- Event reminders via push notifications  
- Payment integration for ticketed events  
- Admin dashboard for analytics and moderation  

---

## 🧑‍💻 Developers
- **Frontend:** Flutter Team  
- **Backend:** Node.js / Express.js Team  
- **Database & Notifications:** Firebase Team  

---

## 📱 Screens Overview
| Screen | Description |
|---------|--------------|
| **Sign Up / Sign In** | User authentication flow |
| **OTP Verification** | Secure account validation |
| **All Events** | Displays every public event |
| **Book Event** | Reserve participation in an event |
| **Organizer Dashboard** | Create and manage events |
| **Profile Screen** | User settings and personal data |
| **Feedback** | Submit user feedback or issues |

---

## 📋 License
This project is intended for educational and demonstration purposes.  
All rights reserved © 2025 Event Management System Team.
