//
//  TableViewCell.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 28/8/2023.
//

import UIKit

protocol UserTableViewCellDelegate: AnyObject{
    func userButtonTapped(sender: UIButton)
}

final class UserTableViewCell : UITableViewCell, ReusebleTableView{
    
    @IBOutlet private weak var userButton: UIButton!
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var userLink: UILabel!
    
    static var reuseIdentifier = "userTableViewCellId"
    
    weak var delegate: UserTableViewCellDelegate?
    
    override func layoutSubviews() {
        customizeView()
    }
    
    private func customizeView() {
        userImage.circularImage()
        userButton.shadow()
        userButton.borderButtonRadius(radius: 20)
        setClickableLink()
    }
    
    func config(thisUser: User) {
        setImage(image: thisUser.image)
        userName.text = thisUser.name
        userLink.text = thisUser.link
    }
    
    private func setImage(image: String) {
        APIRepository.shared.getImageData(stringURL: image) { (data: Data) in
            DispatchQueue.main.async { [weak self] in
                self?.userImage.image = UIImage(data: data)
            }
        }
    }
    
    private func setClickableLink() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UserTableViewCell.tapLink))
        userLink.isUserInteractionEnabled = true
        userLink.addGestureRecognizer(tap)
        userLink.attributedText = userLink.text?.underLined
        userLink.textColor = UIColor.systemYellow
    }
    
    @IBAction private func tapLink(sender: UITapGestureRecognizer) {
        if let url = URL(string: userLink.text ?? "") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction private func userButtonTapped(_ sender: UIButton) {
        delegate?.userButtonTapped(sender: sender)
    }
}
