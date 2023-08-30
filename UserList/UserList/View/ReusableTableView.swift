//
//  ReuseableTableView.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 29/8/2023.
//

import UIKit

protocol ReusebleTableView: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusebleTableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
