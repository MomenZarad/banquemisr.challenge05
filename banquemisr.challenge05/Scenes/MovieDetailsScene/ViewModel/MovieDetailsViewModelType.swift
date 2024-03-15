//
//  MovieDetailsViewModelType.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation
import Combine

typealias MovieDetailsViewModelType = MovieDetailsViewModelInput & MovieDetailsViewModelOutput

protocol MovieDetailsViewModelInput {
    func viewDidLoad()
}

protocol MovieDetailsViewModelOutput {
    var movieDetailsPublisher: AnyPublisher<MovieDetailsEntity, Never> { get }
}
