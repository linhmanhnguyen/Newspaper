//
//  ExtensionBackgroundColor.swift
//  NewspaperApp
//
//  Created by Nguyễn Mạnh Linh on 26/07/2023.
//

import Foundation
import UIKit

extension UIViewController {
    func setBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let backgroundColor = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
        self.view.backgroundColor = backgroundColor
    }
}
