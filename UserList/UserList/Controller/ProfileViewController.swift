//
//  ProfileViewController.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 28/8/2023.
//

import UIKit
import CoreData

final class ProfileViewController: UIViewController{
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userBioLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var followersLabel: UILabel!
    @IBOutlet private weak var followingLabel: UILabel!
    @IBOutlet private weak var repoLabel: UILabel!
    @IBOutlet private weak var loveButton: UIButton!
    @IBOutlet private weak var profileTableView: UITableView!
    @IBOutlet private weak var alertTextField: UITextField!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    private var reusableTableView: ReusebleTableView!
    private var followers = [User]()
    var profileURL: String?
    var followerURL: String?
    private var favouritesDictionary: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        if let profileURL {
            getProfileDetail(profileURL: profileURL)
        }
        if let followerURL{
            getFollowers(followerURL: followerURL)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func passDataToView(image: String,
                                name: String,
                                bio: String?,
                                follower: Int?,
                                following: Int?,
                                repo: Int?) {
        getImage(image: image)
        self.userNameLabel.text = name
        self.userBioLabel.text = bio
        if let follower {
            self.followersLabel.text = String(follower)
        }
        if let following {
            self.followingLabel.text = String(following)
        }
        if let repo {
            self.repoLabel.text = String(repo)
        }
    }
    
    private func passDataToFavourite(image: String,
                                     name: String,
                                     link: String) {
        favouritesDictionary["image"] = image
        favouritesDictionary["name"] = name
        favouritesDictionary["link"] = link
    }
    
    private func getImage(image: String) {
        let queue = DispatchQueue(label: "getImageQueue", qos: .utility)
        queue.async { [unowned self] in
            APIRepository.shared.getImageData(stringURL: image) { (data: Data) in
                self.userImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func getProfileDetail(profileURL: String) {
        let queue = DispatchQueue(label: "getProfileDetailQueue", qos: .utility)
        queue.async { [unowned self] in
            APIRepository.shared.fetchProfileApi(profileURL: profileURL) { (item: Item) in
                self.passDataToFavourite(image: item.avatar_url, name: item.login, link: item.html_url)
                self.passDataToView(image: item.avatar_url,
                                    name: item.login,
                                    bio: item.bio,
                                    follower: item.followers,
                                    following: item.following,
                                    repo: item.public_repos)
                self.profileTableView.reloadData()
            }
        }
    }
    
    private func getFollowers(followerURL: String) {
        let queue = DispatchQueue(label: "getFollowersQueue", qos: .utility)
        queue.async { [unowned self] in
            APIRepository.shared.fetchFollowersApi(followerURL: followerURL) { (itemList: [Item]) in
                _ = itemList.map { item in
                    self.followers.append(User(image: item.avatar_url,
                                               name: item.login,
                                               link: item.html_url,
                                               profileLink: item.url,
                                               followersLink: item.followers_url))
                }
                self.profileTableView.reloadData()
            }
        }
    }
    
    private func showAlertView(message: String) {
        let alertTime = DispatchTime.now() + 2
        alertTextField.text = message
        alertTextField.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: alertTime) { [weak self] in
            self?.alertTextField.isHidden = true
        }
    }
    
    private func buttonAnimation(_ sender: UIButton) {
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.systemRed.cgColor
        colorAnimation.duration = 1
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
    }
    
    @IBAction private func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func loveButtonTapped(_ sender: UIButton) {
        var isExist = false
        _ = favourites.map({ favourite in
            if favourite.name == favouritesDictionary["name"] {
                buttonAnimation(sender)
                showAlertView(message: "User already in Favourites")
                isExist = true
            }
        })
        if !isExist {
            CoreDataManager.shared.saveItem(favouriteUserInfo: favouritesDictionary)
            buttonAnimation(sender)
            showAlertView(message: "Added to Favourites")
        }
    }
    
    private func customizeView() {
        userImageView.circularImage()
        userBioLabel.numberOfLines = 2
        userBioLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        stackView.borderViewRadius(radius: 20)
        self.view.bringSubviewToFront(loveButton)
        loveButton.borderButtonRadius(radius: loveButton.bounds.height / 2)
        profileTableView.hideVerticalIndicator()
        alertTextField.setHorizontalPaddingPoints(10)
        segmentedControl.defaultConfiguration()
        segmentedControl.selectedConfiguration()
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(UserTableViewCell.self)
        cell.configUser(thisUser: followers[indexPath.row])
        return cell
    }
}
