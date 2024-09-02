//
//  RestAPIResult.swift
//  TVContentsList_SwiftUI
//
//  Created by Irakli Chkhitunidze on 9/2/24.
//

import Foundation

import Foundation

struct RestAPIResult< T: Codable> {
    var id = UUID()
    var statusCode: Int? = nil
    var decodedData: T? = nil
    
    mutating func decodeData(data: Data, response: URLResponse)-> RestAPIResult<T>?{
        
        statusCode = (response as? HTTPURLResponse)?.statusCode ?? 600
        decodedData =  try? JSONDecoder().decode(T?.self, from: data )
        
        return self
    }///  po String(data: data, encoding: .utf8)
    
}

extension RestAPIResult: Equatable {
    static func == (lhs: RestAPIResult<T>, rhs: RestAPIResult<T>) -> Bool {
        return lhs.id == rhs.id
    }
}
