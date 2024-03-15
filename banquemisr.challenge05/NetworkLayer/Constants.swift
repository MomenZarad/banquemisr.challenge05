//
//  Constants.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let imageBase = "https://image.tmdb.org/t/p/w200"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case acceptType = "Accept"
}

enum ContentType: String {
    case authentication = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlYzU2NDE2MmYzMmQzNDFjOTk5YmQwMTM3YTdlYmEwNCIsInN1YiI6IjY1ZjFhNTg5MDZmOTg0MDE2MjQzNDFlZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Y0A7C5PTyRxaeRUKb-_hhNjJQged1FvoCFOzmUFbogo"
    case accept = "application/json"
}
