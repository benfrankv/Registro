//
//  Validations.swift
//  Registro
//
//  Created by Ben on 30/11/18.
//  Copyright © 2018 Ben Frank V. All rights reserved.
//

import Foundation
import SwiftCop
import SCLAlertView

class Validations{
    func valid(_ texto : String) -> Bool{
        var validacion = false
        var lengthTrial = Trial.length(.minimum, 0)
        var trial = lengthTrial.trial()
        if(trial(texto)){
            lengthTrial = Trial.length(.maximum, 0)
            trial = lengthTrial.trial()
            if(trial(texto)){
                validacion = true
            }else{
                validacion = false
            }
        }else{
            validacion = false
        }
        
        return validacion
    }
    
    func validaNombre(_ texto : String) -> Bool{
        var validacion = false
        let tamano = texto.lengthOfBytes(using: String.Encoding.utf8)
        let formatTrial = Trial.format("^([a-z A-Z]){\(tamano)}$") // hexa number with #
        var trial = formatTrial.trial()
        if(trial(texto)){
            var lengthTrial = Trial.length(.minimum, 1)
            trial = lengthTrial.trial()
            if(trial(texto)){
                lengthTrial = Trial.length(.maximum, 30)
                trial = lengthTrial.trial()
                if(trial(texto)){
                    validacion = true
                }else{
                    validacion = false
                }
            }else{
                validacion = false
            }
        }else{
            validacion = false
        }
        return validacion
    }
    
    func validaIniciales(_ texto : String) -> Bool{
        var validacion = false
        let tamano = texto.lengthOfBytes(using: String.Encoding.utf8)
        let formatTrial = Trial.format("^([a-zA-Z]){\(tamano)}$") // hexa number with #
        var trial = formatTrial.trial()
        if(trial(texto)){
            var lengthTrial = Trial.length(.minimum, 1)
            trial = lengthTrial.trial()
            if(trial(texto)){
                lengthTrial = Trial.length(.maximum, 6)
                trial = lengthTrial.trial()
                if(trial(texto)){
                    validacion = true
                }else{
                    validacion = false
                }
            }else{
                validacion = false
            }
        }else{
            validacion = false
        }
        return validacion
    }
    
    func validaApellido(_ texto : String) -> Bool{
        var validacion = false
        let tamano = texto.lengthOfBytes(using: String.Encoding.utf8)
        let formatTrial = Trial.format("^([a-z A-Z]){\(tamano)}$") // hexa number with #
        var trial = formatTrial.trial()
        if(trial(texto)){
            var lengthTrial = Trial.length(.minimum, 1)
            trial = lengthTrial.trial()
            if(trial(texto)){
                lengthTrial = Trial.length(.maximum, 20)
                trial = lengthTrial.trial()
                if(trial(texto)){
                    validacion = true
                }else{
                    validacion = false
                }
            }else{
                validacion = false
            }
        }else{
            validacion = false
        }
        return validacion
    }
    
    func validaCorreo(_ texto : String) -> Bool{
        var validacion = false
        let emailTrial = Trial.email
        var trial = emailTrial.trial()
        if(trial(texto)){
            var lengthTrial = Trial.length(.maximum, 100)
            trial = lengthTrial.trial()
            if(trial(texto)){
                validacion = true
            }
        }
        return validacion
    }
    
    func validaTelefono(_ texto : String) -> Bool{
        var validacion = false
        let tamano = texto.lengthOfBytes(using: String.Encoding.utf8)
        let formatTrial = Trial.format("^([0-9]){\(tamano)}$") // hexa number with #
        var trial = formatTrial.trial()
        if(trial(texto)){
            var lengthTrial = Trial.length(.minimum, 8)
            trial = lengthTrial.trial()
            if(trial(texto)){
                lengthTrial = Trial.length(.maximum, 13)
                trial = lengthTrial.trial()
                if(trial(texto)){
                    validacion = true
                }else{
                    validacion = false
                }
            }else{
                validacion = false
            }
        }else{
            validacion = false
        }
        return validacion
    }
    
    func alertError(_ mensaje : String) -> SCLAlertViewResponder{
        let alert = SCLAlertView().showTitle("Error", subTitle: mensaje, style: .error, closeButtonTitle: "Aceptar", colorStyle: 0xFF0000, colorTextButton: 0xFFFFFF)
        return alert
    }
    
    func alertSuccess(_ mensaje : String) -> SCLAlertViewResponder{
        let alert = SCLAlertView().showTitle("Éxito", subTitle: mensaje, style: .success, closeButtonTitle: "Aceptar", colorStyle: 0x009C27, colorTextButton: 0xFFFFFF)
        return alert
    }
    
    func alertWarning(_ mensaje : String) -> SCLAlertViewResponder{
        let alert = SCLAlertView().showTitle("Advertencia", subTitle: mensaje, style: .warning, closeButtonTitle: "Aceptar", colorStyle: 0xE8E818, colorTextButton: 0xFFFFFF)
        return alert
    }
    
    func alertInfo(_ mensaje : String) -> SCLAlertViewResponder{
        let alert = SCLAlertView().showTitle("Información", subTitle: mensaje, style: .info, closeButtonTitle: "Aceptar", colorStyle: 0x0029A7, colorTextButton: 0xFFFFFF)
        return alert
    }
    
    func acentos(palabra : String) -> String{
        var nuevo = ""
        let characters = Array(palabra.characters)
        for a in characters{
            switch a {
            case "á":
                nuevo.append("a")
            case "é":
                nuevo.append("e")
            case "í":
                nuevo.append("i")
            case "ó":
                nuevo.append("o")
            case "ú":
                nuevo.append("u")
            case "Á":
                nuevo.append("A")
            case "É":
                nuevo.append("E")
            case "Í":
                nuevo.append("I")
            case "Ó":
                nuevo.append("O")
            case "Ú":
                nuevo.append("U")
            case "ñ":
                nuevo.append("n")
            case "Ñ":
                nuevo.append("N")
            default:
                nuevo.append(a)
            }
        }
        return nuevo
    }
}
