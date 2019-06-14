//
//  UserTVCC.swift
//  Registro
//
//  Created by Benjamín Velázquez Valtierra on 6/11/19.
//  Copyright © 2019 Ben Frank V. All rights reserved.
//

import UIKit

class UserTVCC: UITableViewCell {

    @IBOutlet weak var img_User: UIImageView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var cellphone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.img_User.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
