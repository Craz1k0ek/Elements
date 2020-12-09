import UIKit

class ElementListViewModel: NSObject {
    /// The model part of this view model.
    private let elements = Element.all
    /// The total number of models.
    let totalItemCount: Int
    
    /// The filter used to filter the elements list.
    var filterOptions: ElementFilterOptions
    /// The items to display in the list.
    var items: [ElementViewModel]
    
    /// The conntected controller.
    private weak var controller: ElementListVC?
    
    init(controller: ElementListVC) {
        self.controller = controller
        items = elements.map { ElementViewModel(element: $0) }
        totalItemCount = elements.count
        
        filterOptions = ElementFilterOptions()
        super.init()
        filterOptions.delegate = self
    }
}

// MARK: - UISearchResultsUpdating

extension ElementListViewModel: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterOptions.toggle(filter: .name(searchController.searchBar.text))
    }
}

// MARK: - ElementFilterOptionsDelegate

extension ElementListViewModel: ElementFilterOptionsDelegate {
    func elementFilter(_ options: ElementFilterOptions, didChangeFilter filter: ElementFilter) {
        items = elements.filter {
            (options.name == nil || options.name!.isEmpty) ? true : $0.name.lowercased().contains(options.name!.lowercased())
        }.filter {
            options.phases.isEmpty ? true : options.phases.contains($0.phase)
        }.filter {
            options.categories.isEmpty ? true : options.categories.contains($0.category)
        }.map { ElementViewModel(element: $0) }
        controller?.notifyOfChanges()
    }
}
