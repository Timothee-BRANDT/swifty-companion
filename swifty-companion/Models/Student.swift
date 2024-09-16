//
//  Student.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 12/09/2024.
//

import Foundation

struct User: Codable {
    var login: String
    var image: Image
    var location: String?
    var projects_users: [Project]
}

struct Progress: Codable {
    var grade: String?
    var level: Double
    var skills: [Skill]
}

struct Image: Codable {
    var link: String?
}

struct Skill: Codable, Identifiable {
    var id: Int
    var name: String
    var level: Double
}

struct Project: Codable, Identifiable {
    var id: Int
    var final_mark: Int?
    var status: String
    var project: ProjectName
    var cursus_ids: [Int]
    var marked_at: String?
}

struct ProjectName: Codable {
    var name: String
}

