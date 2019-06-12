//
//  RegistryVC.swift
//  Registro
//
//  Created by Ben on 29/11/18.
//  Copyright © 2018 Ben Frank V. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SCLAlertView

class RegistryVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate {
    

    @IBOutlet weak var txtfld_Name: SkyFloatingLabelTextField!
    @IBOutlet weak var txtfld_FirstSurname: SkyFloatingLabelTextField!
    @IBOutlet weak var txtfld_SecondSurname: SkyFloatingLabelTextField!
    @IBOutlet weak var txtfld_Email: SkyFloatingLabelTextField!
    @IBOutlet weak var txtfld_Cellphone: SkyFloatingLabelTextField!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_FirstSurname: UILabel!
    @IBOutlet weak var lbl_SecondSurname: UILabel!
    @IBOutlet weak var lbl_Email: UILabel!
    @IBOutlet weak var lbl_Cellphone: UILabel!
    @IBOutlet weak var btn_PickGallery: UIButton!
    @IBOutlet weak var PP_Photo: UIImageView!
    
    
    var delegate = AppDelegate()
    var valid = Validations()
    var formUser = [[String: Any]]()
    let load = Loading()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "registry".localized
        addTheme()
        delegateTextField()
        placeholder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTheme() {
        applySkyscannerTheme(SkyFloatingLabelTxtfld: txtfld_Name)
        applySkyscannerTheme(SkyFloatingLabelTxtfld: txtfld_FirstSurname)
        applySkyscannerTheme(SkyFloatingLabelTxtfld: txtfld_SecondSurname)
        applySkyscannerTheme(SkyFloatingLabelTxtfld: txtfld_Email)
        applySkyscannerTheme(SkyFloatingLabelTxtfld: txtfld_Cellphone)
        
    }
    
    func applySkyscannerTheme(SkyFloatingLabelTxtfld: SkyFloatingLabelTextField) {
        SkyFloatingLabelTxtfld.tintColor = UIColor.black
        SkyFloatingLabelTxtfld.textColor = UIColor.black
        SkyFloatingLabelTxtfld.lineColor = UIColor.lightGray
        
        SkyFloatingLabelTxtfld.selectedTitleColor = UIColor(named: "BlueFranxx")!
        SkyFloatingLabelTxtfld.selectedLineColor = UIColor(named: "BlueFranxx")!
        
        // Set custom fonts for the title, placeholder and textfield labels
        SkyFloatingLabelTxtfld.titleLabel.font = UIFont(name: "Menlo Regular", size: 12)
        SkyFloatingLabelTxtfld.placeholderFont = UIFont(name: "Menlo Regular", size: 18)
        SkyFloatingLabelTxtfld.font = UIFont(name: "Menlo Regular", size: 18)
        
    }
    
    func validateTextFieldWithText(text: String?, tf: SkyFloatingLabelTextField, nameTF: String) {
        guard let text = text else {
            tf.errorMessage = nil
            return
        }
        
        if text.characters.isEmpty {
            tf.errorMessage = nil
        } else if !valid.valid(text) {
            tf.errorMessage = NSLocalizedString(
                "\(nameTF)",
                tableName: "SkyFloatingLabelTextField",
                comment: " "
            )
        } else {
            tf.errorMessage = nil
        }
    }
    
    func validaCampo(_ caso : Int16,_ alert : Bool) -> Bool{
        var validacion = false
        switch caso {
         //Sólo un Idioma 
        case 1:
            
            if valid.validaNombre(valid.acentos(palabra: txtfld_Name.text!)) {
                self.lbl_Name.text = ""
                txtfld_Name.errorMessage = nil
                validacion = true
            }else if txtfld_Name.text! == "" {
                self.lbl_Name.text = "El nombre \("validations.emptyFieldLbO".localized)"
                txtfld_Name.errorMessage = nil
                validacion = false
            }else{
                validateTextFieldWithText(text: txtfld_Name.text, tf: txtfld_Name, nameTF: "name".localized)
                self.lbl_Name.text = "El nombre \("validations.lettersAndSpaces".localized)"
                validacion = false
            }
            
        case 2:
            
            if valid.validaApellido(valid.acentos(palabra: txtfld_FirstSurname.text!)) {
                self.lbl_FirstSurname.text = ""
                txtfld_FirstSurname.errorMessage = nil
                validacion = true
            }else if txtfld_FirstSurname.text! == "" {
                self.lbl_FirstSurname.text = "El apellido paterno \("validations.emptyFieldLbO".localized)"
                txtfld_FirstSurname.errorMessage = nil
                validacion = false
            }else {
                validateTextFieldWithText(text: txtfld_FirstSurname.text, tf: txtfld_FirstSurname, nameTF: "firstSurname".localized)
                self.lbl_FirstSurname.text = "El apellido paterno \("validations.lettersAndSpaces".localized)"
                validacion = false
            }
            
        case 3:
            
            if valid.validaApellido(valid.acentos(palabra: txtfld_SecondSurname.text!)) {
                self.lbl_SecondSurname.text = ""
                txtfld_SecondSurname.errorMessage = nil
                validacion = true
            }else if txtfld_SecondSurname.text! == "" {
                self.lbl_SecondSurname.text = "El apellido materno \("validations.emptyFieldLbO".localized)"
                txtfld_SecondSurname.errorMessage = nil
                validacion = false
            }else {
                validateTextFieldWithText(text: txtfld_SecondSurname.text, tf: txtfld_SecondSurname, nameTF: "secondSurname".localized)
                self.lbl_SecondSurname.text = "El apellido materno \("validations.lettersAndSpaces".localized)"
                validacion = false
            }
            
        case 4:
            
            if valid.validaTelefono(txtfld_Cellphone.text!) {
                self.lbl_Cellphone.text = ""
                txtfld_Cellphone.errorMessage = nil
                validacion = true
            }else if txtfld_Cellphone.text! == "" {
                self.lbl_Cellphone.text = "El teléfono \("validations.emptyFieldLbO".localized)"
                txtfld_Cellphone.errorMessage = nil
                validacion = false
            }else {
                validateTextFieldWithText(text: txtfld_Cellphone.text, tf: txtfld_Cellphone, nameTF: "cellphone".localized)
                self.lbl_Cellphone.text = "El teléfono \("validations.phone".localized)"
                validacion = false
            }
            
        case 5:
            
            if valid.validaCorreo(txtfld_Email.text!) {
                self.lbl_Email.text = ""
                txtfld_Email.errorMessage = nil
                validacion = true
            }else if txtfld_Email.text! == "" {
                self.lbl_Email.text = "El correo electrónico \("validations.emptyFieldLbO".localized)"
                txtfld_Email.errorMessage = nil
                validacion = false
            }else {
                validateTextFieldWithText(text: txtfld_Email.text, tf: txtfld_Email, nameTF: "email".localized)
                self.lbl_Email.text = "El correo electrónico \("validations.email".localized)"
                validacion = false
            }
            
        default:
            validacion = false
        }
        return validacion
    }
    
    @IBAction func Registry(_ sender: UIButton) {
        view.endEditing(true)
        
        for a in 1...5{
            _ = validaCampo(Int16(a),false)
        }//revisar repetición
        
        for a in 1...5{
            if(validaCampo(Int16(a),false) == false){
                _ = valid.alertError("alert.requiredFields".localized)
                break
            }
            if(validaCampo(Int16(a),false) == true && a == 5){
                let wait = load.loading("Guardando")
                formUser = [["name": txtfld_Name.text!, "firstSurname": txtfld_FirstSurname.text!, "secondSurname": txtfld_SecondSurname.text!, "email": txtfld_Email.text!, "cellphone": txtfld_Cellphone.text!]]
                for entity in formUser{
                    let user = UserDataEntity(userData: entity)
                    UserDataDAO.add(delegate, user)
                }
                self.performSegue(withIdentifier: "goEnd", sender: self)
                wait.close()
                _ = self.valid.alertSuccess("alert.updateForms".localized)
            }
        }
        
    }
    
    func placeholder() {
        txtfld_Name.placeholder = "name".localized
        txtfld_FirstSurname.placeholder = "firstSurname".localized
        txtfld_SecondSurname.placeholder = "secondSurname".localized
        txtfld_Email.placeholder = "email".localized
        txtfld_Cellphone.placeholder = "cellphone".localized
    }
    
    func delegateTextField() {
        txtfld_Name.delegate = self
        txtfld_FirstSurname.delegate = self
        txtfld_SecondSurname.delegate = self
        txtfld_Email.delegate = self
        txtfld_Cellphone.delegate = self
    }
    
    @IBAction func validName(_ sender: UITextField) {
        _ = validaCampo(1,true)
    }
    
    @IBAction func validFirstSurname(_ sender: UITextField) {
        _ = validaCampo(2,true)
    }
    
    @IBAction func validSecondSurname(_ sender: UITextField) {
        _ = validaCampo(3,true)
    }
    
    @IBAction func validCellphone(_ sender: UITextField) {
        _ = validaCampo(4,true)
    }
    
    @IBAction func validEmail(_ sender: UITextField) {
        _ = validaCampo(5,true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        //        tf_Name.resignFirstResponder()
        return true
    }
    
    // Método que oculta el teclado cuando se toca en cualquier lugar de la vista.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func tapGestureHandler() {
        view.endEditing(true)
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
