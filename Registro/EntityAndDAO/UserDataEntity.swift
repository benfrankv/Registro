//
//  UserData.swift
//  Registro
//
//  Created by Ben on 30/11/18.
//  Copyright © 2018 Ben Frank V. All rights reserved.
//

import Foundation
import CoreData

class UserDataEntity {
    
    var name: String!
    var firstSurname: String!
    var secondSurname: String!
    var email: String!
    var cellphone: String!
    var photo: Data?
    
    required init(userData: [String: Any]) {
        
        self.name = userData ["name"] as? String
        self.firstSurname = userData ["firstSurname"] as? String
        self.secondSurname = userData ["secondSurname"] as? String
        self.email = userData ["email"] as? String
        self.cellphone = userData ["cellphone"] as? String
        self.photo = userData ["photo"] as? Data
        
    }
    
    init() {
        
    }
}
