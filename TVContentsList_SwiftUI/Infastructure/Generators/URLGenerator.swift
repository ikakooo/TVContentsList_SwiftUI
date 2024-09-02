//
//  URLGenerator.swift
//  TVContentsList_SwiftUI
//
//  Created by Irakli Chkhitunidze on 9/2/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case patch = "PATCH"
}

struct URLGenerator {
    var httpMethod: HTTPMethod?
    var baseUrl: String
    var path: String
    var headerParameters: [String: String]?
    var bodyParameters: Data? // json
    var urlQueryParameters: [String: String] = [:]
    var credentials: String?
    
    // MARK: - URLs

    func requestURL() -> URLRequest? {
        var request: URLRequest
        guard let requestURLWithQuery = requestURLWithQuery() else { return nil}
        
        request = URLRequest(url: requestURLWithQuery)
        request.allHTTPHeaderFields = headerParameters
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 15
        
        if let credentials {
            request.addValue("Bearer \(credentials)", forHTTPHeaderField: "Authorization")
        }
        
        if let httpMethod { request.httpMethod = httpMethod.rawValue }
        if let bodyParameters { request.httpBody = bodyParameters }
        
        return request
    }
    
    private func fullURL()-> URL?{
        URL(string: baseUrl + path)
    }
    
    private func requestURLWithQuery() -> URL? {
        guard let fullURL = fullURL() else { return nil}
        
        var urlComponents = URLComponents(url: fullURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = urlQueryParameters.map { item in URLQueryItem(name: item.key, value: item.value) }

      
        return urlComponents?.url
    }
    
}

struct BodyEncoder {
   var model: Codable
    
   func getBodyData()-> Data? {
        let jsonEncoder = JSONEncoder()
        return try? jsonEncoder.encode(model)
    }
}
