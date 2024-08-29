//
//  CollectionViewModel.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 28.08.24.
//

import UIKit

protocol CollectionViewModelProtocol {
    var text: String { get }
    var imageData: Data? { get }
    
    init(superhero: Superhero)
}

class CollectionViewModel: CollectionViewModelProtocol {
    var text: String {
        superhero.name
    }
    
    var imageData: Data? {
        NetworkManager.shared.fetchImageData(from: URL(string: superhero.images.sm))
    }
    
    private let superhero: Superhero
    
    required init(superhero: Superhero) {
        self.superhero = superhero
    }
}
