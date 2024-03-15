//
//  APIRouter.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation

enum APIRouter {
    
    case nowPlaying(params: [String: Any])
    case popular(params: [String: Any])
    case upcoming(params: [String: Any])
    case movieDetails(id: Int)
    
    var path: String {
        switch self {
        case .nowPlaying(_):
            return "now_playing"
        case .popular:
            return "popular"
        case .upcoming:
            return "upcoming"
        case .movieDetails(let id):
            return "\(id)"
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
        case .nowPlaying(let params):
            return params
        case .popular(let params):
            return params
        case .upcoming(let params):
            return params
        default:
            return nil
        }
    }
}
