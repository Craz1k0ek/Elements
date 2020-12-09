import UIKit

class ElementListVC: UIViewController {
    private var tableView: UITableView!
    
    private var viewModel: ElementListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title                = "Elements"
        
        viewModel = ElementListViewModel(controller: self)
        navigationItem.searchController = ElementSearchController(searchResultsUpdater: viewModel, totalItemCount: viewModel.totalItemCount)
        
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
        present(ElementNavigationVC(rootViewController: ElementFilterListVC(filterOptions: viewModel.filterOptions)), animated: true, completion: nil)
    }
    
    /// Called by the view model whenever changes have occured.
    func notifyOfChanges() {
        (navigationItem.searchController as? ElementSearchController)?.setFilteredResultAmount(to: viewModel.items.count)
        tableView.reloadSections(IndexSet(integersIn: 0 ..< tableView.numberOfSections), with: .automatic)
    }
}

// MARK: - UITableView Data Source & Delegate

extension ElementListVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ElementCell.reuseIdentifier, for: indexPath) as! ElementCell
        cell.elementViewModel = viewModel.items[indexPath.item]
        return cell
    }
}

extension ElementListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(ElementDetailVC(elementViewModel: viewModel.items[indexPath.item]), animated: true)
    }
}
