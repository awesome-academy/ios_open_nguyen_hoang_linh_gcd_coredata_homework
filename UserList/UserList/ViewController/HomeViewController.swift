//
//  ViewController.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 25/8/2023.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var userTableView: UITableView!
    
    private var reusableTableView: ReusebleTableView!
    private var users = [User]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initUserList()
        customizeView()
    }
    
    private func customizeView(){
        searchBar.customizeSearchBar()
        userTableView.hideVerticalIndicator()
    }
    
    // TODO: Update when fetch data
    private func initUserList() {
        let usersData = [User(image: "defaultAva", name: "Username", link: "github.com"),
                         User(image: "defaultAva", name: "Username", link: "github.com"),
                         User(image: "defaultAva", name: "Username", link: "github.com"),
                         User(image: "defaultAva", name: "Username", link: "github.com"),
                         User(image: "defaultAva", name: "Username", link: "github.com")]
        
        _ = usersData.map { users.append($0) }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(UserTableViewCell.self)
        cell.config(thisUser: users[indexPath.row])
        return cell
    }
}


