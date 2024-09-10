//
//  Student.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 12/09/2024.
//

import Foundation

struct Student: Codable {
    var login: String
    var image: String?
    var location: String?
    var cursus_users: [Progression]
    var studentProjects: [Project]
}

struct Progression: Codable {
    var grade: String?
    var level: Double
    var skills: [Skill]
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
    var name: String
    var cursus_ids: [Int]
    var marked_at: String?
}
