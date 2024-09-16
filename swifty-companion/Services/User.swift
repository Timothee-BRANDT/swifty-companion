//
//  User.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 13/09/2024.
//

import Foundation

class UserAPI: ObservableObject {
    @Published var data: User?
    @Published var success: Bool = false
    @Published var studentNotFound: Bool = false

    func getUserInfo(token: String, login: String) async throws -> User? {
        let baseURL = "https://api.intra.42.fr/v2/users/" + login.lowercased()
        let finalURL = URL(string: baseURL)
        guard let requestUrl = finalURL else {
            print("Error: URL is empty")
            return nil
        }
        var request = URLRequest(url: requestUrl)
        request.setValue(
            "Bearer \(token)",
            forHTTPHeaderField: "Authorization"
        )
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let currentUser = try decoder.decode(User.self, from: data)
        return currentUser
    }

    @MainActor
    func fetchData (token: String, login: String) async {
        do {
            data = try await getUserInfo(token: token, login: login)
            success = true
        } catch {
            studentNotFound = true
            print("Error: Failde to get user info")
        }
    }
}
