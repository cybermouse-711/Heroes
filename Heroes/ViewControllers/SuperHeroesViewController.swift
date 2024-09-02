//
//  SuperHeroesViewController.swift
//  Heroes
//
//  Created by Alexey Efimov on 22.10.2021.
//

import UIKit

protocol SuperHeroesViewControllerInputProtocol: AnyObject {
    func reloadData(for section: CollectionSectionViewModel)
}

protocol SuperHeroesViewControllerOutputProtocol {
    init(view: SuperHeroesViewControllerInputProtocol)
    func viewDidLoad()
    func didTapCell(at indexPath: IndexPath)
}

final class SuperHeroesViewController: UICollectionViewController {
    
    var presenter: SuperHeroesViewControllerOutputProtocol!

    private let configurator: SuperHeroesConfiguratorInputProtocol = SuperHeroesConfigurator()
    private var sectionViewModel: CollectionSectionViewModelProtocol = CollectionSectionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        let configurator: DetailConfiguratorInputProtocol = DetailConfigurator()
        guard let superhero = sender as? Superhero else { return }
        configurator.configure(withView: detailVC, and: superhero)
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sectionViewModel.numberOfCells
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = sectionViewModel.cells[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellIdentifier, for: indexPath)
        guard let cell = cell as? CollectionCell else { return UICollectionViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.didTapCell(at: indexPath)
    }
}

// MARK: - SuperHeroesViewControllerInputProtocol
extension SuperHeroesViewController: SuperHeroesViewControllerInputProtocol {
    func reloadData(for section: CollectionSectionViewModel) {
        sectionViewModel = section
        collectionView.reloadData()
    }
}
