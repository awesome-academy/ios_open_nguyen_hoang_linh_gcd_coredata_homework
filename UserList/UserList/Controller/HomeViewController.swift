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
    @IBOutlet private weak var favouriteButton: UIButton!
    
    private var reusableTableView: ReusebleTableView!
    private var users = [User]()
    private var tapIndex: Int?
    private var searchUsers = [User]()
    private var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        getUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func customizeView() {
        searchBar.customizeSearchBar()
        userTableView.hideVerticalIndicator()
        userTableView.keyboardDismissMode = .onDrag
    }
    
    private func getUsers() {
        let queue = DispatchQueue(label: "myQueue", qos: .utility)
        queue.async {[unowned self] in
            APIRepository.shared.fetchUsersApi() { (itemList: [Item]) in
                _ = itemList.map { item in
                    self.users.append(User(image: item.avatar_url,
                                           name: item.login,
                                           link: item.html_url,
                                           profileLink: item.url,
                                           followersLink: item.followers_url))
                }
                self.userTableView.reloadData()
            }
        }
    }
    
    @IBAction private func favouriteButtonTapped(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "FavouriteViewController") as? FavouriteViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: UserTableViewCellDelegate, UISearchBarDelegate {
    func userButtonTapped(sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "ProfileViewController") as? ProfileViewController {
            let cell = sender.superview?.superview as! UserTableViewCell
            let cellIndex = self.userTableView.indexPath(for: cell)
            if let indexPath = cellIndex{
                vc.profileURL = users[indexPath.row].profileLink
                vc.followerURL = users[indexPath.row].followersLink
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchUsers = users.filter({ $0.name.lowercased().prefix(searchText.count) == searchText.lowercased() })
        searching = true
        userTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching { return searchUsers.count } else { return users.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(UserTableViewCell.self)
        cell.delegate = self
        searching ? cell.config(thisUser: searchUsers[indexPath.row]) : cell.config(thisUser: users[indexPath.row])
        return cell
    }
}



