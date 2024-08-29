//
//  CollectionViewCell.swift
//  Heroes
//
//  Created by Alexey Efimov on 22.10.2021.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 15
        }
    }
    
    var viewModel: CollectionViewModelProtocol! {
        didSet {
            mainLabel.text = viewModel.text
            imageView.image = UIImage(data: viewModel.imageData ?? Data())
        }
    }
    
//    override class func awakeFromNib() {
//        viewModel = CollectionViewModel()
//        setupUI()
//    }
//    
//    func setupUI() {
//        mainLabel.text = viewModel.text
//        imageView.image = UIImage(data: viewModel.imageData ?? Data())
//    }
}
