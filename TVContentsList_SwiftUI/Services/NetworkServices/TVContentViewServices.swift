//
//  TVContentViewServices.swift
//  TVContentsList_SwiftUI
//
//  Created by Irakli Chkhitunidze on 9/2/24.
//

import Foundation
import Combine
import Observation

@Observable
final class TVContentViewServices {
    
    var loading = false
    var result: [RootContent] = []
    
    private var subscriptions = Set<AnyCancellable>()
    
    
    private var session: URLSession = URLSession(configuration: .default)
    
    
    private func tvContentRequest() -> AnyPublisher<RestAPIResult<TVContentResponceModel>?, Never>{
        
        guard let request = URLGenerator(
            httpMethod: .get,
            baseUrl: restAPIBaseUrl,
            path: "/ka/load"
        ).requestURL() else { return Just(nil).eraseToAnyPublisher()}
        
        return session.dataTaskPublisher(for: request)
            .tryMap{ (data, response) in
                var dataResult = RestAPIResult<TVContentResponceModel>()
                return dataResult.decodeData(data: data, response: response)
            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
    
    
    func getTVContent(){
        loading = true
        
        tvContentRequest().sink (receiveValue: {[weak self] result  in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self?.loading = false
            }
            
            self?.result = result?.decodedData?.root ?? []
        })
        .store(in: &subscriptions)
    }
    
    
    
}
