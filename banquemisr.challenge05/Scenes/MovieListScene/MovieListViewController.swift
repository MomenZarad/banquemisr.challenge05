//
//  MovieListViewController.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 14/03/2024.
//

import UIKit

enum MovieType {
    case nowPlaying
    case popular
    case upcoming
}

class MovieListViewController: UIViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var type: MovieType
    init(type: MovieType) {
        self.type = type
        super.init(nibName: "MovieListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
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

// MARK: Collection view handler
extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell: MovieCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        return movieCell
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: Navigate to movie details
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 250)
    }
}
