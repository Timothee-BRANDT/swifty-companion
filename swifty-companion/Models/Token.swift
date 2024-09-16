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
    
    init(access_token: String, token_type: String, expires_in: Double, scope: String, created_at: Double) {
        self.access_token = access_token
        self.token_type = token_type
        self.scope = scope
        self.created_at = created_at
    }
}
