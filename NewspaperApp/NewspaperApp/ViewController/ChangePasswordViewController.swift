//
//  ChangePasswordViewController.swift
//  NewspaperApp
//
//  Created by Nguyễn Mạnh Linh on 29/07/2023.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ChangePasswordView: UIView!
    @IBOutlet weak var btnConfirmChangPassword: UIButton!
    
    @IBOutlet weak var txtNewPassword2: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackgroundColor(red: 32, green: 82, blue: 84, alpha: 1.0)
        ChangePasswordView.layer.cornerRadius = 50
        
        btnConfirmChangPassword.backgroundColor = UIColor(red: 32/255, green: 82/255, blue: 84/255, alpha: 1.0)
        btnConfirmChangPassword.layer.cornerRadius  = 10
        self.txtEmail.delegate = self
        self.txtOldPassword.delegate = self
        self.txtNewPassword.delegate = self
        self.txtNewPassword2.delegate = self
    }
    
    func showError(_ message: String){
        let alert = UIAlertController(title: "Lỗi", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showSuccess(){
        let alert = UIAlertController(title: "Thành công", message: "Thay đổi mật khẩu thành công", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func isEmailInvalid() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: txtEmail.text) {
            return false
        }
        return true
    }
    
    func isOldPasswordInvalid() -> Bool {
        if txtOldPassword.text!.count > 5{
            return false
        }
        return true
    }
    func isNewPasswordInvalid() -> Bool {
        if txtNewPassword.text!.count > 5{
            return false
        }
        return true
    }
    func isNewPassword2Invalid() -> Bool {
        if txtNewPassword2.text! == txtNewPassword.text! {
            return true
        }
        return false
    }
    
    func checkAndUpdateButtonState(){
        let isEmailInvalid = !(ChangePasswordView.viewWithTag(104)? .isHidden ?? true)
        let isOldPasswordInvalid = !(ChangePasswordView.viewWithTag(100)?.isHidden ?? true)
        let isNewPasswordInvalid = !(ChangePasswordView.viewWithTag(101)?.isHidden ?? true)
        let isNewPassword2Invalid = !(ChangePasswordView.viewWithTag(102)?.isHidden ?? true)
        
        let isButtonEnabled = !(isEmailInvalid || isOldPasswordInvalid || isNewPasswordInvalid || isNewPassword2Invalid)
        btnConfirmChangPassword.isEnabled = isButtonEnabled
        btnConfirmChangPassword.backgroundColor = isButtonEnabled ? UIColor(red: 32/255, green: 82/255, blue: 84/255, alpha: 1.0) : UIColor.gray
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == txtEmail {
            if isEmailInvalid() {
                if let lblEmailInvalid = ChangePasswordView.viewWithTag(104) as? UILabel {
                    lblEmailInvalid.isHidden = true
                }
            }else {
                ChangePasswordView.addInvalidLabel(text: "Email không hợp lệ", for: txtEmail, tag: 104)
            }
        }
        if textField == txtOldPassword {
            if !isOldPasswordInvalid() {
                if let lblPasswordInvalid = ChangePasswordView.viewWithTag(100) as? UILabel {
                    lblPasswordInvalid.isHidden = true
                }
            }else{
                ChangePasswordView.addInvalidLabel(text: "Mật khẩu không hợp lệ", for: txtOldPassword, tag: 100)
            }
        }
        if textField == txtNewPassword {
            if !isNewPasswordInvalid() {
                if let lblPasswordInvalid = ChangePasswordView.viewWithTag(101) as? UILabel {
                    lblPasswordInvalid.isHidden = true
                }
            }else{
                ChangePasswordView.addInvalidLabel(text: "Mật khẩu không hợp lệ", for: txtNewPassword, tag: 101)
            }
        }
        if textField == txtNewPassword2 {
            if isNewPassword2Invalid() {
                if let lblPasswordInvalid = ChangePasswordView.viewWithTag(102) as? UILabel {
                    lblPasswordInvalid.isHidden = true
                }
            }else{
                ChangePasswordView.addInvalidLabel(text: "Mật khẩu không khớp", for: txtNewPassword2, tag: 102)
            }
        }
        checkAndUpdateButtonState()
    }
    func callAPIChangePassword(email: String, oldPassword: String, newPassword: String){
        let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let oldPassword = txtOldPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let newPassword = txtNewPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let apiHandler = APIHandler()
        apiHandler.changePasswordAccount(email: email, oldPassword: oldPassword, newPassword: newPassword) { success in
            if success {
                self.showSuccess()
            }else {
                self.showError("Đổi mật khẩu thất bại")
                print(email)
                print(oldPassword)
                print(newPassword)
            }
        }
    }

    
    @IBAction func btnChangePwConfirm(_ sender: UIButton) {
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty,
              let oldPassword = txtOldPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines), !oldPassword.isEmpty,
              let newPassword = txtNewPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines), !newPassword.isEmpty,
              let newPassword2 = txtNewPassword2.text?.trimmingCharacters(in: .whitespacesAndNewlines), !newPassword2.isEmpty else{
                  showError("Vui lòng điền đầy đủ thông tin")
                    return
              }
        
        callAPIChangePassword(email: email, oldPassword: oldPassword, newPassword: newPassword)
    }
}
