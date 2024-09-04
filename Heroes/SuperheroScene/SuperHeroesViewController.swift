//
//  SuperHeroesViewController.swift
//  Heroes
//
//  Created by Alexey Efimov on 22.10.2021.
//

import UIKit

protocol SuperHeroesDisplayLogic: AnyObject {
    func displaySuperHeroes(viewModel: SuperHeroes.ShowSuperHeroes.ViewModel)
}

final class SuperHeroesViewController: UICollectionViewController {
    
    var interactor: SuperHeroesBusinessLogic?
    var router: (NSObjectProtocol & SuperHeroesRouterLogic & SuperHeroesDataPassing)?
    
    private var itemCell: [SuperheroCellViewModelProtocol] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        SuperHeroesConfigurator.shared.configure(with: self)
        showSuperHeroes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    private func showSuperHeroes() {
        interactor?.fetchSuperheroes()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemCell.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = itemCell[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.identifier, for: indexPath)
        guard let cell = cell as? CollectionViewCell else { return UICollectionViewCell()}
        cell.viewModel = cellViewModel
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

    }
}

extension SuperHeroesViewController: SuperHeroesDisplayLogic {
    func displaySuperHeroes(viewModel: SuperHeroes.ShowSuperHeroes.ViewModel) {
        itemCell = viewModel.itemCell
        collectionView.reloadData()
    }
}
