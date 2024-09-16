//
//  ContentView.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 12/09/2024.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @StateObject var token: TokenAPI = TokenAPI()
    @StateObject private var user: UserAPI = UserAPI()
    @State var loginSelected: String = ""
    @State private var showMessage: Bool = false
    @State private var message: String = ""
    
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
                                guard let tokenString = token.value?.access_token else {
                                    print("Token is not available")
                                    return
                                }
                                
                                await user.fetchData(token: tokenString, login: loginSelected)
                                
                                if let userData = user.data, !userData.login.isEmpty {
                                    print(userData.login)
                                    showMessage = false
                                } else {
                                    message = "User not found"
                                    showMessage = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        showMessage = false
                                    }
                                }
                            } else {
                                message = "Login cannot be empty"
                                showMessage = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    showMessage = false
                                }
                            }
                        }
                    }) {
                        Text("Search")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    if showMessage {
                        Text(message)
                            .foregroundColor(.red)
                            .padding()
                            .transition(.opacity)
                            .animation(.easeInOut, value: showMessage)
                    } else {
                        Spacer()
                            .frame(height: 50)
                    }
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
