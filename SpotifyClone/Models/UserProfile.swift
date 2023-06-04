//
// Created by sstonn on 04/06/2023.
//

import Foundation

struct UserProfile: Codable {
    let id: String
    let displayName: String
    let country: String
    let email: String
    let images: [Image]
    let product: String

    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "display_name"
        case country
        case email
        case images
        case product
    }
}

