/// A filter that can be applied on the elements list.
enum ElementFilter {
    /// A filter for the element name.
    case name(String?)
    /// A filter for the element phase.
    case phase(Element.Phase)
    /// A filter for the element category.
    case category(Element.Category)
}

final class ElementFilterOptions {
    /// The currently applied filter for the name.
    var name: String? = nil
    /// The currently applied filter for the phase.
    var phases        = Set<Element.Phase>()
    /// The currently applied filter for the category.
    var categories    = Set<Element.Category>()
    
    /// A delegate to notify of filter changes.
    weak var delegate: ElementFilterOptionsDelegate?
    
    /// Whether or not there are currently filters applied.
    var isFiltering: Bool {
        !(name ?? "").isEmpty || !phases.isEmpty || !categories.isEmpty
    }
    
    /// Toggle a filter.
    /// - Parameter filter: The filter to toggle.
    func toggle(filter: ElementFilter) {
        switch filter {
        case .name(let name): self.name = name
        case .phase(let phase):
            phases.contains(phase) ? (_ = phases.remove(phase)) : (_ = phases.insert(phase))
        case .category(let category):
            categories.contains(category) ? (_ = categories.remove(category)) : (_ = categories.insert(category))
        }
        
        delegate?.elementFilter(self, didChangeFilter: filter)
    }
}

/// A delegate used to get notifications on element filter changes.
protocol ElementFilterOptionsDelegate: class {
    /// Tells the delegate a filter did change.
    /// - Parameters:
    ///   - options: The filter options that were changed.
    ///   - filter: The filter that was changed.
    func elementFilter(_ options: ElementFilterOptions, didChangeFilter filter: ElementFilter)
}
