import UIKit

class ElementFilterListVC: UIViewController {
    private var tableView: UITableView!
    
    /// The filter options that are or should be applied.
    let filterOptions: ElementFilterOptions
    
    /// Designated initializer.
    /// - Parameter filterOptions: The filter options to alter.
    init(filterOptions: ElementFilterOptions) {
        self.filterOptions = filterOptions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title                = "Filters"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(filterSettingsDone)), animated: false)
        
        setupTableView()
    }
    
    fileprivate final func setupTableView() {
        tableView                = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource     = self
        tableView.delegate       = self
        tableView.useConstraints = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FilterCell")
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    /// Called to dismiss the current filter settings.
    @objc fileprivate final func filterSettingsDone() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ElementFilterListVC: UITableViewDataSource {
    enum Section: Int, CaseIterable, CustomStringConvertible {
        case phase, category
        
        var description: String {
            switch self {
            case .phase:    return "Phases"
            case .category: return "Categories"
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { Section.allCases.count }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        return "\(section)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .phase:    return Element.Phase.allCases.count
        case .category: return Element.Category.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { fatalError("Unsupported section.") }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        
        switch section {
        case .phase:
            guard let phase = Element.Phase(rawValue: indexPath.item) else { fatalError("Unsupported element phase: \(indexPath.item).") }
            
            cell.textLabel?.text = "\(phase)"
            cell.accessoryType = filterOptions.phases.contains(phase) ? .checkmark : .none
        case .category:
            guard let category = Element.Category(rawValue: indexPath.item) else { fatalError("Unsupported category: \(indexPath.item).") }
            
            cell.textLabel?.text = "\(category)"
            cell.imageView?.image = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(category.color)
            cell.accessoryType = filterOptions.categories.contains(category) ? .checkmark : .none
        }
        return cell
    }
}

extension ElementFilterListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        switch section {
        case .phase:
            guard let phase = Element.Phase(rawValue: indexPath.item) else { return }
            filterOptions.toggle(filter: .phase(phase))
        case .category:
            guard let category = Element.Category(rawValue: indexPath.item) else { return }
            filterOptions.toggle(filter: .category(category))
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
