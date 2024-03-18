//
//  APIError.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 18/03/2024.
//

import Foundation

enum ApiError: Error {
    case noInternetConnection
    case requestTimeout
    case invalidURL
    case invalidHTTPStatus
    case missingData
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return NSLocalizedString("No internet connection", comment: "")
        case .requestTimeout:
            return NSLocalizedString("Request timeout", comment: "")
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .invalidHTTPStatus:
            return NSLocalizedString("Invalid HTTP status", comment: "")
        case .missingData:
            return NSLocalizedString("No data found", comment: "")
        }
    }
}
