//
//  SuperHeroesPresenter.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 03.09.24.
//

import Foundation

protocol SuperHeroesPresentionLogic {
    func presentDetail(response: SuperHeroes.ShowSuperHeroes.Response)
}

class SuperHeroesPresenter: SuperHeroesPresentionLogic {
    weak var viewController: SuperHeroesDisplayLogic?
    
    func presentDetail(response: SuperHeroes.ShowSuperHeroes.Response) {
        let itemsCell: [SuperheroCellViewModelProtocol] = response.superheroes.map {
            SuperheroCellViewModel(superhero: $0)
        }
        
        let viewModel = SuperHeroes.ShowSuperHeroes.ViewModel(itemCell: itemsCell)
        viewController?.displaySuperHeroes(viewModel: viewModel)
    }
}
