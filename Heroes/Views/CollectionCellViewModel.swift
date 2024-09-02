//
//  CollectionCellViewModel.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 03.09.24.
//

import Foundation

protocol CollectionCellViewModelProtocol {
    var cellIdentifier: String { get }
    var cellTitle: String { get }
    var cellImageData: Data? { get }
    init(superhero: Superhero)
}

protocol CollectionSectionViewModelProtocol {
    var cells: [CollectionCellViewModelProtocol] { get }
    var numberOfCells: Int { get }
}

class CollectionCellViewModel: CollectionCellViewModelProtocol {
    var cellIdentifier: String {
        "superhero"
    }
    
    var cellTitle: String {
        superhero.name
    }
    
    var cellImageData: Data? {
        NetworkManager.shared.fetchImageData(from: URL(string: superhero.images.sm))
    }
    
    private let superhero: Superhero
    
    required init(superhero: Superhero) {
        self.superhero = superhero
    }
}

class CollectionSectionViewModel: CollectionSectionViewModelProtocol {
    var cells: [CollectionCellViewModelProtocol] = []
    
    var numberOfCells: Int {
        cells.count
    }
}
