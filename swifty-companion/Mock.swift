//
//  Mock.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 16/09/2024.
//

import SwiftUI

extension UserAPI {
    static var mockUser: UserAPI {
        let api = UserAPI()
        api.data = User(
            login: "johndoe",
            image: Image(link: "https://picsum.photos/200/300"),
            location: "Paris",
            projects_users: [
                Project(id: 1, final_mark: 125, status: "finished", project: ProjectName(name: "ft_printf"), cursus_ids: [1], marked_at: "2023-09-15"),
                Project(id: 2, final_mark: nil, status: "in_progress", project: ProjectName(name: "libft"), cursus_ids: [1], marked_at: nil)
            ],
            cursus_users: [
                Progress(grade: "Learner", level: 7.65, skills: [
                    Skill(id: 1, name: "Unix", level: 6.5),
                    Skill(id: 2, name: "Algorithms & AI", level: 5.2)
                ])
            ]
        )
        api.success = true
        return api
    }
}
