//
//  SuperHeroesRouter.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 03.09.24.
//

import Foundation
import UIKit

//Протокол для перехода по сегвею на определенную сцену
@objc protocol SuperHeroesRouterLogic {
    func routeToDetail(segue: UIStoryboardSegue?)
}

protocol SuperHeroesDataPassing {
    var dataStore: SuperHeroesDataStore? { get }
}

class SuperHeroesRouter: NSObject, SuperHeroesRouterLogic, SuperHeroesDataPassing {
    weak var viewController: SuperHeroesViewController?
    var dataStore: SuperHeroesDataStore?
    
    // MARK: Routing
    func routeToDetail(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! DetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetail(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetail(source: dataStore!, destination: &destinationDS)
            navigateToDetail(source: viewController!, destination: destinationVC)
        }
    }
    
    // MARK: Navigation
    func navigateToDetail(source: SuperHeroesViewController, destination: DetailViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    func passDataToDetail(source: SuperHeroesDataStore, destination: inout DetailDataStore) {
        guard let indexPaths = viewController?.collectionView.indexPathsForSelectedItems else { return }
        for indexPath in indexPaths {
            destination.superhero = source.superheroes[indexPath.item]
        }
    }
}
