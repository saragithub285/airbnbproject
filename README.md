# Hotel Booking Mobile Application

## Project Overview
This project is a Flutter-based **Hotel Booking Mobile Application** inspired by **Airbnb**, designed to provide a seamless, secure, and dynamic user experience. The application integrates **Firebase** for backend services, ensuring real-time data retrieval, secure authentication, and cloud storage. The app allows users to explore hotels, make bookings via an interactive calendar, and complete secure payments through the **Paymob API**.

## Key Features

### 1. **User Authentication**
- **Sign-Up/Login:** Secure user registration and authentication using **Firebase Authentication**.
- **Session Management:** Maintains user sessions across app usage with Firebase session handling.
- **Error Handling:** Provides feedback for failed sign-up or login attempts.

### 2. **Dynamic Hotel Listings**
- **Data Fetching:** Hotels are dynamically retrieved from **Firestore**.
- **Search & Filter:** Users can search hotels by name or location and filter results based on price.

### 3. **Profile Management**
- **User Profiles:** Displays personalized user data (name, email, location) fetched from Firestore.
- **Dynamic Updates:** Real-time data updates for profile changes.

### 4. **Calendar-Based Booking**
- **Interactive Calendar:** Allows users to select check-in and check-out dates.
- **Date Availability:** Booked dates are disabled to prevent double bookings.

### 5. **Secure Payment Integration**
- **Payment Gateway:** Integrated with **Paymob API** for secure in-app payments.
- **Transaction Handling:** Payment confirmations and transaction details are stored in Firestore.

### 6. **Responsive UI Design**
- **Flutter Framework:** Provides an adaptive and responsive design for various screen sizes.
- **User-Friendly Navigation:** Clean and intuitive user interface for seamless interaction.

## Tech Stack
- **Frontend:** Flutter (Dart)
- **Backend:** Firebase (Firestore, Authentication)
- **Payment Integration:** Paymob API

## Project Structure
```
├── lib
│   ├── models
|   |   ├── hoteldata.dart
|   |   └── constants.dart
│   ├── paymob
|   |   ├── payment_gateway.dart
|   |   └── paymob_manager.dart
│   ├── providers
|   |   ├── tripprovider.dart
│   │   └── userprovider.dart
│   ├── screens
|   |   ├── guest_home_screens
|   |   |   ├── booking_list_screen.dart
|   |   |   ├── guestexplorer.dart
│   │   |   ├── guestprofile.dart
│   │   |   └── guesttrips.dart
|   |   ├── edit_profile
│   │   ├── guesthomescreen.dart
|   |   ├── hotel_detail.dart
│   │   ├── loginscreen.dart
│   │   ├── explore_screen.dart
│   │   ├── profile_page
│   │   ├── startscreen.dart
│   │   └── signupscreen.dart
│   ├── view_model
│   │   ├── posting_view_model.dart
│   │   └── user_view_model.dart
│   ├── widgets
│   │   └── calendar_ui.dart
│   └── main.dart
├── pubspec.yaml
├── android
├── ios
└── README.md
```

## Installation

1. **Clone the Repository**
```bash
https://github.com/your-username/flutter-hotel-booking-app.git
cd flutter-hotel-booking-app
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Configure Firebase**
- Set up a Firebase project.
- Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
- Add the files to the respective platform directories.

4. **Run the App**
```bash
flutter run
```

## Screenshots

### **Login Page**
![Login](https://github.com/user-attachments/assets/d916923f-11db-440d-b4c2-b99265246569)



### **Signup Page**
![Signup](https://github.com/user-attachments/assets/24fd8572-7201-47aa-9f6d-322ad82be6f3)



### **Explore Hotels Page**
![explore](https://github.com/user-attachments/assets/f2cee6f3-e366-40f1-b682-37419a6dcd8a)



### **Profile Page**
![profilepage](https://github.com/user-attachments/assets/f217ef9c-19e4-4290-b6be-64bc28c443ba)



### **Booking Page with Calendar Integration**
![explore](https://github.com/user-attachments/assets/12171fa7-f80c-419f-a4d5-09cc462092b3)
![booking](https://github.com/user-attachments/assets/e3e0207c-4b4d-46bf-9b75-32a1ff3e445f)



### **Payment Integration**
![paymob](https://github.com/user-attachments/assets/1eba0d60-ecd5-4d8b-aa62-d35d16f519ba)



## Future Enhancements
- **Advanced Filtering:** Filters based on amenities and location.
- **Push Notifications:** Reminders for upcoming bookings.
- **Multi-language Support:** Localization for global reach.
- **Wishlist Feature:** Save favorite hotels for future bookings.

## Acknowledgments
- Developed with **Flutter** for UI and **Firebase** for backend services.
- Payment integration powered by **Paymob API**.

