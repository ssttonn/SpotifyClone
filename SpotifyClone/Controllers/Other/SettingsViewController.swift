//
//  SettingsViewController.swift
//  SpotifyClone
//
//  Created by sstonn on 21/05/2023.
//

import UIKit

class SettingsViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect.zero
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    private var sections = [SettingSection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        configureSettingSections()

        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].options.count
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell? else {
            return UITableViewCell()
        }

        let option = sections[indexPath.section].options[indexPath.row]
        cell.textLabel?.text = option.title
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let option = sections[indexPath.section].options[indexPath.row]
        option.handler()
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
}

extension SettingsViewController {
    private func configureSettingSections() {
        sections.append(SettingSection(title: "Profile", options: [SettingOption(title: "View your profile", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.viewProfile()
            }
        })]))

        sections.append(SettingSection(title: "Account", options: [SettingOption(title: "Sign Out", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.signOutTapped()
            }
        })]))
    }

    private func viewProfile() {
        let vc = ProfileViewController()
        vc.title = "Profile"
        navigationController?.pushViewController(vc, animated: true)
    }

    private func signOutTapped() {
        // TODO: Sign Out
    }
}
