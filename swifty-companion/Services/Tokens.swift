//
//  Tokens.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 12/09/2024.
//

import Foundation


private var path: String {
    get {
        guard let filePath = Bundle.main.path(forResource: "API_KEYS", ofType: "plist") else {
            fatalError("Couldn't find file 'API_KEYS.plist'.")
        }
        return filePath
    }
}

private var secret: String {
    get {
        let plist = NSDictionary(contentsOfFile: path)
        guard let secret = plist?.object(forKey: "SECRET") as? String else {
            fatalError("Couldn't find key 'SECRET' in 'API_KEYS.plist'.")
        }
        return secret
    }
}

private var UID: String {
    get {
        let plist = NSDictionary(contentsOfFile: path)
        guard let uid = plist?.object(forKey: "UID") as? String else {
            fatalError("Couldn't find key 'UID' in 'API_KEYS.plist'.")
        }
        return uid
    }
}

class API: ObservableObject {
    @Published var value: Token?
    @Published var isGenerated: Bool = false
    
    func generateToken() async throws -> Token? {
        let url = URL(string: "https://api.intra.42.fr/oauth/token")
        let body = "grant_type=client_credentials&client_id=\(UID)&client_secret=\(secret)"
        guard let requestUrl = url else {
            print("Error: URL is empty")
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
    func getToken () async {
            do {
                value = try await generateToken()
                isGenerated = true
            } catch {
                print("Error: Couldn't generate a token")
            }
    }
}
