//
//  TVContentCategoryItemView.swift
//  TVContentsList_SwiftUI
//
//  Created by Irakli Chkhitunidze on 9/2/24.
//


import SwiftUI

struct TVContentCategoryItemView: View {
    
    var video: VideoModel
    @Binding var isLandscape: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(Bool.random() ? .movie5 : .movie6)
                .resizable()
                .frame(width: (isLandscape ? UIScreen.main.bounds.height : UIScreen.main.bounds.width) * 0.3, height: (isLandscape ? UIScreen.main.bounds.height : UIScreen.main.bounds.width) * 0.45)
                .clipShape(.rect(topLeadingRadius: 15, bottomLeadingRadius: 15, bottomTrailingRadius: 15, topTrailingRadius: 15))
                .padding(.bottom)
            
            Text(video.title ?? "   ")
                .font(.headline)
                .lineLimit(2...2)
        }
    }
}


#Preview {
    TVContentView()
}
