//
//  ExtensionInvaildLabelCSS.swift
//  NewspaperApp
//
//  Created by Nguyễn Mạnh Linh on 30/07/2023.
//

import Foundation
import UIKit

extension UIView {
    func addInvalidLabel(text: String, for textField: UITextField, tag: Int) {
        
        let existingInvalidLabel = self.viewWithTag(tag) as? UILabel
            existingInvalidLabel?.removeFromSuperview()
        
        let invalidLabel = UILabel(frame: CGRect(x: (textField.frame.minX + 7), y: (textField.frame.minY + 25), width: textField.frame.width, height: textField.frame.height))
        invalidLabel.text = text
        invalidLabel.textColor = .red
        invalidLabel.font = UIFont.systemFont(ofSize: 10)
        invalidLabel.tag = tag
        self.addSubview(invalidLabel)
    }
}
