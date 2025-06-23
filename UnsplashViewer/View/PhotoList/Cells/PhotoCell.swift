//
//  PhotoCell.swift
//  UnsplashViewer
//
//  Created by Даниил Павленко on 22.06.2025.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    //MARK: - Properties
    static let reuseIdentifier = "PhotoCell"
    
    //MARK: - Methods
    func configure(with photo: Photo) {
        descriptionLabel.text = photo.displayDescription
        descriptionLabel.textColor = UIColor(hex: photo.color)
        likesLabel.text = "\(photo.likes)"
        imageView.kf.setImage(with: URL(string: photo.urls.thumb))
    }
}
