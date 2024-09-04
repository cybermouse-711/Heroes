//
//  DetailRouter.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 03.09.24.
//

import Foundation

@objc protocol DetailRouterLogic {
    
}

protocol DetailDataPassing {
    var dataStore: DetailDataStore? { get }
}

class DetailRouter: NSObject, DetailRouterLogic, DetailDataPassing {
    weak var viewController: DetailViewController?
    var dataStore: DetailDataStore?
}
