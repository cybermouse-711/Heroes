//
//  DetailViewController.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 25.08.24.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet var detailImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    
    var superhero: Superhero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        setupUI()
    }
    
    
    private func setupUI() {
        titleLabel.text = superhero?.name
        firstLabel.text = superhero?.biography.fullName
        secondLabel.text = superhero?.appearance.race
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
