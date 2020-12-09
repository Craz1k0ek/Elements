import UIKit

class ElementSearchController: UISearchController {
    /// The total amount of items to filter.
    var totalItemCount: Int {
        get {
            (searchBar.inputAccessoryView as! ElementSearchResultView).totalItemCount
        }
        set {
            (searchBar.inputAccessoryView as! ElementSearchResultView).totalItemCount = newValue
        }
    }
    
    /// Designated initializer.
    /// - Parameters:
    ///   - searchResultsUpdater: The delegate responding to updates.
    ///   - totalItemCount: The total number of items that is searched in.
    init(searchResultsUpdater: UISearchResultsUpdating?, totalItemCount: Int) {
        super.init(searchResultsController: nil)
        self.searchResultsUpdater  = searchResultsUpdater
        definesPresentationContext = true
        searchBar.placeholder      = "Search by name"
        obscuresBackgroundDuringPresentation = false
        
        searchBar.inputAccessoryView = ElementSearchResultView(totalItemCount: totalItemCount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Set the amount of found items for a filter.
    /// - Parameter amount: The amount of found items.
    func setFilteredResultAmount(to amount: Int) {
        (searchBar.inputAccessoryView as! ElementSearchResultView).setFilteredResultCount(to: amount)
    }
}

/// A view used to display how many filtered items are found.
fileprivate class ElementSearchResultView: UIToolbar {
    /// The label containing the result text.
    private var resultsLabel: UILabel!
    
    /// The total maximum number of items in the filtered list.
    var totalItemCount: Int
    
    init(totalItemCount: Int) {
        self.totalItemCount = totalItemCount
        super.init(frame: .init(x: 0, y: 0, width: 350, height: 35))    // Setting the size to prevent layout constraints errors
        sizeToFit()
        
        setupAppearance()
        setupResultsLabel()
        items = [UIBarButtonItem(customView: resultsLabel)]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final func setupAppearance() {
        let inputToolBarAppearance = UIToolbarAppearance()
        inputToolBarAppearance.configureWithOpaqueBackground()
        inputToolBarAppearance.backgroundColor = UIColor(named: "Accent")
        standardAppearance = inputToolBarAppearance
        compactAppearance  = inputToolBarAppearance
    }
    
    final func setupResultsLabel() {
        resultsLabel               = UILabel()
        resultsLabel.textColor     = .white
        resultsLabel.textAlignment = .center
    }
    
    func setFilteredResultCount(to amount: Int) {
        resultsLabel.text = amount == 0 ? "No results for filter" : "Filtering \(amount) of \(totalItemCount)"
    }
}
