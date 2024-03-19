//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation
import Combine

final class MovieDetailsViewModel {
    private let usecase: MovieDetailsUsecaseType
    private var router: MovieDetailsRouterProtocol?
    private var movieID: Int
    private var moviesDetails = PassthroughSubject<MovieDetailsEntity, Never>()
    private let errorMessage = PassthroughSubject<String, Never>()
    init(usecase: MovieDetailsUsecaseType, router: MovieDetailsRouterProtocol, movieID: Int) {
        self.usecase = usecase
        self.router = router
        self.movieID = movieID
    }
}

extension MovieDetailsViewModel: MovieDetailsViewModelInput {
    func viewDidLoad() {
        Task {
            do {
                let movieDetailsResponse = try await usecase.getMovieDetails(id: movieID)
                moviesDetails.send(movieDetailsResponse)
            } catch let error {
                if let storedDetails = usecase.getStoredMovieDetails(id: movieID) {
                    moviesDetails.send(storedDetails)
                } else {
                    errorMessage.send(error.localizedDescription)
                }
            }
        }
    }
}

extension MovieDetailsViewModel: MovieDetailsViewModelOutput {
    var movieDetailsPublisher: AnyPublisher<MovieDetailsEntity, Never> {
        moviesDetails.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String, Never> {
        errorMessage.eraseToAnyPublisher()
    }
}

