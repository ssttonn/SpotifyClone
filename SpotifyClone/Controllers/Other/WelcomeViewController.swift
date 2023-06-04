//
//  WelcomeViewController.swift
//  SpotifyClone
//
//  Created by sstonn on 21/05/2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in with Spotify", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemBackground
        view.addSubview(signInButton)

        bindViews()

        configureConstraints()
    }

    private func configureConstraints() {
        let signInButtonConstraints = [
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.safeAreaInsets.bottom + 30))
        ]
        NSLayoutConstraint.activate(signInButtonConstraints)

    }

    private func bindViews() {
        signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
    }

    @objc private func didTapSignInButton() {
        let vc = AuthViewController()
        vc.delegate = self
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension WelcomeViewController: AuthViewControllerDelegate {
    func authViewControllerDidSignIn(_ viewController: AuthViewController) {
        let mainAppTabBarVC = TabBarViewController()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVC, animated: true)
    }

    func authViewControllerDidFailToSignIn(_ viewController: AuthViewController) {
        let alert = UIAlertController(title: "Oops", message: "Something went wrong when signing in", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }


}