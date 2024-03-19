//
//  MovieListUnitTest.swift
//  banquemisr.challenge05Tests
//
//  Created by Momen Zarad on 19/03/2024.
//

import XCTest
import Combine
@testable import banquemisr_challenge05

final class MovieListUnitTest: XCTestCase {
    var router: MovieListRouter!
    var usecase: MovieListUsecaseSpy!
    var viewModel: MovieListViewModelType!
    var cancellable = Set<AnyCancellable>()
    override func setUp() {
        super.setUp()
        router = MovieListRouter()
        usecase = MovieListUsecaseSpy()
        viewModel = MovieListViewModel(usecase: usecase, router: router)
    }
    
    override func tearDown() {
        router = nil
        usecase = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchMoviesSuccess() {
        //Given
        usecase.movieListInfoToBeReturned = (getMockMovies(), 1)
        let expectation = expectation(description: "get all movies")
        var results: [MoviesEntity]?
        viewModel.movieListPublisher
            .dropFirst(1)
            .sink { movies in
                results = movies
                expectation.fulfill()
            }.store(in: &cancellable)
        
        //When
        viewModel.fetchMovieList()
        //Then
        wait(for: [expectation], timeout: 3)
        XCTAssertNotNil(results)
    }
    
    func testFetchStoredMoviesSuccess() {
        //Given
        usecase.storedMoviesToBeReturned = getMockMovies()
        let expectation = expectation(description: "get all stored movies")
        var results: [MoviesEntity]?
        viewModel.movieListPublisher
            .dropFirst(1)
            .sink { movies in
                results = movies
                expectation.fulfill()
            }.store(in: &cancellable)
        
        //When
        viewModel.fetchMovieList()
        //Then
        wait(for: [expectation], timeout: 3)
        XCTAssertNotNil(results)
    }
    
    func testMoviesCount() {
        // Given
        usecase.movieListInfoToBeReturned = (getMockMovies(), 1)
        let expectation = expectation(description: "get movies count")
        // When
        viewModel.fetchMovieList()
        expectation.fulfill()
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertEqual(viewModel.getMoviesCount(), 1)
    }
}

private extension MovieListUnitTest {
    func getMockMovies() -> [MoviesEntity] {
        return [MoviesEntity(movieID: 1,
                            movieTitle: "Harry Potter",
                            movieReleaseDate: "16-11-2001",
                            moviePosterImage: "https://www.google.com")]
    }
}
