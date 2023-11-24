//
//  MovieListCell.swift
//  TMDB
//
//  Created by Isaac Higgins on 21/11/23.
//

import UIKit

class MoviesListCell: UITableViewCell {
    
    static let identifier = "MoviesListCell"
    
    private let coverImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "questionmark")
        imageView.tintColor = .label
        return imageView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Inter", size: 16)!)
        label.text = "Error"
        return label
    }()
    
    private let releaseYearLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(_colorLiteralRed: 0.58, green: 0.58, blue: 0.58, alpha: 1.0)
        label.textAlignment = .left
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Inter", size: 12)!)
        label.text = "Error"
        return label
    }()
    
    private let userRating: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Inter", size: 12)!)
        label.text = "Error"
        return label
    }()
    
    class GenreLabel: UILabel {
        override var intrinsicContentSize: CGSize {
            let originalContentSize = super.intrinsicContentSize
            if self.text == "" {
                return originalContentSize
            }
            return CGSize(width: originalContentSize.width + 14, height: originalContentSize.height + 6)
        }
    }
    
    private var genreArray: [UILabel] = {
        var array: [UILabel] = []
        for _ in 1...6 {
            let label = GenreLabel()
            label.textColor = .black
            label.textAlignment = .left
            label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Inter", size: 12)!)
            label.backgroundColor = UIColor(_colorLiteralRed: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
            label.textColor = UIColor(_colorLiteralRed: 0.58, green: 0.58, blue: 0.58, alpha: 1.0)
            label.layer.cornerRadius = 10
            label.layer.masksToBounds = true
            label.text = ""
            label.textAlignment = .center
            
            array.append(label)
        }
        return array
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with movieInfo: MovieData) {
        self.coverImage.image = movieInfo.image()
        self.titleLabel.text = movieInfo.movieInfo.title
        self.releaseYearLabel.text = String(movieInfo.movieInfo.release_date!.prefix(4))
        self.userRating.text = "\(String(Int((movieInfo.movieInfo.vote_average ?? 0) * 10)))% user score"
        for (index, genreID) in movieInfo.movieInfo.genre_ids!.enumerated() {
            let text = GenreDictionary[genreID]
            self.genreArray[index].text = text
        }
    }
    
    private func setupUI() {
        self.contentView.addSubview(coverImage)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(releaseYearLabel)
        self.contentView.addSubview(userRating)
        genreArray.forEach { genreID in
            self.contentView.addSubview(genreID)
        }
        
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseYearLabel.translatesAutoresizingMaskIntoConstraints = false
        userRating.translatesAutoresizingMaskIntoConstraints = false
        genreArray.forEach { genreID in
            genreID.translatesAutoresizingMaskIntoConstraints = false
        }
        
        coverImage.layer.cornerRadius = 8
        coverImage.clipsToBounds = true
        coverImage.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor).isActive = true
        coverImage.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        coverImage.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor, constant: 24).isActive = true
        coverImage.heightAnchor.constraint(equalToConstant: 131).isActive = true
        coverImage.widthAnchor.constraint(equalToConstant: 85).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor, constant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.coverImage.trailingAnchor, constant: 27).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor, constant: -12).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        releaseYearLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
        releaseYearLabel.leadingAnchor.constraint(equalTo: self.coverImage.trailingAnchor, constant: 27).isActive = true
        releaseYearLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor, constant: -12).isActive = true
        
        userRating.topAnchor.constraint(equalTo: self.releaseYearLabel.bottomAnchor, constant: 12).isActive = true
        userRating.leadingAnchor.constraint(equalTo: self.coverImage.trailingAnchor, constant: 27).isActive = true
        userRating.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor, constant: -12).isActive = true
        
        for (index, genreID) in genreArray.enumerated() {
            genreID.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor).isActive = true
            if (index == 0) {
                genreID.leadingAnchor.constraint(equalTo: self.coverImage.trailingAnchor, constant: 27).isActive = true
            } else {
                genreID.leadingAnchor.constraint(equalTo: self.genreArray[index - 1].trailingAnchor, constant: 10).isActive = true
            }
        }
    }
}
