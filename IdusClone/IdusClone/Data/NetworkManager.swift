//
//  NetworkManager.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/05.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case parsingError
    case unknownError
}

final class NetworkManager {
    func fetchData(_ id: String, completionHandler: @escaping (Result<[ResultDTO], NetworkError>) -> Void)  {
        guard let url = URL(string: "http://itunes.apple.com/lookup?id=\(id)") else {
            fatalError("Invalid URL")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
            
                if let responseDTO = try? decoder.decode(ResponseDTO.self, from: data) {
                    completionHandler(.success(responseDTO.results))
                } else {
                    print(String(data: data, encoding: .utf8)!)
                    completionHandler(.failure(.parsingError))
                }
            }
        }
        task.resume()
    }
    
    func fetchData(_ id: String) async throws -> [ResultDTO] {
        return try await withCheckedThrowingContinuation { continuation in
            fetchData(id) { result in
                continuation.resume(with: result)
            }
        }
    }
}
