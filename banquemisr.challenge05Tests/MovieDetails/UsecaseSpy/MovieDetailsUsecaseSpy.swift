//
//  MovieDetailsUsecaseSpy.swift
//  banquemisr.challenge05Tests
//
//  Created by Momen Zarad on 19/03/2024.
//

import Foundation
@testable import banquemisr_challenge05

class MovieDetailsUsecaseSpy: MovieDetailsUsecaseType {
    var movieDetailsToBeReturned: MovieDetailsEntity!
    var storedMovieDetailsToBeReturned: MovieDetailsEntity?
    
    func getMovieDetails(id: Int) async throws -> banquemisr_challenge05.MovieDetailsEntity {
        guard let movieDetailsToBeReturned = movieDetailsToBeReturned else { throw ApiError.missingData }
        return movieDetailsToBeReturned
    }
    
    func getStoredMovieDetails(id: Int) -> banquemisr_challenge05.MovieDetailsEntity? {
        return storedMovieDetailsToBeReturned
    }
}
