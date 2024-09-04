//
//  CollectionViewCell.swift
//  Heroes
//
//  Created by Alexey Efimov on 22.10.2021.
//

import UIKit

protocol CellModelRepresentable {
    var viewModel: SuperheroCellViewModelProtocol? { get }
}

final class CollectionViewCell: UICollectionViewCell, CellModelRepresentable {
    var viewModel: SuperheroCellViewModelProtocol? {
        didSet {
            updateView()
        }
    }
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 15
        }
    }
    
    private func updateView() {
        guard let viewModel = viewModel as? SuperheroCellViewModel else { return }
        mainLabel.text = viewModel.title
        if let data = viewModel.imageData {
            imageView.image = UIImage(data: data)
        }
    }
}
