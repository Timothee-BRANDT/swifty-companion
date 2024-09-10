//
//  ContentView.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 12/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var token: API = API()
    @State var loginSelected: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                VStack(spacing: 50) {
                    TextField("Type a student login", text: $loginSelected)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button(action: {
                        Task {
                            if !loginSelected.isEmpty {
                                print ("search the login \(loginSelected)")
                                //await getUserInfo(loginSelected)
                            } else {
                                print("Le login ne peut pas être vide")
                            }
                        }
                    }) {
                        Text("Rechercher")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                }
                .padding()
            }
        }
        .task {
            await token.getToken()
        }
    }
}
 
#Preview {
    ContentView()
}
