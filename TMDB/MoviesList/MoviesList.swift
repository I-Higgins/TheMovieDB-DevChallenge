//
//  MoviesList.swift
//  TMDB
//
//  Created by Isaac Higgins on 21/11/23.
//

import UIKit

class MoviesList: UIViewController {
    
    // MARK: - Variables
    var filteredListOfMovies = [MovieData]()
    var listOfMovies = [MovieData]()
    
    // MARK: UI Components
    private let upperView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BrightGreen")
        return view
    }()
    
    private let searchBar: UISearchBar = {
        let searchBarTextField = UISearchBar()
        searchBarTextField.placeholder = "Search"
        searchBarTextField.backgroundColor = .systemBackground
        searchBarTextField.tintColor = .black
        searchBarTextField.isEnabled = true
        searchBarTextField.layer.cornerRadius = 30
        searchBarTextField.layer.masksToBounds = true
        searchBarTextField.searchTextField.leftViewMode = .never
        searchBarTextField.searchTextField.backgroundColor = .systemBackground
        searchBarTextField.searchTextField.textColor = .black
        searchBarTextField.searchTextField.tintColor = .black
        searchBarTextField.searchTextPositionAdjustment = UIOffset(horizontal: -7, vertical: 0)
        searchBarTextField.searchTextField.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Inter", size: 16)!)
        return searchBarTextField
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor(named: "GreenFont")
        title.textAlignment = .left
        title.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Jomhuria", size: 60)!)
        title.text = "Popular Right now"
        return title
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MoviesListCell.self, forCellReuseIdentifier: MoviesListCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        self.setupUI()
        apiCall()
    }
    
    @objc func apiCall() {
        let moviesRequest = PopularMoviesRequest()
        moviesRequest.RetrieveMovies() { result in
            switch result {
            case .success(let movies):
                self.listOfMovies = movies.map { MovieData(posterImage: Data(), movieInfo: $0) }
                self.filteredListOfMovies = self.listOfMovies
                DispatchQueue.main.async(execute: { self.tableView.reloadData() })
                let moviesRequest = PopularMoviesRequest()
                self.listOfMovies.forEach() { movieData in
                    moviesRequest.RetrieveMoviePoster(movieInfo: movieData.movieInfo) { result in
                        switch result {
                        case .success(let imageData):
                            DispatchQueue.main.async {
                                if let index = self.listOfMovies.firstIndex(where: {$0.movieInfo.title == movieData.movieInfo.title})
                                {
                                    self.listOfMovies[index].posterImage = imageData
                                }
                                if let index = self.filteredListOfMovies.firstIndex(where: {$0.movieInfo.title == movieData.movieInfo.title})
                                {
                                    self.filteredListOfMovies[index].posterImage = imageData
                                }
                            }
                            DispatchQueue.main.async(execute: { self.tableView.reloadData() })
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                        moviesRequest.RetrieveMovieBackDrop(movieInfo: movieData.movieInfo) { result in
                            switch result {
                            case .success(let imageData):
                                DispatchQueue.main.async {
                                    if let index = self.listOfMovies.firstIndex(where: {$0.movieInfo.title == movieData.movieInfo.title})
                                    {
                                        self.listOfMovies[index].backDropImage = imageData
                                    }
                                    if let index = self.filteredListOfMovies.firstIndex(where: {$0.movieInfo.title == movieData.movieInfo.title})
                                    {
                                        self.filteredListOfMovies[index].backDropImage = imageData
                                    }
                                }
                                DispatchQueue.main.async(execute: { self.tableView.reloadData() })
                            case .failure(let error):
                                print("Error: \(error)")
                            }
                        }
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    // MARK: Setup UI
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.tableView.keyboardDismissMode = .onDrag
        self.upperView.addSubview(searchBar)
        self.upperView.addSubview(titleLabel)
        self.view.addSubview(upperView)
        self.view.addSubview(tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.upperView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        self.upperView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.upperView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.upperView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.upperView.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: 213).isActive = true
        
        self.searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 57).isActive = true
        self.searchBar.leadingAnchor.constraint(equalTo: self.upperView.layoutMarginsGuide.leadingAnchor, constant: 37).isActive = true
        self.searchBar.trailingAnchor.constraint(equalTo: self.upperView.layoutMarginsGuide.trailingAnchor, constant: -37).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 143).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.upperView.layoutMarginsGuide.leadingAnchor, constant: 34).isActive = true
        
        self.tableView.topAnchor.constraint(equalTo: self.upperView.layoutMarginsGuide.bottomAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}

extension MoviesList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredListOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesListCell.identifier, for: indexPath) as? MoviesListCell else {
            fatalError("The TableView could not dequeue a MovieListCell in MoviesList")
        }
        let movieInfo = self.filteredListOfMovies[indexPath.row]
        cell.configure(with: movieInfo)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.systemBackground
        return cell
    }
}

extension MoviesList {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! MoviesListCell
        let controller = MovieDetails()
        controller.configure(movieData: cell.movieData)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MoviesList: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty) {
            filteredListOfMovies = listOfMovies
        } else {
            filteredListOfMovies = listOfMovies.filter({
                $0.movieInfo.title!.contains(searchText)
            })
        }
        DispatchQueue.main.async(execute: { self.tableView.reloadData() })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
