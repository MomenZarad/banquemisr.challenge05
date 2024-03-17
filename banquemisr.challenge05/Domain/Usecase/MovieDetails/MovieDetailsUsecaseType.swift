//
//  MovieDetailsUsecaseType.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 17/03/2024.
//

import Foundation

protocol MovieDetailsUsecaseType {
    func getMovieDetails(id: Int) async throws -> MovieDetailsEntity
    func getStoredMovieDetails(id: Int) -> MovieDetailsEntity?
}
