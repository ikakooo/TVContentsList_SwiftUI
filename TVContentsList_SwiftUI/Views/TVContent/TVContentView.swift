//
//  TVContentView.swift
//  TVContentsList_SwiftUI
//
//  Created by Irakli Chkhitunidze on 9/2/24.
//

import SwiftUI
import Shimmer

struct TVContentView: View {
    
    @State private var restAPIService = TVContentViewServices()
    
    @ObservedObject private var orientationObserver = OrientationObserver()
    @State private var isLandscape = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                Spacer().frame(height: 20)
                LazyVStack {
                    ForEach(restAPIService.result){ category in
                        Section  {
                            TVContentCategoryView(category: category, isLandscape: $isLandscape)
                                .frame(height: !isLandscape ? UIScreen.main.bounds.height * 0.35 : UIScreen.main.bounds.width * 0.35)
                                .shimmering(
                                    active: restAPIService.loading,
                                    animation: .easeInOut(duration: 1.5).repeatForever()//.delay(1)
                                )
                        }header: {
                            HStack {
                                Text(category.name ?? "")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.leading)
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                    }
                }
            }.scrollClipDisabled()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(.silkgoTop)
                        .resizable()
                        .frame(width: 82, height: 22)
                        .padding()
                }
            }
        }
        .refreshable {
            restAPIService.getTVContent()
        }
        .onAppear{
            restAPIService.getTVContent()
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        }
        .onDisappear {
            UIDevice.current.endGeneratingDeviceOrientationNotifications()
        }
        .onChange(of: orientationObserver.orientation.isLandscape) {
            isLandscape = UIScreen.main.bounds.height < UIScreen.main.bounds.width
        }
    }
}

#Preview {
    TVContentView()
}
