//
//  ProfileViewController.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 28/8/2023.
//

import UIKit

final class ProfileViewController: UIViewController{
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var loveButton: UIButton!
    @IBOutlet private weak var profileTableView: UITableView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    private var reusableTableView: ReusebleTableView!
    private var followers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        initProfileList()
    }
    
    private func customizeView() {
        userImage.circularImage()
        stackView.borderViewRadius(radius: 20)
        self.view.bringSubviewToFront(loveButton)
        loveButton.borderButtonRadius(radius: loveButton.bounds.height / 2)
        profileTableView.hideVerticalIndicator()
        segmentedControl.defaultConfiguration()
        segmentedControl.selectedConfiguration()
    }
    
    // TODO: Update when fetch data
    private func initProfileList() {
        let users = [User(image: "defaultAva", name: "Username", link: "github.com"),
                     User(image: "defaultAva", name: "Username", link: "github.com"),
                     User(image: "defaultAva", name: "Username", link: "github.com"),
                     User(image: "defaultAva", name: "Username", link: "github.com"),
                     User(image: "defaultAva", name: "Username", link: "github.com")]
        
        _ = users.map { followers.append($0) }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(UserTableViewCell.self)
        cell.config(thisUser: followers[indexPath.row])
        return cell
    }
}
