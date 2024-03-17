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
                    currentPage = currentPage + 1
                    let movieResponse = try await usecase.getMovieList(params: ["page" : currentPage])
                    movies.append(contentsOf: movieResponse.movies)
                    totalPages = movieResponse.totalPages
                }
            } catch let error {
                print(error)
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
    
    func getMoviesCount() -> Int {
        return movies.count
    }
    
    func getMoviesItem(at index: Int) -> MoviesEntity {
        return movies[index]
    }
}

