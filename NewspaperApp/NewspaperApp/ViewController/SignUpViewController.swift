//
//  SignUpViewController.swift
//  NewspaperApp
//
//  Created by Nguyễn Mạnh Linh on 27/07/2023.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var SignUpView: UIView!
    @IBOutlet weak var txtPassword2: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackgroundColor(red: 32, green: 82, blue: 84, alpha: 1.0)
        SignUpView.layer.cornerRadius = 50
        
        btnSignUp.backgroundColor = UIColor(red: 32/255, green: 82/255, blue: 84/255, alpha: 1.0)
        btnSignUp.layer.cornerRadius = 10
        
        self.txtFullName.delegate = self
        self.txtEmail.delegate = self
        self.txtPassword.delegate = self
        self.txtPassword2.delegate = self
    }
    
    @IBAction func btnGoToLoginScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Lỗi", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func showSuccess() {
        let alert = UIAlertController(title: "Thành công", message: "Đăng ký tài khoản thành công!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func checkAndUpdateButtonState() {
        let isFullNameInvalid = !(SignUpView.viewWithTag(100)?.isHidden ?? true)
        let isEmailInvalid = !(SignUpView.viewWithTag(101)?.isHidden ?? true)
        let isPasswordInvalid = !(SignUpView.viewWithTag(102)?.isHidden ?? true)
        let isPassword2Invalid = !(SignUpView.viewWithTag(103)?.isHidden ?? true)
        
        let isButtonEnabled = !(isFullNameInvalid || isEmailInvalid || isPasswordInvalid || isPassword2Invalid)
        btnSignUp.isEnabled = isButtonEnabled
        btnSignUp.backgroundColor = isButtonEnabled ? UIColor(red: 32/255, green: 82/255, blue: 84/255, alpha: 1.0) : UIColor.gray
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == txtFullName {
            if isFullNameValid() {
                if let lblFullnameInvalid = SignUpView.viewWithTag(100) as? UILabel{
                    lblFullnameInvalid.isHidden = true
                }
            }else {
                SignUpView.addInvalidLabel(text: "Họ tên không hợp lệ", for: txtFullName, tag: 100)
            }
        }
        if textField == txtEmail {
            if isEmailInvalid() {
                if let lblEmailInvalid = SignUpView.viewWithTag(101) as? UILabel{
                    lblEmailInvalid.isHidden = true
                }
            }else {
                SignUpView.addInvalidLabel(text: "Email không hợp lệ", for: txtEmail, tag: 101)
            }
        }
        if textField == txtPassword {
            if !isPasswordInvalid() {
                if let lblPasswordInvalid = SignUpView.viewWithTag(102) as? UILabel{
                    lblPasswordInvalid.isHidden = true
                }
            }else {
                SignUpView.addInvalidLabel(text: "Mật khẩu không hợp lệ", for: txtPassword, tag: 102)
            }
        }
        if textField == txtPassword2 {
            if isPassword2Invalid() {
                if let lblPassword2Invalid = SignUpView.viewWithTag(103) as? UILabel{
                    lblPassword2Invalid.isHidden = true
                }
            }else{
                SignUpView.addInvalidLabel(text: "Mật khẩu không khớp", for: txtPassword2, tag: 103)
            }
        }
        checkAndUpdateButtonState()
    }
    
    func isFullNameValid() -> Bool {
        let fullNameRegex = "^[A-Za-zÀ-ÖØ-öø-ÿ'-]+( [A-Za-zÀ-ÖØ-öø-ÿ'-]+)*$"
        let fullNamePredicate = NSPredicate(format: "SELF MATCHES %@", fullNameRegex)
        if !fullNamePredicate.evaluate(with: txtFullName.text) {
            return false
        }
        return true
    }
    
    func isEmailInvalid() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: txtEmail.text) {
            return false
        }
        return true
    }
    func isPasswordInvalid() -> Bool {
        if txtPassword.text!.count > 5 {
            return false
        }
        return true
    }
    func isPassword2Invalid() -> Bool {
        if txtPassword2.text! == txtPassword.text! {
            return true
        }
        return false
    }
    
    func callAPISignUp(fullName: String, email: String, password: String){
        let fullName = txtFullName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let apiHandler = APIHandler()
        apiHandler.registerAccount(fullName: fullName, email: email, password: password) { success in
            if success {
                self.showSuccess()
            } else {
                self.showError("Đăng ký tài khoản thất bại.")
            }
        }
    }
    
    @IBAction func btnRegisterConfirm(_ sender: UIButton) {
        guard let fullName = txtFullName.text?.trimmingCharacters(in: .whitespacesAndNewlines), !fullName.isEmpty,
              let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty,
              let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines), !password.isEmpty,
              let password2 = txtPassword2.text?.trimmingCharacters(in: .whitespacesAndNewlines), !password2.isEmpty else {
            showError("Vui lòng điền đầy đủ thông tin.")
            return
        }
        
        callAPISignUp(fullName: fullName, email: email, password: password)
    }
}


