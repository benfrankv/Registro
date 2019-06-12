//
//  DataVC.swift
//  Registro
//
//  Created by Ben on 30/11/18.
//  Copyright © 2018 Ben Frank V. All rights reserved.
//

import UIKit

class DataVC: UIViewController {

    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_CompleteDataName: UILabel!
    @IBOutlet weak var lbl_Email: UILabel!
    @IBOutlet weak var lbl_DataEmail: UILabel!
    @IBOutlet weak var lbl_Cellphone: UILabel!
    @IBOutlet weak var lbl_DataCellphone: UILabel!
    var delegate = AppDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "data".localized
        lbl_Name.text = "name".localized + ":"
        lbl_Email.text = "email".localized + ":"
        lbl_DataCellphone.text = "cellphone".localized + ":"
        
        
        let list = UserDataDAO.get(delegate)
        for user in list{
            lbl_CompleteDataName.text = "\(user.name!) \(user.firstSurname!) \(user.secondSurname!)"
            lbl_DataEmail.text = user.email
            lbl_DataCellphone.text = user.cellphone
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Tobegin(_ sender: Any) {
//        UserDataDAO.cleanCoreData(delegate)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: "begin") as!UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = nav
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
