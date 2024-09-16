//
//  ProgressBarView.swift
//  swifty-companion
//
//  Created by Timothée BRANDT on 16/09/2024.
//

import SwiftUI

struct ProgressBarView: View {
    @State private var containerWidth: CGFloat = 0
    
    var color: Color
    var level: Double
    var levelCompletion: Double
    var isRounded: Bool
    
    var maxWidth: Double {
        return min(containerWidth / 100 * levelCompletion, containerWidth)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { geo in
                Color.clear
                    .preference(key: WidthPreferenceKey.self, value: geo.size.width)
            }
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
            
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .frame(width: maxWidth)
            
            HStack {
                Text("Level \(levelTxt)")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                
                Spacer()
                
                Text("\(levelCompletionTxt)%")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 30)
        .frame(width: isRounded ? 250 : nil)
        .shadow(color: color.opacity(0.3), radius: 5, x: 0, y: 3)
        .onPreferenceChange(WidthPreferenceKey.self) { width in
            containerWidth = width
        }
    }
    
    var levelTxt: String {
        isRounded ? String(format: "%.0f", level) : String(format: "%.2f", level)
    }
    
    var levelCompletionTxt: String {
        String(format: "%.0f", levelCompletion)
    }
}

struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ProgressBarView(color: .purple, level: 10, levelCompletion: 20, isRounded: false)
            ProgressBarView(color: .blue, level: 5.75, levelCompletion: 57.5, isRounded: true)
            ProgressBarView(color: .green, level: 8.33, levelCompletion: 83.3, isRounded: false)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
