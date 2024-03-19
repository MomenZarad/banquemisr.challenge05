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
    private let stateSubject = PassthroughSubject<State, Never>()
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
                stateSubject.send(.loading)
                let movieDetailsResponse = try await usecase.getMovieDetails(id: movieID)
                moviesDetails.send(movieDetailsResponse)
                stateSubject.send(.loaded)
            } catch let error {
                if let storedDetails = usecase.getStoredMovieDetails(id: movieID) {
                    moviesDetails.send(storedDetails)
                } else {
                    stateSubject.send(.failure(error.localizedDescription))
                }
            }
        }
    }
}

extension MovieDetailsViewModel: MovieDetailsViewModelOutput {
    var movieDetailsPublisher: AnyPublisher<MovieDetailsEntity, Never> {
        moviesDetails.eraseToAnyPublisher()
    }
    
    var isLoading: AnyPublisher<Bool, Never> {
        stateSubject.map(\.isLoading)
            .eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String, Never> {
        stateSubject.compactMap(\.error)
            .eraseToAnyPublisher()
    }
}

