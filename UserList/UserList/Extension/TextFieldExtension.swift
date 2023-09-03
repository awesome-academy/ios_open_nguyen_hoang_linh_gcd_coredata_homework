//
//  TextFieldExtension.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 4/9/2023.
//

import UIKit

extension UITextField {
    func setHorizontalPaddingPoints(_ amount:CGFloat){
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = rightPaddingView
        self.rightViewMode = .always
    }
}
