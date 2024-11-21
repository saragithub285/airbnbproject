//responsible handeling business logic of user related features
import 'package: airbnb_clone/model/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package: firebase_storage/firebase_storage.dart';
import 'package: firebase_auth/firebase_auth.dart';


class UserViewModel
{

    SignUp (email, password, firstName, lastName, city, country, bio, imageFileOfUser) async
    {
    Get.snackbar("Please Wait", "Your account is being created.");
    
    try
    {
        

     await FirebaseAuth.instance.createUserWithEmailAnd Password(
        email: email,
        password: password,
    ).then((result) async
     {
       String currentUserID = result.user!.uid;

        AppConstants.currentUser.id = currentUserID;
        AppConstants.currentUser.firstName = firstName;
        AppConstants.currentUser.lastName = lastName;
        AppConstants.currentUser.city = city;
        AppConstants.currentUser.country = country;
        AppConstants.currentUser.bio = bio;
        AppConstants.currentUser.email = email;
        AppConstants.currentUser.password = password;

        await saveUserToFirestore (bio, city, country, email, firstName, LastName, currentUserID)
            .whenComplete (() async
        {
          await addImageToFirebaseStorage(imageFileOfUser, currentUserID);
        });
        Get.snackbar("Congratulations", "Your account has been created.");
      });
    }
    catch(e)
    {
        Get.snackbar("Error", e.toString());
    }
    }

    Future<void> saveUserToFirestore (bio, city, country, email, firstName, lastName, id) async
    {
        Map<String, dynamic> dataMap =
        {
            "bio": bio,
            "city" : city,
            "country": country,
            "email": email,
            "firstName": firstName,
            "LastName": lastName,
            "isHost": false,
            "myPostingIDs": [],
            "savedPostingIDs": [],
            "earnings": 0,
        };
        await FirebaseFirestore.instance.collection("users").doc(id).set(dataMap);
    }

    addImageToFirebaseStorage(File imageFileOfUser, currentUserID) async
    {
        Reference referenceStorage = FirebaseStorage.instance.ref()
            .child("userImages")
            .child(currentUserID)
            .child(currentUserID + ".png");
        
        await referenceStorage.putFile(imageFileOfUser). whenComplete((){});
        
        AppConstants.currentUser.displayImage = MemoryImage(imageFileOfUser.readAsBytesSync());
    }


}