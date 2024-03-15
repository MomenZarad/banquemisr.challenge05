//
//  APIRouter.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation

enum APIRouter {
    
    var path: String {
        switch self {
        default:
            return ""
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    var params: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
}
