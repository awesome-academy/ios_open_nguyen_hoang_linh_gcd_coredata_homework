//
//  StringExtension.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 29/8/2023.
//

import UIKit

extension String {
    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
}
