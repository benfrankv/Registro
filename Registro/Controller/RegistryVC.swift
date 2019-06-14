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

class RegistryVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

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
    @IBOutlet weak var nameBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstSurnameBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondSurnameBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cellphoneBottomConstraint: NSLayoutConstraint!
    
    var delegate = AppDelegate()
    var valid = Validations()
    var formUser = [[String: Any]]()
    let load = Loading()
    var imgpkr_Object = UIImagePickerController()
    var dataIMG: Data? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "registry".localized
        addTheme()
        delegateTextField()
        placeholder()
        imgpkr_Object.delegate = self
//        NotificationCenter.default.addObserver(self, selector: #selector(RegistryVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(RegistryVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//    }
    
    
    
    func addTheme() {
        applySkyscannerTheme(SkyFloatingLabelTxtfld: txtfld_Name)
        applySkyscannerTheme(SkyFloatingLabelTxtfld: txtfld_FirstSurname)
        applySkyscannerTheme(SkyFloatingLabelTxtfld: txtfld_SecondSurname)
        applySkyscannerTheme(SkyFloatingLabelTxtfld: txtfld_Email)
        applySkyscannerTheme(SkyFloatingLabelTxtfld: txtfld_Cellphone)
        
    }
    
    func applySkyscannerTheme(SkyFloatingLabelTxtfld: SkyFloatingLabelTextField) {
        SkyFloatingLabelTxtfld.tintColor = UIColor(named: "BlueFranxx")!
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
    
    enum name {
        
    }
    
    func fieldValidate(_ caso : Int16,_ alert : Bool) -> Bool{
        var validation = false
        switch caso {
         //Sólo un Idioma 
        case 1:
            
            if valid.validaNombre(valid.acentos(palabra: txtfld_Name.text!)) {
                self.lbl_Name.text = ""
                txtfld_Name.errorMessage = nil
                validation = true
            }else if txtfld_Name.text! == "" {
                self.lbl_Name.textColor = UIColor(named: "RedFranxx")!
                self.lbl_Name.text = "\("validations.thename".localized) \("validations.emptyFieldLbO".localized)"
                txtfld_Name.errorMessage = nil
                validation = false
            }else{
                validateTextFieldWithText(text: txtfld_Name.text, tf: txtfld_Name, nameTF: "name".localized)
                self.lbl_Name.textColor = UIColor(named: "RedFranxx")!
                self.lbl_Name.text = "\("validations.thename".localized) \("validations.lettersAndSpaces".localized)"
                validation = false
            }
            
        case 2:
            
            if valid.validaApellido(valid.acentos(palabra: txtfld_FirstSurname.text!)) {
                self.lbl_FirstSurname.text = ""
                txtfld_FirstSurname.errorMessage = nil
                validation = true
            }else if txtfld_FirstSurname.text! == "" {
                self.lbl_FirstSurname.text = "\("validations.thefirstSurname".localized) \("validations.emptyFieldLbO".localized)"
                txtfld_FirstSurname.errorMessage = nil
                validation = false
            }else {
                validateTextFieldWithText(text: txtfld_FirstSurname.text, tf: txtfld_FirstSurname, nameTF: "firstSurname".localized)
                self.lbl_FirstSurname.text = "\("validations.thefirstSurname".localized) \("validations.lettersAndSpaces".localized)"
                validation = false
            }
            
        case 3:
            
            if valid.validaApellido(valid.acentos(palabra: txtfld_SecondSurname.text!)) {
                self.lbl_SecondSurname.text = ""
                txtfld_SecondSurname.errorMessage = nil
                validation = true
            }else if txtfld_SecondSurname.text! == "" {
                self.lbl_SecondSurname.text = "\("validations.thesecondSurname".localized) \("validations.emptyFieldLbO".localized)"
                txtfld_SecondSurname.errorMessage = nil
                validation = false
            }else {
                validateTextFieldWithText(text: txtfld_SecondSurname.text, tf: txtfld_SecondSurname, nameTF: "secondSurname".localized)
                self.lbl_SecondSurname.text = "\("validations.thesecondSurname".localized) \("validations.lettersAndSpaces".localized)"
                validation = false
            }
            
        case 4:
            
            if valid.validaTelefono(txtfld_Cellphone.text!) {
                self.lbl_Cellphone.text = ""
                txtfld_Cellphone.errorMessage = nil
                validation = true
            }else if txtfld_Cellphone.text! == "" {
                self.lbl_Cellphone.text = "\("validations.thecellphone".localized) \("validations.emptyFieldLbO".localized)"
                txtfld_Cellphone.errorMessage = nil
                validation = false
            }else {
                validateTextFieldWithText(text: txtfld_Cellphone.text, tf: txtfld_Cellphone, nameTF: "cellphone".localized)
                self.lbl_Cellphone.text = "\("validations.thecellphone".localized) \("validations.emptyFieldLbO".localized)"
                validation = false
            }
            
        case 5:
            
            if valid.validaCorreo(txtfld_Email.text!) {
                self.lbl_Email.text = ""
                txtfld_Email.errorMessage = nil
                validation = true
            }else if txtfld_Email.text! == "" {
                self.lbl_Email.text = "\("validations.theemail".localized) \("validations.emptyFieldLbO".localized)"
                txtfld_Email.errorMessage = nil
                validation = false
            }else {
                validateTextFieldWithText(text: txtfld_Email.text, tf: txtfld_Email, nameTF: "email".localized)
                self.lbl_Email.text = "\("validations.theemail".localized) \("validations.emptyFieldLbO".localized)"
                validation = false
            }
            
        default:
            validation = false
        }
        return validation
    }
    
    @IBAction func Registry(_ sender: UIButton) {
        view.endEditing(true)
        
        for a in 1...5{
            _ = fieldValidate(Int16(a),false)
        }//revisar repetición
        
        for a in 1...5{
            if(fieldValidate(Int16(a),false) == false){
                _ = valid.alertError("alert.requiredFields".localized)
                break
            }
            if(fieldValidate(Int16(a),false) == true && a == 5){
                let wait = load.loading("Guardando")
                formUser = [["name": txtfld_Name.text!, "firstSurname": txtfld_FirstSurname.text!, "secondSurname": txtfld_SecondSurname.text!, "email": txtfld_Email.text!, "cellphone": txtfld_Cellphone.text!, "photo": dataIMG == nil ? nil : dataIMG!]]
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
    
    @IBAction func btna_PickGallery(_ sender: UIButton) {
        imgpkr_Object.sourceType = .photoLibrary
        imgpkr_Object.allowsEditing = true
        present(imgpkr_Object, animated: true, completion: nil)
    }
    
    func placeholder() {
        txtfld_Name.placeholder = "name".localized
        txtfld_FirstSurname.placeholder = "firstSurname".localized
        txtfld_SecondSurname.placeholder = "secondSurname".localized
        txtfld_Email.placeholder = "email".localized
        txtfld_Cellphone.placeholder = "cellphone".localized
        self.btn_PickGallery.setTitle("pickAImage".localized, for: .normal)
    }
    
    func delegateTextField() {
        txtfld_Name.delegate = self
        txtfld_FirstSurname.delegate = self
        txtfld_SecondSurname.delegate = self
        txtfld_Email.delegate = self
        txtfld_Cellphone.delegate = self
    }
    
    @IBAction func validName(_ sender: UITextField) {
        _ = fieldValidate(1,true)
    }
    
    @IBAction func validFirstSurname(_ sender: UITextField) {
        _ = fieldValidate(2,true)
    }
    
    @IBAction func validSecondSurname(_ sender: UITextField) {
        _ = fieldValidate(3,true)
    }
    
    @IBAction func validCellphone(_ sender: UITextField) {
        _ = fieldValidate(4,true)
    }
    
    @IBAction func validEmail(_ sender: UITextField) {
        _ = fieldValidate(5,true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            PP_Photo.image = image
            dataIMG = UIImagePNGRepresentation(image)
        }
        dismiss(animated: true, completion: nil)
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
    @objc func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(show: true, notification: notification)
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(show: false, notification: notification)
    }
    
    func adjustingHeight(show: Bool, notification:NSNotification) {
        var userInfo = notification.userInfo!
        var keyboardFrame: CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let changeInHeight = (keyboardFrame.height + 40) * (show ? 1 : -1)
        UIView.animate(withDuration: animationDuration, animations: {() -> Void in
            self.emailBottomConstraint.constant += changeInHeight
            
        })
        
    }*/

}
