//
//  StudentView.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 16/09/2024.
//

import SwiftUI

struct StudentView: View {
    @State var projectsButtonSelected: Bool = true
    @State var achievementsButtonSelected: Bool = false
    @State var skillsButtonSelected: Bool = false
    @State private var orientation = UIDevice.current.orientation
    
    var user: UserAPI
    
    var body: some View {
        ZStack(alignment:.center) {
            VStack(spacing: orientation.isLandscape ? 30 : 60) {
                BasicInformationsView(user: user)
            }
        }
    }
    
    var projects: [Project] {
        var projects: [Project] = []
        guard let allProjects: [Project] = user.data?.projects_users else {
            return projects
        }
        if (allProjects.count > 1) {
            for i in 0...allProjects.count - 1 {
                if (!allProjects[i].cursus_ids.isEmpty && allProjects[i].cursus_ids[0] == 21 && allProjects[i].status == "finished") {
                    projects.append(allProjects[i])
                }
            }
        }
        return projects
    }
    
    var skills: [Skill] {
        var skills: [Skill] = []
        guard let cursus: [Progress] = user.data?.cursus_users else {
            return skills
        }
        if (cursus.count > 1) {
            for i in 0...cursus.count - 1 {
                if (cursus[i].grade != nil) {
                    skills = cursus[i].skills
                }
            }
        }
        return skills
    }
}
