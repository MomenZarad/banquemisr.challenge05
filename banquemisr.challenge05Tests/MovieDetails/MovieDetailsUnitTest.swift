//
//  MovieDetailsUnitTest.swift
//  banquemisr.challenge05Tests
//
//  Created by Momen Zarad on 19/03/2024.
//

import XCTest
import Combine
@testable import banquemisr_challenge05

final class MovieDetailsUnitTest: XCTestCase {
    var router: MovieDetailsRouter!
    var usecase: MovieDetailsUsecaseSpy!
    var viewModel: MovieDetailsViewModelType!
    var cancellable = Set<AnyCancellable>()
    override func setUp() {
        super.setUp()
        router = MovieDetailsRouter()
        usecase = MovieDetailsUsecaseSpy()
        viewModel = MovieDetailsViewModel(usecase: usecase, router: router, movieID: 0)
    }
    
    override func tearDown() {
        router = nil
        usecase = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchMovieDetailsSuccess() {
        //Given
        usecase.movieDetailsToBeReturned = getMockMovieDetails()
        let expectation = expectation(description: "get movie details")
        var results: MovieDetailsEntity?
        viewModel.movieDetailsPublisher
            .sink { details in
                results = details
                expectation.fulfill()
            }.store(in: &cancellable)
        
        //When
        viewModel.viewDidLoad()
        //Then
        wait(for: [expectation], timeout: 3)
        XCTAssertNotNil(results)
    }
    
    func testFetchStoredMovieDetailsSuccess() {
        //Given
        usecase.storedMovieDetailsToBeReturned = getMockMovieDetails()
        let expectation = expectation(description: "get stored movie details")
        var results: MovieDetailsEntity?
        viewModel.movieDetailsPublisher
            .sink { details in
                results = details
                expectation.fulfill()
            }.store(in: &cancellable)
        
        //When
        viewModel.viewDidLoad()
        //Then
        wait(for: [expectation], timeout: 3)
        XCTAssertNotNil(results)
    }
}

private extension MovieDetailsUnitTest {
    func getMockMovieDetails() -> MovieDetailsEntity {
        return MovieDetailsEntity(movieTitle: "Harry Potter",
                                  movieReleaseDate: "16-11-2001",
                                  moviePosterImage: "https://www.google.com",
                                  movieGenres: "Adventure, Fantasy",
                                  movieOverview: "Harry Potter has lived under the stairs at his aunt and uncle's house his whole life. But on his 11th birthday, he learns he's a powerful wizard—with a place waiting for him at the Hogwarts School of Witchcraft and Wizardry. As he learns to harness his newfound powers with the help of the school's kindly headmaster, Harry uncovers the truth about his parents' deaths—and about the villain who's to blame.",
                                  movieRunTime: 150)
    }
}
