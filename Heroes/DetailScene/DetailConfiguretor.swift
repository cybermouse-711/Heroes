//
//  DetailConfigurator.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 03.09.24.
//

import Foundation

final class DetailConfigurator {
    static let shared = DetailConfigurator()
    
    private init() {}
    
    func configure(with viewController: DetailViewController) {
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        router.viewController = viewController
        router.dataStore = interactor
    }
}
