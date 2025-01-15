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

    func fetch(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }

//    func fetch(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) -> URLSessionDataTask {
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard error != nil else {
//                completion(.failure(.decodingError))
//                return
//            }
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//            completion(.success(data))
//        }
//        task.resume()
//        return task
//    }

    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                print(error ?? "No error description")
                return }

            do {
                let dataModel = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }

            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }


}
