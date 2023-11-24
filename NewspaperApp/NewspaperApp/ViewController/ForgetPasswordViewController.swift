//
//  ForgetPasswordViewController.swift
//  NewspaperApp
//
//  Created by Nguyễn Mạnh Linh on 28/07/2023.
//

import UIKit

class ForgetPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnConfirmFP: UIButton!
    @IBOutlet weak var ForgetPasswordView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackgroundColor(red: 32, green: 82, blue: 84, alpha: 1.0)
        ForgetPasswordView.layer.cornerRadius = 50
        
        btnConfirmFP.backgroundColor = UIColor(red: 32/255, green: 82/255, blue: 84/255, alpha: 1.0)
        btnConfirmFP.layer.cornerRadius = 10
        
        self.txtEmail.delegate = self
    }
    
    func showError(_ message: String){
        let alert = UIAlertController(title: "Lỗi", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showSuccess(){
        let alert = UIAlertController(title: "Thành công", message: "Mật khẩu mới đã được gửi trong Gmail", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func isEmailInvalid() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: txtEmail.text){
            return false
        }
        return true
    }
    
    func checkAndUpdateButtonState(){
        let isEmailInvalid = !(ForgetPasswordView.viewWithTag(100)?.isHidden ?? true)
        
        let isButtonEnabled = !isEmailInvalid
        
        btnConfirmFP.isEnabled = isButtonEnabled
        btnConfirmFP.backgroundColor = isButtonEnabled ? UIColor(red: 32/255, green: 82/255, blue: 84/255, alpha: 1.0) : UIColor.gray
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == txtEmail {
            if isEmailInvalid(){
                if let lblEmailInvalid = ForgetPasswordView.viewWithTag(100) as? UILabel {
                    lblEmailInvalid.isHidden = true
                }
            }else {
                ForgetPasswordView.addInvalidLabel(text: "Email không hợp lệ", for: txtEmail, tag: 100)
            }
        }
        checkAndUpdateButtonState()
    }
    
    func callAPIForgotPassword(email: String){
        let apiHandler = APIHandler()
        apiHandler.forgotPassword(email: email) { success in
            if success {
                self.showSuccess()
            } else {
                self.showError("Quên mật khẩu thất bại")
            }
        }
    }
    
    @IBAction func btnFPConfirm(_ sender: UIButton) {
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else{
            showError("Vui lòng điền đầy đủ thông tin")
            return
        }
        
        callAPIForgotPassword(email: email)
        
        let changePasswordScreen = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVCIdentifier") as! ChangePasswordViewController
        self.navigationController?.pushViewController(changePasswordScreen, animated: true)
    }
}
