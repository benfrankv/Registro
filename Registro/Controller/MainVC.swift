//
//  ViewController.swift
//  Registro
//
//  Created by Ben Frank V. on 11/28/18.
//  Copyright © 2018 Ben Frank V. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var btn_Registry: UIButton!
    @IBOutlet weak var btn_Users: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        btn_Registry.tintColor = UIColor.black
        btn_Users.tintColor = UIColor.black
        btn_Registry.setTitle("registry".localized, for: .normal)
        btn_Users.setTitle("users".localized, for: .normal)
        btn_Registry.titleLabel!.font = UIFont(name: "Menlo-Regular", size: 24.0)
        btn_Users.titleLabel!.font = UIFont(name: "Menlo-Regular", size: 24.0)
    }


}

