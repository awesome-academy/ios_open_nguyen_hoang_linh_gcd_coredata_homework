//
//  FavouriteViewController.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 28/8/2023.
//

import UIKit

final class FavouriteViewController: UIViewController {
    @IBOutlet private weak var favouriteTableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    
    private var reusableTableView: ReusebleTableView!

    private var favourites = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
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
