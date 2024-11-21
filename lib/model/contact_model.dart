import 'package: flutter/material.dart';

class ContactModel
{
    String? id;
    String? firstName;
    String? lastName;
    String? fullName;
    Memory Image? displayImage;

    ContactModel({
        this.id = "",
        this.firstName = "",
        this.lastName = "",
        this.displayImage,
    });

    String getFullNameOfUser()
    {
        
        return fullName = firstName! + " " + lastName!;
    }

    UserModel createUserFromContact()
    {
        return UserModel(
        id: id!,
        firstName: firstName!,
        lastName: lastName!,
        displayImage: displayImage!,

    );
    }
}