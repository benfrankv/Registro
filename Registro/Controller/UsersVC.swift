//
//  UsersVC.swift
//  Registro
//
//  Created by Benjamín Velázquez Valtierra on 6/11/19.
//  Copyright © 2019 Ben Frank V. All rights reserved.
//

import UIKit

struct users_Struct {
    var name: String
    var firstSurname: String
    var secondSurname: String
    var email: String
    var cellphone: String
    var image: UIImage
}

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbv_Users: UITableView!
    var appDelegate = AppDelegate()
    
    var usersArr: [users_Struct] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "users".localized
        tbv_Users.delegate = self
        tbv_Users.dataSource = self
        let users = UserDataDAO.get(appDelegate)
        for user in users {
            let imageUser: UIImage! = user.photo == nil ? UIImage(named: "Franxx"): UIImage(data: user.photo!)
            let newUser = users_Struct(name: user.name, firstSurname: user.firstSurname, secondSurname: user.secondSurname, email: user.email , cellphone: user.cellphone, image: imageUser)
            usersArr.append(newUser)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UserTVCC
//        print(usersArr[indexPath.row])
        cell.lbl_Name.text = "\(usersArr[indexPath.row].name) \(usersArr[indexPath.row].firstSurname) \(usersArr[indexPath.row].secondSurname)"
        cell.email.text = usersArr[indexPath.row].email
        cell.cellphone.text = usersArr[indexPath.row].cellphone
        cell.img_User.image = usersArr[indexPath.row].image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = self.usersArr[indexPath.row].name
//        let user = UserDataDAO.search(by: .name, some: name, appDelegate)
//        print(users_Struct(name: user!.name, firstSurname: user!.firstSurname, secondSurname: user!.secondSurname, email: user!.email , cellphone: user!.cellphone, image: UIImage(named: "Franxx")!))

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteUser(en: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = editUser(en: indexPath)
        return UISwipeActionsConfiguration(actions: [edit])
        
    }
    
    func editUser(en indexPath: IndexPath) ->UIContextualAction {
//        let index = indexPath.row
        let action = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
            
            
        }
        action.backgroundColor = UIColor.blue
        
        return action
    }
    
    func deleteUser(en indexPath: IndexPath) ->UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "delete".localized) { (action, view, completion) in
            let name = self.usersArr[indexPath.row].name
            let _ = UserDataDAO.delete(who: name, self.appDelegate)
            self.tbv_Users.reloadRows(at: [indexPath], with: .automatic)
        }
        action.backgroundColor = UIColor.red
        
        return action
    }
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        print("did end editing")
        guard let indexPath = indexPath else {return}
        self.tbv_Users.reloadRows(at: [indexPath], with: .none)
    }

}
