//
//  SuperHeroesConfigurator.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 03.09.24.
//

import Foundation

final class SuperHeroesConfigurator {
    static let shared = SuperHeroesConfigurator()
    
    private init() {}
    
    func configure(with viewController: SuperHeroesViewController) {
        let interactor = SuperHeroesInteractor()
        let presenter = SuperHeroesPresenter()
        let router = SuperHeroesRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        router.viewController = viewController
        router.dataStore = interactor
    }
}
