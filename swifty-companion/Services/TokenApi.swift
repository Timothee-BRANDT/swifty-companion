//
//  TokenApi.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 16/09/2024.
//

import Foundation

private var path: String {
    get {
        guard let path = Bundle.main.path(forResource: "API_KEYS", ofType: "plist") else {
            fatalError("API_KEYS.plist not found")
        }
        return path
    }
}

private var secret: String {
    get {
        let plist = NSDictionary(contentsOfFile: path)
        guard let secret = plist?.object(forKey: "SECRET") as? String else {
            fatalError("SECERT not found")
        }
        return secret
    }
}

private var UID: String {
    get {
        let plist = NSDictionary(contentsOfFile: path)
        guard let uid = plist?.object(forKey: "UID") as? String else {
            fatalError("UID not found")
        }
        return uid
    }
}

class TokenAPI: ObservableObject {
    @Published var value: Token?

    func generateToken() async throws -> Token? {
        let url = URL(string: "https://api.intra.42.fr/oauth/token")
        let body = "grant_type=client_credentials&client_id=\(UID)&client_secret=\(secret)"
        guard let requestUrl = url else {
            return nil
        }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.httpBody = body.data(using: String.Encoding.utf8)
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode(Token.self, from: data)
    }

    @MainActor
    func getToken() async {
            do {
                value = try await generateToken()
            } catch {
                print("Token generation failed")
            }
    }
}
