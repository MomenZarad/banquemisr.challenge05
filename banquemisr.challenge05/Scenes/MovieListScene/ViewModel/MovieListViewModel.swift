//
//  MovieListViewModel.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation
import Combine

final class MovieListViewModel {
    private let usecase: MovieListUsecaseType
    private var router: MovieListRouterProtocol?
    @Published private var movies: [MoviesEntity] = []
    private var currentPage = 0
    private var totalPages = 1
    private let stateSubject = PassthroughSubject<State, Never>()
    init(usecase: MovieListUsecaseType, router: MovieListRouterProtocol) {
        self.usecase = usecase
        self.router = router
    }
}

extension MovieListViewModel: MovieListViewModelInput {
    func fetchMovieList() {
        Task{
            do {
                if currentPage < totalPages {
                    stateSubject.send(.loading)
                    currentPage = currentPage + 1
                    let movieResponse = try await usecase.getMovieList(params: ["page" : currentPage])
                    movies.append(contentsOf: movieResponse.movies)
                    totalPages = movieResponse.totalPages
                    stateSubject.send(.loaded)
                }
            } catch let error {
                if case let storedMovies = usecase.getStoredMovieList(), !storedMovies.isEmpty {
                    movies = storedMovies
                } else {
                    stateSubject.send(.failure(error.localizedDescription))
                }
            }
        }
    }
    
    func didSelectMovie(at index: Int) {
        router?.navigateToMovieDetails(movieID: movies[index].movieID)
    }
}

extension MovieListViewModel: MovieListViewModelOutput {
    var movieListPublisher: AnyPublisher<[MoviesEntity], Never> {
        $movies.eraseToAnyPublisher()
    }
    
    var isLoading: AnyPublisher<Bool, Never> {
        stateSubject.map(\.isLoading)
            .eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String, Never> {
        stateSubject.compactMap(\.error)
            .eraseToAnyPublisher()
    }
    
    func getMoviesCount() -> Int {
        return movies.count
    }
    
    func getMoviesItem(at index: Int) -> MoviesEntity {
        return movies[index]
    }
}

