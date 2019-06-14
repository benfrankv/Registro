//
//  UserDataDAO.swift
//  Registro
//
//  Created by Ben on 30/11/18.
//  Copyright © 2018 Ben Frank V. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class UserDataDAO {
    
    static func add(_ appDelegate : AppDelegate, _ userData : UserDataEntity){
        
        let context = appDelegate.persistentContainer.viewContext
        let newUserData = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context)
        
        newUserData.setValue(userData.name, forKey: "name")
        newUserData.setValue(userData.firstSurname, forKey: "firstSurname")
        newUserData.setValue(userData.secondSurname, forKey: "secondSurname")
        newUserData.setValue(userData.email, forKey: "email")
        newUserData.setValue(userData.cellphone, forKey: "cellphone")
        newUserData.setValue(userData.photo, forKey: "photo")
        
        do{
            try context.save()
            print("Saved UserData")
        }catch{
            print("Error UserData")
        }
        
    }
    
    
    static func get(_ appDelegate : AppDelegate) -> [UserDataEntity]{
        var userDataList = [UserDataEntity]()
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            
            if results.count > 0{
                for r in results as! [NSManagedObject]{
                    let userData = UserDataEntity()
                    userData.name = (r.value(forKey: "name") as? String)!
                    userData.firstSurname = (r.value(forKey: "firstSurname") as? String)!
                    userData.secondSurname = (r.value(forKey: "secondSurname") as? String)!
                    userData.email = (r.value(forKey: "email") as? String)!
                    userData.cellphone = (r.value(forKey: "cellphone") as? String)!
                    userData.photo = (r.value(forKey: "photo") as? Data)
                    
                    userDataList.append(userData)
                }
            }else{
                print("Any user")
            }
        }catch{
            
        }
        return userDataList
    }
    
    //https://medium.com/@ankurvekariya/core-data-crud-with-swift-4-2-for-beginners-40efe4e7d1cc
    
    static func search(by: type, some: String, _ appDelegate: AppDelegate) -> UserDataEntity?{
        var specificUser: UserDataEntity? = nil
        var whoat: String = ""
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        
        switch by {
        case .name:
            whoat = "name"
        case .firstSurname:
            whoat = "firstSurname"
        case .secondSurname:
            whoat = "secondSurname"
        case .email:
            whoat = "email"
        case .cellphone:
            whoat = "cellphone"
        }
        
        request.predicate = NSPredicate(format:"\(whoat) = %@", some)
        
        do{
            let results = try context.fetch(request)
            
            if results.count > 0 {
                let object = results[0] as! NSManagedObject
                
                let userData = UserDataEntity()
                userData.name = object.value(forKey: "name") as? String
                userData.firstSurname = object.value(forKey: "firstSurname") as? String
                userData.secondSurname = object.value(forKey: "secondSurname") as? String
                userData.email = object.value(forKey: "email") as? String
                userData.cellphone = object.value(forKey: "cellphone") as? String
                userData.photo = object.value(forKey: "photo") as? Data
                
                specificUser = userData
            }else{
                print("Any user")
            }
        }catch{
            print("Any user")
        }
        return specificUser
        
    }
    
    static func edit(updatedData: userRaw_Struct, _ appDelegate: AppDelegate){
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        
        request.predicate = NSPredicate(format:"name = %@", updatedData.name)
        
        do{
            let results = try context.fetch(request)
            
            if results.count > 0 {
                let object = results[0] as! NSManagedObject
                
                object.setValue(updatedData.name, forKey: "name")
                object.setValue(updatedData.firstSurname, forKey: "firstSurname")
                object.setValue(updatedData.secondSurname, forKey: "secondSurname")
                object.setValue(updatedData.email, forKey: "email")
                object.setValue(updatedData.cellphone, forKey: "cellphone")
                object.setValue(updatedData.photo, forKey: "photo")
                
                do{
                    try context.save()
                    print("Saved UserData")
                }catch{
                    print("Error UserData")
                }
            }else{
                print("Error UserData")
            }
        } catch {
            print("Error UserData")
        }
        
    }
    
    static func delete(who: String, _ appDelegate: AppDelegate){
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        
        request.predicate = NSPredicate(format:"name = %@", who)
        
        do{
            let results = try context.fetch(request)
            
            if results.count > 0{
                ///////////
                let object = results[0] as! NSManagedObject
                
                context.delete(object)
                
                do{
                    try context.save()
                    print("Deleted UserData")
                }catch{
                    print("Error UserData")
                }
                ////////
            }else{
                print("Error UserData")
            }
        } catch {
            print("Error UserData")
        }
        
    }
    
    
    class func cleanCoreData(_ appDelegate : AppDelegate) {
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try context.fetch(fetchRequest) as! [NSManagedObject]
            if items.count > 0{
                context.delete(items.last!)
                print("User Data Eraser")
            }
            
            
            try context.save()
            
        } catch {
            // Error Handling
            // ...
        }
    }
    
}

enum type {
    case name
    case firstSurname
    case secondSurname
    case email
    case cellphone
    
}

struct userRaw_Struct {
    var name: String
    var firstSurname: String
    var secondSurname: String
    var email: String
    var cellphone: String
    var photo: Data?
}
