//
//  UserDataDAO.swift
//  Registro
//
//  Created by Ben on 30/11/18.
//  Copyright © 2018 Ben Frank V. All rights reserved.
//

import Foundation
import CoreData

class UserDataDAO {
    
    static func add(_ appDelegate : AppDelegate, _ userData : UserDataEntity){
        
        let context = appDelegate.persistentContainer.viewContext
        let newUserData = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context)
        
        newUserData.setValue(userData.name, forKey: "name")
        newUserData.setValue(userData.firstSurname, forKey: "firstSurname")
        newUserData.setValue(userData.secondSurname, forKey: "secondSurname")
        newUserData.setValue(userData.email, forKey: "email")
        newUserData.setValue(userData.cellphone, forKey: "cellphone")
        
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

                    
                    userDataList.append(userData)
                }
            }else{
                print("Sin usuario")
            }
        }catch{
            
        }
        return userDataList
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
                print("Contenido de usuario borrado")
            }
            
            
            try context.save()
            
        } catch {
            // Error Handling
            // ...
        }
    }
    
}
