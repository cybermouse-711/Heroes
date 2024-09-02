//
//  SuperHeroesPresenter.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 02.09.24.
//

import Foundation

struct SuperHeroesDataStore {
    let superheroes: [Superhero]
}

class SuperHeroesPresenter: SuperHeroesViewControllerOutputProtocol {
    var interactor: SuperHeroesInteractorInputProtocol!
    var router: SuperHeroesRouterInputProtocol!
    
    private unowned let view: SuperHeroesViewControllerInputProtocol
    private var dataStore: SuperHeroesDataStore?
    
    required init(view: SuperHeroesViewControllerInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchSuperheroes()
    }
    
    func didTapCell(at indexPath: IndexPath) {
        guard let superhero = dataStore?.superheroes[indexPath.item] else { return }
        router.openDetailViewController(with: superhero)
    }
}

// MARK: - SuperHeroesPresenterOutputProtocol
extension SuperHeroesPresenter: SuperHeroesInteractorOutputProtocol {
    func superheroesDidReceive(with dataStore: SuperHeroesDataStore) {
        self.dataStore = dataStore
        let section = CollectionSectionViewModel()
        dataStore.superheroes.forEach{ section.cells.append(CollectionCellViewModel(superhero: $0)) }
        view.reloadData(for: section)
    }
}
