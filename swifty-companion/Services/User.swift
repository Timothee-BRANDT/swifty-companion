//
//  User.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 16/09/2024.
//

import Foundation

class UserAPI: ObservableObject {
    @Published var data: User?
    @Published var coalition: Coalition?

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
    
    func getUserCoalition(token: String, login: String) async throws -> Coalition? {
        let baseURL = "https://api.intra.42.fr/v2/users/" + login.lowercased() + "/coalitions"
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
        let currentUserCoalition = try decoder.decode([Coalition].self, from: data)
        return currentUserCoalition[0]
    }

    @MainActor
    func fetchData (token: String, login: String) async {
        do {
            data = try await getUserInfo(token: token, login: login)
            coalition = try await getUserCoalition(token: token, login: login)
        } catch {
            print("Error: Failde to get user info")
        }
    }
}
