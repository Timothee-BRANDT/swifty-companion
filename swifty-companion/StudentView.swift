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
            .onDisappear {
                resetUserData()
            }
        }
    }
    
    func resetUserData() {
        user.data = nil
    }
}
