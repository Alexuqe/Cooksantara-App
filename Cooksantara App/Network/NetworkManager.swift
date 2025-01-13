//
//  NetworkManager.swift
//  Cooksantara App
//
//  Created by Sasha on 12.01.25.
//


import Foundation

enum Links {
    case receipt

    var url: URL {
        switch self {
            case .receipt:
                return URL(string: "https://dummyjson.com/recipes")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


final class NetworkManager {

    static let shared = NetworkManager()

    private init() {}




}
