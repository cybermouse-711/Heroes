//
//  SuperHeroesRouter.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 02.09.24.
//

import Foundation

protocol SuperHeroesRouterInputProtocol {
    init(view: SuperHeroesViewController)
    func openDetailViewController(with superhero: Superhero)
}

class SuperHeroesRouter: SuperHeroesRouterInputProtocol {
    private unowned let view: SuperHeroesViewController
    
    required init(view: SuperHeroesViewController) {
        self.view = view
    }
    
    func openDetailViewController(with superhero: Superhero) {
        view.performSegue(withIdentifier: "showDetail", sender: superhero)
    }
}

