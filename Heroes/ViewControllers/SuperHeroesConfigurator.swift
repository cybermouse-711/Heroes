//
//  SuperHeroesConfigurator.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 02.09.24.
//

import Foundation

protocol SuperHeroesConfiguratorInputProtocol {
    func configure(with view: SuperHeroesViewController)
}

class SuperHeroesConfigurator: SuperHeroesConfiguratorInputProtocol {
    func configure(with view: SuperHeroesViewController) {
        let presenter = SuperHeroesPresenter(view: view)
        let interactor = SuperHeroesInteractor(presenter: presenter)
        let router = SuperHeroesRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
