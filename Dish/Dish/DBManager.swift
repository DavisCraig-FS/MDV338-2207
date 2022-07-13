//
//  DBManager.swift
//  Dish
//
//  Created by Craig Davis on 7/10/22.
//

import Foundation
import FirebaseDatabase

final class DBManager{
    
    static let shared = DBManager()
    
    private let database = Database.database().reference()
    
}

extension DBManager {
    
    public func userExists(with email: String, completion: @escaping((Bool) -> Void)){
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: {snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    
    /// Insets new user to database
    public func insertUser(with user: User){
        database.child(user.safeEmail).setValue(["first_name": user.first, "last_name": user.last])
    }
}

struct User {
    let first: String
    let last: String
    let email: String
    
    var safeEmail: String{
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    //    let photoURL: String
}
