//
//  User.swift
//  Eventrack
//
//  Created by Jiazhou Liu on 21/5/17.
//  Copyright © 2017 Jiazhou Liu. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

// user class and get attribute from database snapshot
class User {
    
    var username: String!
    var email: String!
    var photoURL: String!
    var country: String!
    var uid: String?
    var ref: FIRDatabaseReference?
    var key: String?
    
    init(snapshot: FIRDataSnapshot){
        
        key = snapshot.key
        username = snapshot.value(forKey: "username") as! String
        email = snapshot.value(forKey: "email") as! String
        photoURL = snapshot.value(forKey: "photoURL") as! String
        country = snapshot.value(forKey: "country") as! String
        ref = snapshot.ref
    }
    init(username: String, email: String, photoURL: String, country: String){
        self.username = username
        self.email = email
        self.photoURL = photoURL
        self.country = country
    }
}
