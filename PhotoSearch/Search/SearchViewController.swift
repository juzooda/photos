//
//  SearchViewController.swift
//  PhotoSearch
//
//  Created by Rafael Oda on 29/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {

    private let searchController = UISearchController(searchResultsController: nil)

    private var searchInputs = Set<String>() {
        didSet{
            updateDataSource()
        }
    }
    
    private var datasorce = [String]() {
        willSet {
            self.datasorce = newValue.sorted(by: { $0 < $1 })
        }
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filterWithTextOnSerchBar()
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Photos"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    func updateDataSource() {
        datasorce = Array(searchInputs)
    }
    
    func filterWithTextOnSerchBar() {
        if let currentSearchBarText = searchController.searchBar.text {
            if (currentSearchBarText.isEmpty) {
                updateDataSource()
            }else {
                datasorce = searchInputs.filter({ $0.contains(currentSearchBarText)})
            }
        }
    }
}

//MARK: UITableViewDataSource

extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasorce.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        cell.textLabel?.text = datasorce[indexPath.row]
        return cell
    }
}

//MARK: UITableViewDelegate

extension SearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToResultsVC(searchInput: datasorce[indexPath.row])
    }
}

//MARK: UISearchBar

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        filterWithTextOnSerchBar()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let search = searchBar.text {
            searchInputs.update(with: search)
            navigateToResultsVC(searchInput: search)
        }
    }
}

//MARK : - Router

extension SearchViewController {
    func navigateToResultsVC(searchInput: String) {
        let resultsViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ResultsViewController") as! PhotosViewController
        resultsViewController.title = searchInput
        resultsViewController.viewModel = PhotosViewModel(searchInput:searchInput, flickrPhotoService: FlickrService(), view: resultsViewController)
        self.navigationController?.show(resultsViewController, sender: nil)
    }
}
