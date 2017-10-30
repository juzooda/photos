//
//  SearchViewController.swift
//  PhotoSearch
//
//  Created by Rafael Oda on 29/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    var searchInputs = Set<String>() {
        didSet{
            datasorce = Array(searchInputs)
        }
    }
    
    var datasorce = [String]() {
        willSet {
            self.datasorce = newValue.sorted(by: { $0 < $1 })
        }
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Photos"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasorce.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        cell.textLabel?.text = datasorce[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToResultsVC(searchInput: datasorce[indexPath.row])
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    func filterPastSearchList() {
        if let currentSearchBarText = searchController.searchBar.text {
            datasorce = searchInputs.filter({ $0.contains(currentSearchBarText)})
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        filterPastSearchList()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let search = searchBar.text {
            searchInputs.update(with: search)
            navigateToResultsVC(searchInput: search)
        }
    }
    
    func navigateToResultsVC(searchInput: String) {
        let resultsViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ResultsViewController") as! PhotosViewController
        resultsViewController.title = searchInput
        resultsViewController.viewModel = PhotosViewModel(searchInput:searchInput, photoService: FlickrService(), view: resultsViewController)
        self.navigationController?.show(resultsViewController, sender: nil)
    }
}
