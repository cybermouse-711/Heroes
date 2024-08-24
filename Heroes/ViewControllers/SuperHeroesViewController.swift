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

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSuperheroes()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        superheroes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "superhero", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell()}
        let superhero = superheroes[indexPath.row]
        cell.configure(with: superhero)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let superhero = superheroes[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: superhero)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        detailVC.superhero = sender as? Superhero
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
