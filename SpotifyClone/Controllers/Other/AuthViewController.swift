//
//  AuthViewController.swift
//  SpotifyClone
//
//  Created by sstonn on 21/05/2023.
//

import UIKit
import WebKit

protocol AuthViewControllerDelegate: AnyObject {
    func authViewControllerDidSignIn(_ viewController: AuthViewController)

    func authViewControllerDidFailToSignIn(_ viewController: AuthViewController)
}

class AuthViewController: UIViewController {
    weak var delegate: AuthViewControllerDelegate?

    var webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        webView.navigationDelegate = self
        print(SpotifyAuthManager.shared.getSpotifyAuthenticationLink())
        guard let url = SpotifyAuthManager.shared.getSpotifyAuthenticationLink() else {
            return
        }

        webView.load(URLRequest(url: url))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }


}

extension AuthViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value else {
            return
        }
        webView.isHidden = true
        SpotifyAuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
                if !success {
                    self?.delegate?.authViewControllerDidFailToSignIn(self!)
                    return
                }
                self?.delegate?.authViewControllerDidSignIn(self!)
            }
        }
    }
}