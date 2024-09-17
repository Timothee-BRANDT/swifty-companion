//
//  ContentView.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 16/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var token: TokenAPI = TokenAPI()
    @StateObject private var user: UserAPI = UserAPI()
    @State var loginSelected: String = ""
    @State private var showMessage: Bool = false
    @State private var message: String = ""
    @State private var navigateToStudentView = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                TextField("Type a student login", text: $loginSelected)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onSubmit {
                        Task {
                            await performSearch()
                        }
                    }
                Button(action: {
                    Task {
                        await performSearch()
                    }
                }) {
                    Text("Search")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.title2)
                }
                .padding(.horizontal)
                
                if showMessage {
                    Text(message)
                        .foregroundColor(.red)
                        .padding()
                        .transition(.opacity)
                        .animation(.easeInOut, value: showMessage)
                        .font(.title2)
                } else {
                    Spacer()
                        .frame(height: 70)
                }
            }
            .padding()
            .navigationDestination(isPresented: $navigateToStudentView) {
                StudentView(user: user)
            }
        }
        .task {
            await token.getToken()
        }
    }
    
    private func performSearch() async {
        if !loginSelected.isEmpty {
            guard let tokenString = token.value?.access_token else {
                print("Token is not available")
                return
            }
            await user.fetchData(token: tokenString, login: loginSelected)
            
            if let userData = user.data, !userData.login.isEmpty {
                showMessage = false
                navigateToStudentView = true
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
}

 
#Preview {
    ContentView()
}
