//
//  FavouriteViewController.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 28/8/2023.
//

import UIKit
import CoreData

var favourites = [Favourite]()

final class FavouriteViewController: UIViewController {
    @IBOutlet private weak var favouriteTableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    
    private var reusableTableView: ReusebleTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        favouriteTableView.reloadData()
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
        favouriteTableView.hideVerticalIndicator()
    }
    
    @IBAction private func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func deleteAllButtonTapped(_ sender: UIButton) {
        CoreDataManager.shared.deleteAllItems()
        favourites = []
        favouriteTableView.reloadData()
    }
}

extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
}

extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteTableView.dequeueReusableCell(UserTableViewCell.self)
        cell.configFavourite(thisUser: favourites[indexPath.row])
        return cell
    }
}
