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
            let newUser = users_Struct(name: "\(user.name!) \(user.firstSurname!) \(user.secondSurname!)", email: user.email , cellphone: user.cellphone, image: imageUser)
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
        print(usersArr[indexPath.row])
        cell.lbl_Name.text = usersArr[indexPath.row].name
        cell.email.text = usersArr[indexPath.row].email
        cell.cellphone.text = usersArr[indexPath.row].cellphone
        cell.imageView!.image = usersArr[indexPath.row].image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let user = UserDataDAO.search(by: .name, some: usersArr[indexPath.row].name, appDelegate)
        let fullNameArr = usersArr[indexPath.row].name.components(separatedBy: " ")
        let name = fullNameArr[0]
        let user = UserDataDAO.search(by: .name, some: name, appDelegate)
        print(users_Struct(name: "\(user!.name!) \(user!.firstSurname!) \(user!.secondSurname!)", email: user!.email , cellphone: user!.cellphone, image: UIImage(named: "Franxx")!))

    }

}
