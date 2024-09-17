//
//  Token.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 16/09/2024.
//

import Foundation

struct Token: Codable {
    var access_token: String
    var token_type: String
    var scope: String
    var created_at: Double
}
