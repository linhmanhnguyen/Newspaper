//
//  RegisterViewController.swift
//  NewspaperDemoApp
//
//  Created by Nguyễn Mạnh Linh on 17/07/2023.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCustomBackgroundColor(red: 32, green: 82, blue: 84, alpha: 1.0)
        
        let cornerRadius: CGFloat = 50.0 // Độ cong muốn áp dụng (có thể điều chỉnh)
        registerView.layer.cornerRadius = cornerRadius
        
    }

}
