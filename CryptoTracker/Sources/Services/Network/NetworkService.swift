//
//  NetworkService.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

final class NetworkService {
    private let session: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        configuration.waitsForConnectivity = false
        configuration.httpMaximumConnectionsPerHost = 10
        session = URLSession(configuration: configuration)
    }
    
    func fetch<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        startRequest(request: request, completion: completion)
    }
    
    func fetch(with request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = session.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            completion(.success(data))
        }
        task.resume()
    }
    
    // MARK: - Private methods
    private func startRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let task = session.dataTask(with: request) { data, response, _ in
            guard let response = response, let data = data else { completion(.failure(.serverError)); return }
            self.validateResponse(response: response, data: data, completion: completion)
        }
        task.resume()
    }
    
    private func validateResponse<T: Decodable>(response: URLResponse, data: Data,
                                                completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let httpResponse = response as? HTTPURLResponse else { completion(.failure(.errorInUrl)); return }
        switch httpResponse.statusCode {
        case HTTPStatusCode.okStatus:
            decode(data: data, completion: completion)
        case HTTPStatusCode.badRequest:
            completion(.failure(.clientError))
        case HTTPStatusCode.internalServerError:
            completion(.failure(.serverError))
        default:
            completion(.failure(.unknownError))
        }
    }
    
    private func decode<T: Decodable>(data: Data, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let decoder = JSONDecoder()
        let object = try? decoder.decode(T.self, from: data)
        guard let object = object else { completion(.failure(.errorDecoding)); return }
        completion(.success(object))
    }
}
