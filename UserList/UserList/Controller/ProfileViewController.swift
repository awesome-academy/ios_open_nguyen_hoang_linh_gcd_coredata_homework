//
//  ProfileViewController.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 28/8/2023.
//

import UIKit

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
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    private var reusableTableView: ReusebleTableView!
    private var followers = [User]()
    var profileURL: String?
    var followerURL: String?
    
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
    
    private func getImage(image: String) {
        let queue = DispatchQueue(label: "myQueue", qos: .utility)
        queue.async { [unowned self] in
            APIRepository.shared.getImageData(stringURL: image) { (data: Data) in
                self.userImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func getProfileDetail(profileURL: String) {
        let queue = DispatchQueue(label: "myQueue", qos: .utility)
        queue.async { [unowned self] in
            APIRepository.shared.fetchProfileApi(profileURL: profileURL) { (item: Item) in
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
        let queue = DispatchQueue(label: "myQueue", qos: .utility)
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
    
    
    @IBAction private func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func customizeView() {
        userImageView.circularImage()
        userBioLabel.numberOfLines = 2
        userBioLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        stackView.borderViewRadius(radius: 20)
        self.view.bringSubviewToFront(loveButton)
        loveButton.borderButtonRadius(radius: loveButton.bounds.height / 2)
        profileTableView.hideVerticalIndicator()
        segmentedControl.defaultConfiguration()
        segmentedControl.selectedConfiguration()
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
