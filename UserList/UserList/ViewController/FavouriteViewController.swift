//
//  FavouriteViewController.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 28/8/2023.
//

import UIKit

final class FavouriteViewController: UIViewController {
    @IBOutlet weak var favouriteTableView: UITableView!
    private var reusableTableView: ReusebleTableView!

    private var favourites = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFavouriteList()
        customizeView()
    }
    
    private func customizeView() {
        favouriteTableView.hideVerticalIndicator()
    }
    
    // TODO: Update when fetch data
    private func initFavouriteList(){
        let users = [User(image: "defaultAva", name: "Username", link: "github.com"),
                     User(image: "defaultAva", name: "Username", link: "github.com"),]
        
        _ = users.map { favourites.append($0) }
    }
}

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteTableView.dequeueReusableCell(UserTableViewCell.self)
        cell.config(thisUser: favourites[indexPath.row])
        return cell
    }
}
