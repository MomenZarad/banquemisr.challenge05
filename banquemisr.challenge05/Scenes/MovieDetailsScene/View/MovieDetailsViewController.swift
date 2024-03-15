//
//  MovieDetailsViewController.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 14/03/2024.
//

import UIKit
import Combine

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieImageView: ImageDownloader!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: MovieDetailsViewModelType
    init(viewModel: MovieDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: "MovieDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelBinding()
        viewModel.viewDidLoad()
    }
}

// MARK: View & ViewModel Binding
private extension MovieDetailsViewController {
    func setupViewModelBinding() {
        viewModel.movieDetailsPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] entity in
                self?.setupUI(details: entity)
            }.store(in: &cancellables)
    }
    
    func setupUI(details: MovieDetailsEntity) {
        movieImageView.loadImage(urlString: Constants.imageBase + details.moviePosterImage)
        titleLabel.text = details.movieTitle
        genreLabel.text = details.movieGenres
        overviewLabel.text = details.movieOverview
        runtimeLabel.text = details.movieRunTime.convertToReadableTime()
    }
}
