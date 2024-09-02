//
//  DetailConfigurator.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 02.09.24.
//

import Foundation

protocol DetailConfiguratorInputProtocol {
    func configure(withView view: DetailViewController, and superhero: Superhero)
}

class DetailConfigurator: DetailConfiguratorInputProtocol {
    func configure(withView view: DetailViewController, and superhero: Superhero) {
        let presenter = DetailPresenter(view: view)
        let interactor = DetailInteractor(presenter: presenter, superhero: superhero)
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
