//
//  State.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 19/03/2024.
//

import Foundation

enum State {
    case loading
    case loaded
    case failure(String)
    
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    var error: String? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
}
