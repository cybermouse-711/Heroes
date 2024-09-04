//
//  SuperHeroesInteractor.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 03.09.24.
//

import Foundation

protocol SuperHeroesBusinessLogic {
    func fetchSuperheroes()
}

protocol SuperHeroesDataStore {
    var superheroes: [Superhero] { get }
}

class SuperHeroesInteractor: SuperHeroesBusinessLogic, SuperHeroesDataStore {
    var superheroes: [Superhero] = []
    var presenter: SuperHeroesPresentionLogic?
    
    func fetchSuperheroes() {
        NetworkManager.shared.fetchData { [weak self] result in
            switch result {
            case .success(let superheroes):
                self?.superheroes = superheroes
                let response = SuperHeroes.ShowSuperHeroes.Response(superheroes: superheroes)
                self?.presenter?.presentDetail(response: response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
