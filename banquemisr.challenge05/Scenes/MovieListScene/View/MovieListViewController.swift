//
//  MovieListViewController.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 14/03/2024.
//

import UIKit
import Combine

enum MovieType {
    case nowPlaying
    case popular
    case upcoming
}

class MovieListViewController: UIViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: MovieListViewModelType
    private var type: MovieType
    init(viewModel: MovieListViewModelType, type: MovieType) {
        self.viewModel = viewModel
        self.type = type
        super.init(nibName: "MovieListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViewModelBinding()
        viewModel.fetchMovieList(type: type)
    }
}

// MARK: UI configurations
private extension MovieListViewController {
    func setupUI() {
        self.navigationController?.navigationBar.isHidden = true
        setupCollectionView()
    }
    
    func setupCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(MovieCollectionViewCell.self)
    }
}

// MARK: ViewModel Handler
private extension MovieListViewController {
    func setupViewModelBinding() {
        viewModel.movieListPublisher
            .receive(on: DispatchQueue.main)
            .sink{[weak self] error in
                guard let self else {return}
                self.movieCollectionView.reloadData()
            }.store(in: &cancellables)
    }
}

// MARK: Collection view handler
extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMoviesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell: MovieCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        movieCell.configMovieCell(model: viewModel.getMoviesItem(at: indexPath.row))
        return movieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getMoviesCount() - 4 {
            viewModel.fetchMovieList(type: type)
        }
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = MovieDetailsViewController()
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 250)
    }
}
