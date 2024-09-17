//
//  StudentView.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 16/09/2024.
//

import SwiftUI

struct StudentView: View {
    @State private var orientation = UIDevice.current.orientation
    
    var user: UserAPI
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    AsyncImage(
                        url: URL(string: user.data?.image.link ?? ""),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    
                    VStack(alignment: .leading) {
                        Text(login)
                            .foregroundColor(.black)
                            .font(.title2)
                            .bold()
                        Text("Level: \(level)")
                            .foregroundColor(.purple)
                            .font(.headline)
                        Text(location)
                            .foregroundColor(.green)
                            .font(.subheadline)
                        Text(coalition)
                            .foregroundColor(.cyan)
                            .font(.subheadline)
                    }
                    .padding(.leading, 10)
                }
                .padding([.top, .leading, .trailing], 10)

                Text("Projects")
                    .font(.title2)
                    .bold()
                    .padding(.top)

                if let projects = user.data?.projects_users {
                    ForEach(projects) { project in
                        VStack(alignment: .leading) {
                            Text(project.project.name)
                                .font(.headline)
                                .foregroundColor(.blue)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text("Status: \(project.status)")
                                .font(.subheadline)
                            if let mark = project.final_mark {
                                Text("Score: \(mark)")
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                            } else {
                                Text("Score: None")
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }

                if let cursusUsers = user.data?.cursus_users {
                    ForEach(cursusUsers) { cursus in
                        if cursus.grade == nil {
                            Text("Piscine")
                                .font(.title2)
                                .bold()
                                .padding(.top)
                        } else if cursus.grade == "Member" {
                            Text("Cursus")
                                .font(.title2)
                                .bold()
                                .padding(.top)
                        }

                        if let skills = cursus.skills {
                            ForEach(skills) { skill in
                                HStack {
                                    Text(skill.name)
                                        .font(.headline)
                                    Spacer()
                                    Text(String(format: "%.2f", skill.level))
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }
                }
            }
            .onDisappear {
                resetUserData()
            }
            .padding(.horizontal, 10)
        }
        
    }
    
    var login: String {
        guard let login = user.data?.login else {
            return "Unknow"
        }
        return login
    }
    
    var location: String {
        guard let location = user.data?.location else {
            return "Somewhere in 42 campus"
        }
        return location
    }
    
    var coalition: String {
        guard let coa = user.coalition?.name else {
            return "Unknow Coalition"
        }
        return coa
    }
    
    var level: String {
        guard let cursus = user.data?.cursus_users else {
            return "0"
        }
        for cursus in cursus {
            if cursus.grade != nil {
                let level = cursus.level
                return String(format: "%.2f", level)
            }
        }
        return "0"
    }
    
    func resetUserData() {
        user.data = nil
    }
}
