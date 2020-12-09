import UIKit

class ElementListVC: UIViewController {
    private var tableView: UITableView!
    
    /// The filtered elements found when searching.
    private var filteredElements: [Element] = []
    
    /// The filter used to filter the elements list.
    private var filterOptions: ElementFilterOptions!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title                = "Elements"
        
        filterOptions          = ElementFilterOptions()
        filterOptions.delegate = self
        
        navigationItem.searchController = ElementSearchController(searchResultsUpdater: self, totalItemCount: Element.all.count)
        
        setupTableView()
        setupToolbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: animated)
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - View & Layouts
    
    fileprivate final func setupTableView() {
        tableView                = UITableView()
        tableView.dataSource     = self
        tableView.delegate       = self
        tableView.useConstraints = true
        tableView.rowHeight      = 50
        tableView.keyboardDismissMode = .onDrag
        
        tableView.register(ElementCell.self, forCellReuseIdentifier: ElementCell.reuseIdentifier)
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    fileprivate final func setupToolbar() {
        navigationController?.setToolbarHidden(false, animated: false)
        toolbarItems = [UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), style: .plain, target: self, action: #selector(didTapFilterToggleButton))]
    }
    
    // MARK: - User interaction
    
    @objc fileprivate func didTapFilterToggleButton() {
        present(ElementNavigationVC(rootViewController: ElementFilterListVC(filterOptions: filterOptions)), animated: true, completion: nil)
    }
}

// MARK: - UITableView Data Source & Delegate

extension ElementListVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterOptions.isFiltering { return filteredElements.count }
        return Element.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell    = tableView.dequeueReusableCell(withIdentifier: ElementCell.reuseIdentifier, for: indexPath) as! ElementCell
        cell.element = filterOptions.isFiltering ? filteredElements[indexPath.item] : Element.all[indexPath.item]
        return cell
    }
}

extension ElementListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(ElementDetailVC(element: filterOptions.isFiltering ? filteredElements[indexPath.item] : Element.all[indexPath.item]), animated: true)
    }
}

// MARK: - UISearchController

extension ElementListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterOptions.toggle(filter: .name(searchController.searchBar.text))
    }
}

// MARK: - ElementFilterOptionsDelegate

extension ElementListVC: ElementFilterOptionsDelegate {
    func elementFilter(_ options: ElementFilterOptions, didChangeFilter filter: ElementFilter) {
        filteredElements = Element.all.filter {
            (options.name == nil || options.name!.isEmpty) ? true : $0.name.lowercased().contains(options.name!.lowercased())
        }.filter {
            options.phases.isEmpty ? true : options.phases.contains($0.phase)
        }.filter {
            options.categories.isEmpty ? true : options.categories.contains($0.category)
        }
        (navigationItem.searchController as? ElementSearchController)?.setFilteredResultAmount(to: filteredElements.count)
        tableView.reloadSections(IndexSet(integersIn: 0 ..< tableView.numberOfSections), with: .automatic)
    }
}
