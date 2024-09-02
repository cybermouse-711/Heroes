//
//  SuperHeroesInteractor.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 02.09.24.
//

import Foundation

protocol SuperHeroesInteractorInputProtocol {
    init(presenter: SuperHeroesInteractorOutputProtocol)
    func fetchSuperheroes()
}

protocol SuperHeroesInteractorOutputProtocol: AnyObject {
    func superheroesDidReceive(with dataStore: SuperHeroesDataStore)
}

class SuperHeroesInteractor: SuperHeroesInteractorInputProtocol {
    private unowned let presenter: SuperHeroesInteractorOutputProtocol

    required init(presenter: SuperHeroesInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchSuperheroes() {
        NetworkManager.shared.fetchData { [unowned self] result in
            switch result {
            case .success(let superheroes):
                let dataStore = SuperHeroesDataStore(superheroes: superheroes)
                presenter.superheroesDidReceive(with: dataStore)
            case .failure(let error):
                print(error)
            }
        }
    }
}
