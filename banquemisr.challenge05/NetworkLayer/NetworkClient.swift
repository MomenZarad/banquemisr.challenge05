//
//  NetworkClient.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation

struct NetworkClient {
    static func performRequest<model> (model: model.Type ,router : APIRouter) async throws -> model where model: Decodable {
        try await withCheckedThrowingContinuation({ continuation in
            var urlQueryItems: [URLQueryItem] = []
            var urlComponent = URLComponents(string: Constants.baseURL + router.path)
            
            if let params = router.params {
                for (key , value) in params{
                    urlQueryItems.append(URLQueryItem(name: key, value: "\(value)"))
                }
            }
            urlComponent?.queryItems = urlQueryItems
            
            guard let url = urlComponent?.url else {
                // Error: invalid URL
                continuation.resume(throwing: ApiError.invalidURL)
                return }
            
            var request = URLRequest(url: url)
            request.setValue(ContentType.accept.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            request.setValue(ContentType.authentication.rawValue, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            request.httpMethod = request.httpMethod
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    // handle Common Network Errors
                    if let urlError = error as? URLError {
                        switch urlError.code {
                        case .notConnectedToInternet, .networkConnectionLost:
                            continuation.resume(throwing: ApiError.noInternetConnection)
                        case .timedOut:
                            continuation.resume(throwing: ApiError.requestTimeout)
                        default:
                            continuation.resume(throwing: error)
                        }
                    } else {
                        // Error: request Error
                        continuation.resume(throwing: error)
                    }
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    // Error: invalid HTTP status
                    continuation.resume(throwing: ApiError.invalidHTTPStatus)
                    return
                }
                guard let data = data else {
                    // Error: invalid Data, got nil
                    continuation.resume(throwing: ApiError.missingData)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(model.self, from: data)
                    DispatchQueue.main.async {
                        continuation.resume(returning: model)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        continuation.resume(throwing: error)
                    }
                }
            }.resume()
        })
    }
}

enum ApiError: Error {
    case noInternetConnection
    case requestTimeout
    case invalidURL
    case invalidHTTPStatus
    case missingData
}
