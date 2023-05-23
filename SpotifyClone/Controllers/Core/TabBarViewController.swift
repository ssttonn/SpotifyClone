//
//  TabBarViewController.swift
//  SpotifyClone
//
//  Created by sstonn on 21/05/2023.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let homeViewController = HomeViewController()
        let searchViewController = SearchViewController()
        let libraryViewController = LibraryViewController()
        
        homeViewController.title = "Home"
        searchViewController.title = "Search"
        libraryViewController.title = "Library"
        
        homeViewController.navigationItem.largeTitleDisplayMode = .always
        searchViewController.navigationItem.largeTitleDisplayMode = .always
        libraryViewController.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: homeViewController)
        let nav2 = UINavigationController(rootViewController: searchViewController)
        let nav3 = UINavigationController(rootViewController: libraryViewController)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
