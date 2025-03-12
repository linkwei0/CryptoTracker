//
//  Endpoint.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var params: [String: Any]? { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    var base: String {
        return "https://data.messari.io/api/v1"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = (components.path as NSString).appendingPathComponent(path)
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        guard let params = params, method != .get else { return request }
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        request.httpBody = jsonData
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
