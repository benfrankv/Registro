//
//  StringExtension.swift
//  Registro
//
//  Created by Ben Frank V. on 11/29/18.
//  Copyright © 2018 Ben Frank V. All rights reserved.
//

import Foundation

extension String {
    
    /**
     This function is used to obtain the Localizable.strings
     */
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    /**
     This function is used to get the Localizable.strings when they have extra parameters
     */
    func localizeWith(arguments: CVarArg...) -> String {
        let localizedValue = self.localized
        return String(format: localizedValue, arguments: arguments)
    }
}
