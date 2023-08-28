//
//  UISearchBarExtension.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 29/8/2023.
//

import UIKit

extension UISearchBar {
    func customizeSearchBar() {
        self.barTintColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.isTranslucent = true
        self.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.searchTextField.backgroundColor = UIColor.white
        self.searchTextField.textColor = UIColor.gray
        self.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .search, state: .normal)
    }
}
