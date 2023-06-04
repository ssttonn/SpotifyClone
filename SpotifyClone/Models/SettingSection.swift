//
// Created by sstonn on 04/06/2023.
//

import Foundation

struct SettingSection {
    let title: String
    let options: [SettingOption]
}

struct SettingOption {
    let title: String
    let handler: () -> Void
}