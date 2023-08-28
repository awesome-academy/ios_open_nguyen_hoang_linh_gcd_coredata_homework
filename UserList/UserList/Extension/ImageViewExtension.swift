//
//  UIImageViewExtension.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 29/8/2023.
//

import UIKit

extension UIImageView {
    func circularImage() {
        layer.cornerRadius = self.bounds.height / 2
        clipsToBounds = true
    }
}
