//
//  TVContentCategoryView.swift
//  TVContentsList_SwiftUI
//
//  Created by Irakli Chkhitunidze on 9/2/24.
//

import SwiftUI

struct TVContentCategoryView: View {
    
    var category: RootContent
    @Binding var isLandscape: Bool

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                Spacer().frame(width: 0)
                    .padding(.leading)
                    .padding(.leading)
                ForEach(category.videos ?? []){ video in
                    TVContentCategoryItemView(video: video, isLandscape: $isLandscape)
                        .frame(width: isLandscape ? UIScreen.main.bounds.height * 0.3 : UIScreen.main.bounds.width * 0.3)
                    Spacer().frame(width: 0)
                        .padding(.leading)
                }
            }
            
        }.scrollClipDisabled()
    }
}

#Preview {
    TVContentView()
}
