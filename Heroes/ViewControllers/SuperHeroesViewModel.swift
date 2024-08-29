//
//  SuperHeroesViewModel.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 28.08.24.
//

import Foundation

protocol SuperHeroesViewModelProtocol {
    func fetchSuperheroes(completion: @escaping(Result<[Superhero], NetworkError>) -> Void)
    func numberOfRows() -> Int
    func getCollectionViewModel(at indexPath: IndexPath) -> CollectionViewModelProtocol
    func getDetailViewModel(at indexPath: IndexPath) -> DetailViewModelProtocol
}

class SuperHeroesViewModel: SuperHeroesViewModelProtocol {
    private var superheroes: [Superhero] = []
    
    func fetchSuperheroes(completion: @escaping(Result<[Superhero], NetworkError>) -> Void) {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let superheroes):
                self.superheroes = superheroes
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRows() -> Int {
        superheroes.count
    }
    
    func getCollectionViewModel(at indexPath: IndexPath) -> CollectionViewModelProtocol {
        CollectionViewModel(superhero: superheroes[indexPath.item])
    }
    
    func getDetailViewModel(at indexPath: IndexPath) -> DetailViewModelProtocol {
        DetailViewModel(superhero: superheroes[indexPath.item])
    }
}
