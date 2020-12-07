import UIKit

class ElementListVC: UIViewController {
    private var tableView: UITableView!
    
    /// The filtered elements found when searching.
    private var filteredElements: [Element] = []
    /// Whether or not the search bar is empty.
    private var isSearchBarEmpty: Bool {
        navigationItem.searchController?.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        (navigationItem.searchController?.isActive ?? false) && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor    = .systemBackground
        self.title              = "Elements"
        setupTableView()
        setupSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - View & Layouts
    
    fileprivate final func setupTableView() {
        tableView                   = UITableView()
        tableView.dataSource        = self
        tableView.delegate          = self
        tableView.useConstraints    = true
        tableView.rowHeight         = 50
        
        tableView.register(ElementCell.self, forCellReuseIdentifier: ElementCell.reuseIdentifier)
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    fileprivate final func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater  = self
        searchController.searchBar.placeholder = "Search elements"
        navigationItem.searchController        = searchController
        definesPresentationContext             = true
    }
}

// MARK: - UITableView Data Source & Delegate

extension ElementListVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering { return filteredElements.count }
        return Element.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell    = tableView.dequeueReusableCell(withIdentifier: ElementCell.reuseIdentifier, for: indexPath) as! ElementCell
        cell.element = isFiltering ? filteredElements[indexPath.item] : Element.all[indexPath.item]
        return cell
    }
}

extension ElementListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(ElementDetailVC(element: isFiltering ? filteredElements[indexPath.item] : Element.all[indexPath.item]), animated: true)
    }
}

// MARK: - UISearchController
extension ElementListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filterContent(for: text)
        }
    }
    
    fileprivate final func filterContent(for searchText: String) {
        filteredElements = Element.all.filter {
            $0.name.lowercased().contains(searchText.lowercased()) || $0.category.description.lowercased().contains(searchText.lowercased()) ||
                $0.phase.description.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}
