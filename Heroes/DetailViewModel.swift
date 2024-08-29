//
//  DetailViewModel.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 28.08.24.
//

import UIKit

protocol DetailViewModelProtocol {
    var imageData: Data? { get }
    var title: String { get }
    var firstText: String { get }
    var secondText: String { get }
    var isFavorite: Bool { get }
    var viewModelDidChange: ((DetailViewModelProtocol) -> Void)? { get set }
    
    init(superhero: Superhero)
    
    func favoriteButtonPressed()
}

class DetailViewModel: DetailViewModelProtocol {
    var imageData: Data? {
        NetworkManager.shared.fetchImageData(from: URL(string: superhero.images.lg))
    }
    
    var title: String {
        superhero.name
    }
    
    var firstText: String {
        "FullName: \(superhero.biography.fullName)"
    }
    
    var secondText: String {
        "Race: \(superhero.appearance.race ?? "not race")"
    }
    
    var isFavorite: Bool {
        get {
            DataManager.shared.getFavoriteStatus(for: superhero.id)
        } set {
            DataManager.shared.setFavoriteStatus(for: superhero.id, with: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var viewModelDidChange: ((DetailViewModelProtocol) -> Void)?
    
    private let superhero: Superhero
    
    required init(superhero: Superhero) {
        self.superhero = superhero
    }
    
    func favoriteButtonPressed() {
        isFavorite.toggle()
    }
}
