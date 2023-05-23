//
//  AuthManager.swift
//  SpotifyClone
//
//  Created by sstonn on 21/05/2023.
//

import Foundation

class AuthManager{
    static let shared: AuthManager = AuthManager()
    
    var isSignedIn: Bool = false
}
