//
//  BackgroundViewController.swift
//  NewspaperDemoApp
//
//  Created by Nguyễn Mạnh Linh on 17/07/2023.
//

import UIKit

class BackgroundViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCustomBackgroundColor(red: 32, green: 82, blue: 84, alpha: 1.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVCIdentifier") as! RegisterViewController
            self.navigationController?.pushViewController(registerViewController, animated: true)
        }
    }
    
}
