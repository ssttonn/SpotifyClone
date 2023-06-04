//
//  ProfileViewController.swift
//  SpotifyClone
//
//  Created by sstonn on 21/05/2023.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {

    private let profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect.zero
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    private var profileData: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground

        view.addSubview(profileTableView)

        fetchUserProfile()

        profileTableView.dataSource = self
        profileTableView.delegate = self
    }

    private func fetchUserProfile() {
        ApiCallers.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userProfile):
                    self?.profileData.append(userProfile.id)
                    self?.profileData.append(userProfile.displayName)
                    self?.profileData.append(userProfile.email)
                    self?.profileData.append(userProfile.product)
                    self?.createTableViewHeader(urlString: userProfile.images.first?.url)
                    self?.profileTableView.reloadData()
                    break
                case .failure(let error):
                    break
                }
            }
        }
    }

    private func createTableViewHeader(urlString: String?){
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width/1.5))

        let imageSize: CGFloat = headerView.frame.width/2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: url, completed: nil)
        imageView.layer.cornerRadius = imageSize/2
        imageView.layer.masksToBounds = true

        headerView.addSubview(imageView)
        profileTableView.tableHeaderView = headerView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileTableView.frame = view.bounds
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileData.count
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell? else {
            return UITableViewCell()
        }
        let data = profileData[indexPath.row]
        cell.textLabel?.text = data
        return cell
    }
}
