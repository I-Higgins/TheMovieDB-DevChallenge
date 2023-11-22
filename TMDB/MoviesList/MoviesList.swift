//
//  MoviesList.swift
//  TMDB
//
//  Created by Isaac Higgins on 21/11/23.
//

import UIKit

class MoviesList: UIViewController, UISearchBarDelegate {
    
    // MARK: - Variables
    var listOfMovies = [MovieData]()
    
    // MARK: UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MoviesListCell.self, forCellReuseIdentifier: MoviesListCell.identifier)
        return tableView
    }()
    lazy var searchBar: UISearchBar = UISearchBar()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        
        
        
        
        
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        
        let navBarAppearance = {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            navigationBarAppearance.backgroundColor = UIColor(named: "BrightGreen")
            return navigationBarAppearance
        }()
        
        view.backgroundColor = UIColor(named: "BrightGreen")
        let regFont = UIFont(name: "Jomhuria-Regular", size: 20)!
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: regFont]
        self.navigationController?.navigationBar.tintColor = UIColor(named: "BrightGreen")
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "BrightGreen")
        self.navigationItem.title = "Popular Right now"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.compactAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.compactScrollEdgeAppearance = navBarAppearance
        self.setupUI()
        apiCall()
    }
    
    @objc func apiCall() {
        let moviesRequest = PopularMoviesRequest()
        moviesRequest.RetrieveMovies() { result in
            switch result {
            case .success(let movies):
                self.listOfMovies = movies.map { MovieData(posterImage: Data(), movieInfo: $0) }
                DispatchQueue.main.async(execute: { self.tableView.reloadData() })
                let moviesRequest = PopularMoviesRequest()
                self.listOfMovies.forEach() { movieInfo in
                    moviesRequest.RetrieveMoviePoster(posterPath: movieInfo.movieInfo.poster_path ?? "") { result in
                        switch result {
                        case .success(let imageData):
                            DispatchQueue.main.async {
                                if let index = self.listOfMovies.firstIndex(where: {$0.movieInfo.title == movieInfo.movieInfo.title})
                                {
                                    self.listOfMovies[index].posterImage = imageData
                                }
                            }
                            DispatchQueue.main.async(execute: { self.tableView.reloadData() })
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    // MARK: Setup UI
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
//    {
//
//    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])
    }
}

extension MoviesList: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesListCell.identifier, for: indexPath) as? MoviesListCell else {
            fatalError("The TableView could not dequeue a MovieListCell in MoviesList")
        }
        let movieInfo = self.listOfMovies[indexPath.row]
        cell.configure(with: movieInfo)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.systemBackground
        return cell
    }
}
