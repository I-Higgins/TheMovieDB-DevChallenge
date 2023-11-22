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
        label.font = UIFont(name: "Inter-VariableFont_slnt,wght", size: 16)
        label.text = "Error"
        return label
    }()
    
    private let releaseYearLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(_colorLiteralRed: 0.58, green: 0.58, blue: 0.58, alpha: 1.0)
        label.textAlignment = .left
        label.font = UIFont(name: "Inter-VariableFont_slnt,wght", size: 12)
        label.text = "Error"
        return label
    }()
    
    private let ratingPercentage: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Inter-VariableFont_slnt,wght", size: 12)
        label.text = "Error"
        return label
    }()
    
    private var genreArray: [UILabel] = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Inter-VariableFont_slnt,wght", size: 12)
        label.text = "Error"
        return [label]
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
        self.ratingPercentage.text = "\(String(Int((movieInfo.movieInfo.vote_average ?? 0) * 10)))% user score"
        self.genreArray = []
        movieInfo.movieInfo.genre_ids?.forEach { genreID in
            let label = UILabel()
             label.textColor = .black
             label.textAlignment = .left
             label.font = UIFont(name: "Inter-VariableFont_slnt,wght", size: 12)
             label.text = GenreDictionary[genreID]
            self.genreArray.append(label)
        }
    }
    
    private func setupUI() {
        self.contentView.addSubview(coverImage)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(releaseYearLabel)
        self.contentView.addSubview(ratingPercentage)
        
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        coverImage.layer.cornerRadius = 8
        coverImage.clipsToBounds = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseYearLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingPercentage.translatesAutoresizingMaskIntoConstraints = false
        
        
        coverImage.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor).isActive = true
        coverImage.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        coverImage.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        coverImage.heightAnchor.constraint(equalToConstant: 131).isActive = true
        coverImage.widthAnchor.constraint(equalToConstant: 85).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.coverImage.trailingAnchor, constant: 27).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor, constant: -12).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        releaseYearLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
        releaseYearLabel.leadingAnchor.constraint(equalTo: self.coverImage.trailingAnchor, constant: 27).isActive = true
        releaseYearLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor, constant: -12).isActive = true
//        releaseYearLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
//        releaseYearLabel.widthAnchor.constraint(equalToConstant: 165).isActive = true
        
        ratingPercentage.topAnchor.constraint(equalTo: self.releaseYearLabel.bottomAnchor).isActive = true
        ratingPercentage.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor, constant: -15).isActive = true
        ratingPercentage.leadingAnchor.constraint(equalTo: self.coverImage.trailingAnchor, constant: 27).isActive = true
        ratingPercentage.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor, constant: -12).isActive = true
//        ratingPercentage.heightAnchor.constraint(equalToConstant: 18).isActive = true
//        ratingPercentage.widthAnchor.constraint(equalToConstant: 165).isActive = true
        
//        for genreID in genreArray {
//            genreID.topAnchor.constraint(equalTo: self.ratingPercentage.bottomAnchor).isActive = true
//            genreID.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor, constant: -15).isActive = true
//            genreID.leadingAnchor.constraint(equalTo: self.coverImage.trailingAnchor, constant: 27).isActive = true
//        }
    }
    
    var moviesListTable: MoviesList?
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
