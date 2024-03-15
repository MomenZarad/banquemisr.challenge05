//
//  MovieListViewModel.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation
import Combine

final class MovieListViewModel {
    private let repo: MovieListRepoType
    private var router: MovieListRouterProtocol?
    @Published private var movies: [MoviesEntity] = []
    private var currentPage = 0
    private var totalPages = 1
    init(repo: MovieListRepoType, router: MovieListRouterProtocol) {
        self.repo = repo
        self.router = router
    }
}

extension MovieListViewModel: MovieListViewModelInput {
    func fetchMovieList(type: MovieType) {
        Task{
            do {
                if currentPage < totalPages {
                    currentPage = currentPage + 1
                    let movieResponse = try await repo.getMovieList(type: type, params: ["page" : currentPage])
                    movies.append(contentsOf: movieResponse.movies)
                    totalPages = movieResponse.totalPages
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    func didSelectMovie(at index: Int) {
        //TODO: Navigate to movie details
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
