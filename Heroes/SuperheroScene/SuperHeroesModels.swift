//
//  SuperHeroesModels.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 03.09.24.
//

import Foundation

typealias SuperheroCellViewModel = SuperHeroes.ShowSuperHeroes.ViewModel.SuperheroCellViewModel

protocol SuperheroCellViewModelProtocol {
    var identifier: String { get }
    var title: String { get }
    var imageData: Data? { get }
    init(superhero: Superhero)
}

enum SuperHeroes {
    
    //MARK: Use cases
    enum ShowSuperHeroes {
        struct Response {
            let superheroes: [Superhero]
        }
        
        struct ViewModel {
            struct SuperheroCellViewModel: SuperheroCellViewModelProtocol {
                var identifier: String {
                    "superhero"
                }
                
                var title: String {
                    superhero.name
                }
                
                var imageData: Data? {
                    NetworkManager.shared.fetchImageData(from: URL(string: superhero.images.sm))
                }
                
                private var superhero: Superhero
                
                init(superhero: Superhero) {
                    self.superhero = superhero
                }
            }
            
            let itemCell: [SuperheroCellViewModelProtocol]
        }
    }
}
