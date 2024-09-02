//
//  CollectionCell.swift
//  Heroes
//
//  Created by Alexey Efimov on 22.10.2021.
//

import UIKit

protocol CellModelRepresentable {
    var viewModel: CollectionCellViewModelProtocol? { get }
}

final class CollectionCell: UICollectionViewCell, CellModelRepresentable {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 15
        }
    }
    
    var viewModel: CollectionCellViewModelProtocol? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        guard let viewModel = viewModel as? CollectionCellViewModel else { return }
        mainLabel.text = viewModel.cellTitle
        if let data = viewModel.cellImageData {
            imageView.image = UIImage(data: data)
        }
    }
}
