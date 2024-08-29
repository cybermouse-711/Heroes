//
//  DetailViewController.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 25.08.24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailImage: UIImageView! {
        didSet {
            detailImage.layer.cornerRadius = 30
        }
    }
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    var viewModel: DetailViewModelProtocol!
    
    var superhero: Superhero!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func toggleFavorite() {
        viewModel.favoriteButtonPressed()
    }
    
    private func setupUI() {
        setStatusForFavoriteButton(viewModel.isFavorite)
        
        viewModel.viewModelDidChange = { [unowned self]  viewModel in
            setStatusForFavoriteButton(viewModel.isFavorite)
        }
        
        titleLabel.text = viewModel.title
        firstLabel.text = "FullName: \(viewModel.firstText)"
        secondLabel.text = "Race: \(viewModel.secondText)"
        detailImage.image = UIImage(data: viewModel.imageData ?? Data())
    }
    
    private func setStatusForFavoriteButton(_ status: Bool) {
        favoriteButton.tintColor = status ? .red : .gray
    }
}
