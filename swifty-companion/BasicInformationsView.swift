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
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                AsyncImage(
                    url: URL(string: user.data?.image.link ?? ""),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                
                VStack(alignment: .leading) {
                    Text(login)
                        .foregroundColor(.mainBlue)
                        .font(.title2)
                        .bold()
                    Text("Level: \(level)")
                        .foregroundColor(.red)
                        .font(.headline)
                    Text(location)
                        .foregroundColor(.orderOrange)
                        .font(.subheadline)
                    Text(coalition)
                        .foregroundColor(.indigo)
                        .font(.subheadline)
                }
                .padding(.leading, 10)
            }
            .padding([.top, .leading, .trailing], 10)
            
            Spacer() // Ajoute de l'espace sous le header pour la liste des projets
        }
        .padding(.horizontal, 10)
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
            print("Error: No cursus data available")
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

}

//struct BasicInformationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BasicInformationsView(user: UserAPI.mockUser)
//    }
//}
