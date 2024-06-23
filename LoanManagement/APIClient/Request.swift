//
//  Request.swift
//  LoanManagement
//
//  Created by Wilbert Devin Wijaya on 21/06/24.
//

import Foundation

final class Request {
    public struct Constants {
        static let baseUrl = "https://raw.githubusercontent.com/andreascandle/p2p_json_test/main"
    }
    
    private let endpoint: Endpoint
    private let pathComponents: [String]
    
    private var urlString: String {
        var string = Constants.baseUrl
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "\($0)"
            }
        }
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    public init(endpoint: Endpoint, pathComponents: [String] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
    }
}
