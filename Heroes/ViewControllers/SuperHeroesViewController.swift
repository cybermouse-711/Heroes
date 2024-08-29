//
//  SuperHeroesViewController.swift
//  Heroes
//
//  Created by Alexey Efimov on 22.10.2021.
//

import UIKit
import Kingfisher

final class SuperHeroesViewController: UICollectionViewController {
    
    private var superheroes: [Superhero] = []
    private let networkManager = NetworkManager.shared
    
    private var viewModel: SuperHeroesViewModelProtocol! {
        didSet {
            viewModel.fetchSuperheroes { [weak self] _ in
                self?.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SuperHeroesViewModel()
        fetchSuperheroes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        detailVC.viewModel = sender as? DetailViewModelProtocol
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "superhero", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        cell.viewModel = viewModel.getCollectionViewModel(at: indexPath)
 //       cell.configure(with: superheroes[indexPath.item])
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailViewModel = viewModel.getDetailViewModel(at: indexPath)
        performSegue(withIdentifier: "showDetail", sender: detailViewModel)
    }
    
    @IBAction func clearCache(_ sender: UIBarButtonItem) {
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache() {
            print("Done")
        }
    }
    
    private func fetchSuperheroes() {
        networkManager.fetchData { result in
            switch result {
            case .success(let superheroes):
                self.superheroes = superheroes
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
