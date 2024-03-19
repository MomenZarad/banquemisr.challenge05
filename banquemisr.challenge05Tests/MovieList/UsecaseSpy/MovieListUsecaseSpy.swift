//
//  MovieListUsecaseSpy.swift
//  banquemisr.challenge05Tests
//
//  Created by Momen Zarad on 19/03/2024.
//

import Foundation
@testable import banquemisr_challenge05

class MovieListUsecaseSpy: MovieListUsecaseType {
    var movieListInfoToBeReturned: ([MoviesEntity], Int)!
    var storedMoviesToBeReturned: [MoviesEntity]!
    
    func getMovieList(params: [String : Any]) async throws -> (movies: [banquemisr_challenge05.MoviesEntity], totalPages: Int) {
        guard let movieListInfoToBeReturned = movieListInfoToBeReturned else { throw ApiError.missingData }
        return movieListInfoToBeReturned
    }
    
    func getStoredMovieList() -> [banquemisr_challenge05.MoviesEntity] {
        return storedMoviesToBeReturned
    }
}
