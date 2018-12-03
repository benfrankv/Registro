//
//  Loading.swift
//  Registro
//
//  Created by Ben on 30/11/18.
//  Copyright © 2018 Ben Frank V. All rights reserved.
//

import Foundation
import SCLAlertView

class Loading{
    
    
    func loading(_ mensaje: String) -> SCLAlertViewResponder{
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        
        let alert = SCLAlertView(appearance: appearance).showWait(mensaje, subTitle: "", closeButtonTitle: nil, timeout: nil, colorStyle: 0x54C2C0, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: SCLAnimationStyle.topToBottom)
        
        return alert
        
    }
    
}
