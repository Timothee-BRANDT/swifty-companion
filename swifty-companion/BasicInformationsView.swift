//
//  BasicInformationsView.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 16/09/2024.
//

import SwiftUI


struct BasicInformationsView: View {
    var user: UserAPI

    var body: some View {
        HStack {
                AsyncImage(
                    url: URL(string: user.data!.image.link!),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 100, maxHeight: 100)
                            .clipShape(Circle())
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
            VStack(alignment: .leading) {
                HStack(spacing: 40) {
                    VStack(alignment: .leading){
                        Text(login)
                            .foregroundColor(.mainBlue)
                            .bold()
//                            .textCase(.uppercase)
                        Text(location)
                            .foregroundColor(.mainBlue)
                            .bold()
                    }
                }
                ProgressBarView(color: .blue, level: level[0], levelCompletion: level[1], isRounded: true)
            }
        }
        .padding(.horizontal, 10)
    }
    
    var login: String {
        guard let login = user.data?.login else {
            return "Cartman"
        }
        return login
    }
    
    var location: String {
        guard let location = user.data?.location else {
            return "South Park"
        }
        return location
    }
    
    var level: [Double] {
        var currentLevelCompletion: Double = 0
        var currentLevel: Double = 0
        
        guard let cursus: [Progress] = user.data?.cursus_users else {
            print("error")
            return ([currentLevel, currentLevelCompletion])
        }
        if (cursus.count > 1) {
            for i in 0...cursus.count - 1 {
                if (cursus[i].grade != nil) {
                    currentLevelCompletion = cursus[i].level.truncatingRemainder(dividingBy: 1)
                    currentLevel = cursus[i].level - currentLevelCompletion
                }
            }
        }
        return ([currentLevel, currentLevelCompletion * 100])
    }
}

struct BasicInformationsView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInformationsView(user: UserAPI.mockUser)
    }
}
