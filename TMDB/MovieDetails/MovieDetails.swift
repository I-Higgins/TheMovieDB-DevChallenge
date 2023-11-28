//
//  MovieDetails.swift
//  TMDB
//
//  Created by Isaac Higgins on 27/11/23.
//

import UIKit

class MovieDetails: UIViewController {
    
    // MARK: - Variables
    static let identifier = "MovieDetails"
    var movieData = MovieData()
    var voteDistance: CGFloat = 0
    
    
    // MARK: UI Components
    private let upperImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "questionmark")
        imageView.tintColor = .label
        return imageView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "questionmark")
        imageView.tintColor = .label
        imageView.layer.cornerCurve = .continuous
        imageView.layer.maskedCorners = CACornerMask.layerMaxXMinYCorner
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let posterImage: UIView = {
        let posterView = UIView()
        posterView.backgroundColor = .systemBackground
        posterView.layer.cornerCurve = .continuous
        posterView.layer.maskedCorners = CACornerMask.layerMaxXMinYCorner
        posterView.layer.cornerRadius = 35
        posterView.clipsToBounds = true
        return posterView
    }()
    
    private let star: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        
        let symbol = UIImageView(image: UIImage(named: "Component 2"))
//        symbol.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 28.18439, height: 26.9037))
        
        view.addSubview(symbol)
        symbol.translatesAutoresizingMaskIntoConstraints = false
        
        symbol.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        symbol.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        let font = UIFont(name: "Inter", size: 16)!
        let boldFont = UIFont(descriptor: font.fontDescriptor.withSymbolicTraits(.traitBold)!, size: font.pointSize)
        label.font = boldFont
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
    
    private let GenreLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(_colorLiteralRed: 0.58, green: 0.58, blue: 0.58, alpha: 1.0)
        label.textAlignment = .left
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Inter", size: 12)!)
        label.text = "Error"
        return label
    }()
    
    private var genreArray: [UILabel] = {
        var array: [UILabel] = []
        for _ in 1...6 {
            let label = UILabel()
            label.textColor = .black
            label.textAlignment = .left
            label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Inter", size: 12)!)
            label.textColor = UIColor(_colorLiteralRed: 0.58, green: 0.58, blue: 0.58, alpha: 1.0)
            label.text = ""
            label.textAlignment = .left
            array.append(label)
        }
        return array
    }()
    
    private let userRatingPercentage: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.textAlignment = .left
        let font = UIFont(name: "Inter", size: 20)!
        let boldFont = UIFont(descriptor: font.fontDescriptor.withSymbolicTraits(.traitBold)!, size: font.pointSize)
        label.font = boldFont
        label.text = "Error"
        
        let percentSymbol = UILabel()
        percentSymbol.text = "%"
        let percentFont = UIFont(name: "Inter", size: 12)!
        let percentBoldFont = UIFont(descriptor: percentFont.fontDescriptor.withSymbolicTraits(.traitBold)!, size: percentFont.pointSize)
        percentSymbol.font = percentBoldFont
        label.addSubview(percentSymbol)
        percentSymbol.translatesAutoresizingMaskIntoConstraints = false
        percentSymbol.topAnchor.constraint(equalTo: label.topAnchor).isActive = true
        percentSymbol.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 1).isActive = true
        
        return label
    }()
    
    private let userRating: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.textAlignment = .left
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Inter", size: 12)!)
        label.text = "user score"
        return label
    }()
    
    private let ratingBar: UIView = {
        let rect = UIView()
        rect.backgroundColor = UIColor(_colorLiteralRed: 0.82, green: 0.82, blue: 0.82, alpha: 1.0)
        return rect
    }()
    
    private let ratingBarGreen: UIView = {
        let rect = UIView()
        rect.backgroundColor = UIColor(_colorLiteralRed: 0.3, green: 0.67, blue: 0.29, alpha: 1.0)
        return rect
    }()
    
    private let rateItMyself: UIView = {
        let overallView = UIView()
        
        let rate = UILabel()
        rate.text = "Rate it myself >"
        rate.textColor = .white
        rate.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Inter", size: 16)!)
        
        let brownBackground = UIView()
        brownBackground.backgroundColor = UIColor(red: 0.67, green: 0.5, blue: 0.25, alpha: 1.0)
        brownBackground.layer.cornerCurve = .continuous
        brownBackground.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        brownBackground.layer.cornerRadius = 10
        brownBackground.clipsToBounds = true
        
        
        let add = UILabel()
        add.text = "add personal rating"
        add.textColor = UIColor(red: 0.84, green: 0.73, blue: 0.56, alpha: 1.0)
        add.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Inter", size: 12)!)
        
        let blackBackground = UIView()
        blackBackground.backgroundColor = .black
        blackBackground.layer.cornerCurve = .continuous
        blackBackground.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        blackBackground.layer.cornerRadius = 10
        blackBackground.clipsToBounds = true
        
        overallView.addSubview(brownBackground)
        overallView.addSubview(blackBackground)
        overallView.addSubview(rate)
        overallView.addSubview(add)
        
        brownBackground.translatesAutoresizingMaskIntoConstraints = false
        blackBackground.translatesAutoresizingMaskIntoConstraints = false
        rate.translatesAutoresizingMaskIntoConstraints = false
        add.translatesAutoresizingMaskIntoConstraints = false
        
        brownBackground.topAnchor.constraint(equalTo: overallView.topAnchor).isActive = true
        brownBackground.leadingAnchor.constraint(equalTo: overallView.leadingAnchor).isActive = true
        brownBackground.trailingAnchor.constraint(equalTo: overallView.trailingAnchor).isActive = true
        brownBackground.bottomAnchor.constraint(equalTo: overallView.topAnchor, constant: 27).isActive = true
        
        blackBackground.topAnchor.constraint(equalTo: brownBackground.bottomAnchor).isActive = true
        blackBackground.leadingAnchor.constraint(equalTo: overallView.leadingAnchor).isActive = true
        blackBackground.trailingAnchor.constraint(equalTo: overallView.trailingAnchor).isActive = true
        blackBackground.bottomAnchor.constraint(equalTo: blackBackground.topAnchor, constant: 29).isActive = true
        
        rate.centerXAnchor.constraint(equalTo: brownBackground.centerXAnchor).isActive = true
        rate.centerYAnchor.constraint(equalTo: brownBackground.centerYAnchor).isActive = true
        
        add.centerXAnchor.constraint(equalTo: blackBackground.centerXAnchor).isActive = true
        add.centerYAnchor.constraint(equalTo: blackBackground.centerYAnchor).isActive = true
        
        return overallView
    }()
    
    private let viewFavs: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 0.95, blue: 0.83, alpha: 1.0)
        view.layer.cornerRadius = 28
        view.clipsToBounds = true
        
        let label = UILabel()
        label.text = "View Favs"
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Inter", size: 16)!)
        label.textColor = UIColor(red: 0.73, green: 0.55, blue: 0.12, alpha: 1.0)
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()
    
    private let overviewTitle: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        let font = UIFont(name: "Inter", size: 16)!
        let boldFont = UIFont(descriptor: font.fontDescriptor.withSymbolicTraits(.traitBold)!, size: font.pointSize)
        label.font = boldFont
        return label
    }()
    
    private let overviewText: UILabel = {
        let label = UILabel()
        label.text = "Error"
        label.font = UIFont(name: "Inter", size: 16)!
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    public func configure(movieData: MovieData) {
        self.movieData = movieData
        self.upperImage.image = movieData.getBackDropImage()
        self.imageView.image = movieData.getPosterImage()
        self.titleLabel.text = movieData.movieInfo.title
        self.releaseYearLabel.text = movieData.movieInfo.getReleaseYear()
        for (index, genreID) in movieData.movieInfo.genre_ids!.enumerated() {
            let text = GenreDictionary[genreID]
            self.genreArray[index].text = text
        }
        self.userRatingPercentage.text = movieData.movieInfo.getVotePercentage()
        self.voteDistance = CGFloat(movieData.movieInfo.vote_average!)*13
        self.overviewText.text = movieData.movieInfo.overview
    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(upperImage)
        self.posterImage.addSubview(imageView)
        self.view.addSubview(posterImage)
        self.view.addSubview(star)
        self.view.addSubview(titleLabel)
        self.view.addSubview(releaseYearLabel)
        genreArray.forEach { genreID in
            self.view.addSubview(genreID)
            genreID.translatesAutoresizingMaskIntoConstraints = false
        }
        self.view.addSubview(userRatingPercentage)
        self.view.addSubview(userRating)
        self.view.addSubview(ratingBar)
        self.view.addSubview(ratingBarGreen)
        self.view.addSubview(rateItMyself)
        self.view.addSubview(viewFavs)
        self.view.addSubview(overviewTitle)
        self.view.addSubview(overviewText)
        
        self.upperImage.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.posterImage.translatesAutoresizingMaskIntoConstraints = false
        self.star.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.releaseYearLabel.translatesAutoresizingMaskIntoConstraints = false
        self.userRatingPercentage.translatesAutoresizingMaskIntoConstraints = false
        self.userRating.translatesAutoresizingMaskIntoConstraints = false
        self.ratingBar.translatesAutoresizingMaskIntoConstraints = false
        self.ratingBarGreen.translatesAutoresizingMaskIntoConstraints = false
        self.rateItMyself.translatesAutoresizingMaskIntoConstraints = false
        self.viewFavs.translatesAutoresizingMaskIntoConstraints = false
        self.overviewTitle.translatesAutoresizingMaskIntoConstraints = false
        self.overviewText.translatesAutoresizingMaskIntoConstraints = false
        
        self.upperImage.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.upperImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.upperImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.upperImage.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: 243).isActive = true
        
        self.posterImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 194).isActive = true
        self.posterImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        self.posterImage.trailingAnchor.constraint(equalTo: self.posterImage.leadingAnchor, constant: 130).isActive = true
        self.posterImage.bottomAnchor.constraint(equalTo: self.posterImage.topAnchor, constant: 172).isActive = true
        
        self.imageView.topAnchor.constraint(equalTo: self.posterImage.topAnchor, constant: 5).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.posterImage.leadingAnchor, constant: 5).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.imageView.leadingAnchor, constant: 120).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.imageView.topAnchor, constant: 162).isActive = true
        
        self.star.topAnchor.constraint(equalTo: self.imageView.topAnchor, constant: -38).isActive = true
        self.star.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: -4).isActive = true
        self.star.trailingAnchor.constraint(equalTo: self.star.leadingAnchor, constant: 48).isActive = true
        self.star.bottomAnchor.constraint(equalTo: self.star.topAnchor, constant: 48).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: self.upperImage.bottomAnchor, constant: 6).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 20).isActive = true
        
        self.releaseYearLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
        self.releaseYearLabel.leadingAnchor.constraint(equalTo: self.posterImage.trailingAnchor, constant: 15).isActive = true
        
        for (index, genreID) in genreArray.enumerated() {
            genreID.topAnchor.constraint(equalTo: self.releaseYearLabel.bottomAnchor).isActive = true
            if (index == 0) {
                genreID.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 20).isActive = true
            } else {
                genreID.leadingAnchor.constraint(equalTo: self.genreArray[index - 1].trailingAnchor, constant: 8).isActive = true
            }
        }
        
        
        //Going from Down -> Up
        self.ratingBar.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -4).isActive = true
        self.ratingBar.topAnchor.constraint(equalTo: self.ratingBar.bottomAnchor, constant: -4).isActive = true
        self.ratingBar.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 19).isActive = true
        self.ratingBar.trailingAnchor.constraint(equalTo: self.ratingBar.leadingAnchor, constant: 130).isActive = true
        
        self.ratingBarGreen.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -4).isActive = true
        self.ratingBarGreen.topAnchor.constraint(equalTo: self.ratingBarGreen.bottomAnchor, constant: -4).isActive = true
        self.ratingBarGreen.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 19).isActive = true
        self.ratingBarGreen.trailingAnchor.constraint(equalTo: self.ratingBarGreen.leadingAnchor, constant: voteDistance).isActive = true
        
        self.userRatingPercentage.bottomAnchor.constraint(equalTo: self.ratingBar.topAnchor, constant: -3).isActive = true
        self.userRatingPercentage.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 20).isActive = true
        
        self.userRating.topAnchor.constraint(equalTo: self.userRatingPercentage.topAnchor, constant: 4).isActive = true
        self.userRating.leadingAnchor.constraint(equalTo: self.userRatingPercentage.trailingAnchor, constant: 17).isActive = true
        
    
        //Back to Top -> Down
        self.rateItMyself.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 27).isActive = true
        self.rateItMyself.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 37).isActive = true
        self.rateItMyself.trailingAnchor.constraint(equalTo: self.rateItMyself.leadingAnchor, constant: 150).isActive = true
        self.rateItMyself.bottomAnchor.constraint(equalTo: self.rateItMyself.topAnchor, constant: 56).isActive = true
        
        self.viewFavs.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 26).isActive = true
        self.viewFavs.leadingAnchor.constraint(equalTo: self.rateItMyself.trailingAnchor, constant: 10).isActive = true
        self.viewFavs.trailingAnchor.constraint(equalTo: self.viewFavs.leadingAnchor, constant: 145).isActive = true
        self.viewFavs.bottomAnchor.constraint(equalTo: self.viewFavs.topAnchor, constant: 56).isActive = true
        
        self.overviewTitle.topAnchor.constraint(equalTo: self.rateItMyself.bottomAnchor, constant: 33).isActive = true
        self.overviewTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 37).isActive = true
        
        self.overviewText.topAnchor.constraint(equalTo: self.overviewTitle.bottomAnchor, constant: 14).isActive = true
        self.overviewText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 37).isActive = true
        self.overviewText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -37).isActive = true
//        self.overviewText.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -37).isActive = true
    }
}
