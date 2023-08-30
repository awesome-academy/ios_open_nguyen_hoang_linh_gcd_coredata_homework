//
//  UIButtonExtension.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 29/8/2023.
//

import UIKit

extension UIButton {
    func shadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
    }

    func borderButtonRadius(radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
