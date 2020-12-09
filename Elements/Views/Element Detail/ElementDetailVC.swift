import UIKit
import SafariServices

class ElementDetailVC: UIViewController {
    /// The view model of the controller.
    let elementViewModel: ElementViewModel
    
    private var tableView: UITableView!
    
    /// Designated initializer.
    /// - Parameter element: The element to display in detail.
    init(elementViewModel: ElementViewModel) {
        self.elementViewModel = elementViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title                = elementViewModel.name
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.navigationBar.tintColor = .darkGray
        navigationItem.setColors(backgroundColor: elementViewModel.categoryColor, titleColor: .darkGray, barButtonColor: .darkGray)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View & Layouts
    
    fileprivate final func setupTableView() {
        tableView                = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource     = self
        tableView.delegate       = self
        tableView.useConstraints = true
        
        tableView.register(ElementDetailInfoCell.self, forCellReuseIdentifier: ElementDetailInfoCell.reuseIdentifier)
        tableView.register(ElementDetailContentCell.self, forCellReuseIdentifier: ElementDetailContentCell.reuseIdentifier)
        tableView.register(ElementDetailUrlCell.self, forCellReuseIdentifier: ElementDetailUrlCell.reuseIdentifier)
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableView Data Source & Delegate

extension ElementDetailVC: UITableViewDataSource {
    enum Section: Int, CaseIterable, CustomStringConvertible {
        case general, weight, temperature, trivia, source
        
        var description: String {
            switch self {
            case .general:     return "General"
            case .weight:      return "Weight"
            case .temperature: return "Temperature"
            case .trivia:      return "Trivia"
            default:           return ""
            }
        }
        
        var rowCount: Int {
            switch self {
            case .general:     return 3
            case .weight:      return 2
            case .temperature: return 3
            case .trivia:      return 2
            case .source:      return 1
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { Section.allCases.count }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Section(rawValue: section)?.rowCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        return "\(section)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unsupported section.")
        }
        
        switch section {
        case .general:
            let cell = tableView.dequeueReusableCell(withIdentifier: ElementDetailInfoCell.reuseIdentifier, for: indexPath) as! ElementDetailInfoCell
            switch indexPath.item {
            case 0: cell.setTitle("Atom number", detail: elementViewModel.atomNumber)
            case 1: cell.setTitle("Symbol", detail: elementViewModel.symbol)
            case 2: cell.setTitle("Category", detail: elementViewModel.category)
            default: fatalError("No cell configured for section and index path.")
            }
            return cell
        case .weight:
            let cell = tableView.dequeueReusableCell(withIdentifier: ElementDetailInfoCell.reuseIdentifier, for: indexPath) as! ElementDetailInfoCell
            switch indexPath.item {
            case 0: cell.setTitle("Atomic mass", detail: elementViewModel.atomicMass)
            case 1: cell.setTitle("Density", detail: elementViewModel.density)
            default: fatalError("No cell configured for section and index path.")
            }
            return cell
        case .temperature:
            let cell = tableView.dequeueReusableCell(withIdentifier: ElementDetailInfoCell.reuseIdentifier, for: indexPath) as! ElementDetailInfoCell
            switch indexPath.item {
            case 0: cell.setTitle("Boil", detail: elementViewModel.boil)
            case 1: cell.setTitle("Melt", detail: elementViewModel.melt)
            case 2: cell.setTitle("Phase", detail: elementViewModel.phase)
            default: fatalError("No cell configured for section and index path.")
            }
            return cell
        case .trivia:
            switch indexPath.item {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: ElementDetailInfoCell.reuseIdentifier, for: indexPath) as! ElementDetailInfoCell
                cell.setTitle("Discovered by", detail: elementViewModel.discoveredBy)
                cell.detailTextLabel?.numberOfLines = 0
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: ElementDetailContentCell.reuseIdentifier, for: indexPath) as! ElementDetailContentCell
                cell.setContent(elementViewModel.summary)
                return cell
            default: fatalError("No cell configured for section and index path.")
            }
        case .source:
            let cell = tableView.dequeueReusableCell(withIdentifier: ElementDetailUrlCell.reuseIdentifier, for: indexPath) as! ElementDetailUrlCell
            cell.textLabel?.text = "Open source in Safari"
            return cell
        }
    }
}

extension ElementDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = Section(rawValue: indexPath.section), section == .source else {
            return
        }
        present(SFSafariViewController(url: elementViewModel.sourceURL), animated: true)
    }
}
