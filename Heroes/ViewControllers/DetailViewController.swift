//
//  DetailViewController.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 25.08.24.
//

import UIKit
import Kingfisher

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
    
    var superhero: Superhero!
    
    private var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        loadFavoriteStatusButton()
        setupUI()
    }
    
    @IBAction func toggleFavorite() {
        isFavorite.toggle()
        setStatusForFavoriteButton()
        DataManager.shared.setFavoriteStatus(for: superhero.name, with: isFavorite)
    }
    
    private func setStatusForFavoriteButton() {
        favoriteButton.tintColor = isFavorite ? .red : .gray
    }
    
    private func loadFavoriteStatusButton() {
        isFavorite = DataManager.shared.getFavoriteStatus(for: superhero.name)
    }
    
    private func setupUI() {
        titleLabel.text = superhero.name
        firstLabel.text = "FullName: \(superhero.biography.fullName)"
        secondLabel.text = "Race: \(superhero.appearance.race ?? "not race")"
        
        setStatusForFavoriteButton()
    }
    
    private func fetch() {
        guard let superhero else { return }
        guard let imageURL = URL(string: superhero.images.lg) else { return }
        detailImage.kf.indicatorType = .activity
        let processor = DownsamplingImageProcessor(size: detailImage.bounds.size)
        detailImage.kf.setImage(
            with: imageURL,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        ) { result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.lastPathComponent ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
