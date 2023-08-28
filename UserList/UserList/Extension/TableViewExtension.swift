//
//  UITableViewExtension.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 29/8/2023.
//

import UIKit

extension UITableView {
    func hideVerticalIndicator() {
        self.showsVerticalScrollIndicator = false
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type) -> T where T: ReusebleTableView {
        guard let cell =  self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
