//
//  LoginViewController.swift
//  NewspaperApp
//
//  Created by Nguyễn Mạnh Linh on 26/07/2023.
//

import UIKit
import FacebookLogin
import FacebookCore

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var btnLoginFb: UIButton!
    @IBOutlet weak var LoginView: UIView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackgroundColor(red: 32, green: 82, blue: 84, alpha: 1.0)
        LoginView.layer.cornerRadius = 50
        
        btnLogin.backgroundColor = UIColor(red: 32/255, green: 82/255, blue: 84/255, alpha: 1.0)
        btnLogin.layer.cornerRadius = 10
        
        self.txtEmail.delegate = self
        self.txtPassword.delegate = self
        
        Settings.shared.appID = "585645196981146"
        Settings.shared.clientToken = "6acfe649c9d21115f04143dfb8fb72c7"
        
        
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Lỗi", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    func checkAndUpdateButtonState() {
        let isEmailInvalid = !(LoginView.viewWithTag(101)?.isHidden ?? true)
        let isPasswordInvalid = !(LoginView.viewWithTag(102)?.isHidden ?? true)
        
        let isButtonEnabled = !(isEmailInvalid || isPasswordInvalid)
        btnLogin.isEnabled = isButtonEnabled
        btnLogin.backgroundColor = isButtonEnabled ? UIColor(red: 32/255, green: 82/255, blue: 84/255, alpha: 1.0) : UIColor.gray
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == txtEmail {
            if isEmailInvalid() {
                if let lblEmailInvalid = LoginView.viewWithTag(101) as? UILabel{
                    lblEmailInvalid.isHidden = true
                }
            }else {
                LoginView.addInvalidLabel(text: "Email không hợp lệ", for: txtEmail, tag: 101)
            }
        }
        if textField == txtPassword {
            if !isPasswordInvalid() {
                if let lblPasswordInvalid = LoginView.viewWithTag(102) as? UILabel{
                    lblPasswordInvalid.isHidden = true
                }
            }else {
                LoginView.addInvalidLabel(text: "Mật khẩu không hợp lệ", for: txtPassword, tag: 102)
            }
        }
        checkAndUpdateButtonState()
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
    
    func callAPILogin(email: String, password: String) {
        let apiHandler = APIHandler()
        apiHandler.loginAccount(email: email, password: password) { (success, account) in
            if success {
                UserDefaults.standard.setValue(account, forKey: "account")
                //self.showSuccess()
            } else {
                self.showError("Tài khoản hoặc mật khẩu không chính xác")
            }
        }
    }
    
    
    @IBAction func btnToForgotPasswordScreen(_ sender: UIButton) {
        let forgetPasswordScreen = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordVCIdentifier") as! ForgetPasswordViewController
        self.navigationController?.pushViewController(forgetPasswordScreen, animated: true)
    }
    @IBAction func btnToRegisterScreen(_ sender: UIButton) {
        let signupScreen = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVCIdentifier") as! SignUpViewController
        self.navigationController?.pushViewController(signupScreen, animated: true)
    }
    @IBAction func btnLoginConfirm(_ sender: UIButton) {
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty,
              let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines), !password.isEmpty else {
            showError("Vui lòng điền đầy đủ thông tin.")
            return
        }
        callAPILogin(email: email, password: password)
        let homeScreen = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCIdentifier") as! HomeViewController
        self.navigationController?.pushViewController(homeScreen, animated: true)
    }
    func fetchFacebookUserProfile() {
        if let token = AccessToken.current, !token.isExpired {
            let request = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]) // Thêm các trường thông tin bạn muốn lấy
            request.start { (connection, result, error) in
                if let error = error {
                    print("Error fetching Facebook profile: \(error.localizedDescription)")
                } else if let result = result as? [String: Any] {
                    print("Facebook profile: \(result)")
                    if result["email"] is String {
                        // Tiếp tục xử lý thông tin email, có thể gọi API để đăng nhập hoặc đăng ký
                    }
                }
            }
        }
    }
    @IBAction func btnLoginWithFb(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Login with Facebook failed: \(error.localizedDescription)")
            } else if let result = result, !result.isCancelled {
                //self.showSuccess()
                self.fetchFacebookUserProfile()
            } else {
                print("Login with Facebook cancelled")
            }
        }
    }
    
}
