import UIKit

final class ElementViewModel {
    private let element: Element
    
    /// The atom number.
    var atomNumber: String { "\(element.number)" }
    /// The symbol.
    var symbol: String { element.symbol }
    /// The name/
    var name: String { element.name }
    
    /// The category.
    var category: String { "\(element.category)" }
    /// The category color.
    var categoryColor: UIColor { element.category.color }
    
    /// The atomic mass.
    var atomicMass: String { "\(element.atomicMass) m" }
    /// The density.
    var density: String { element.density == nil ? "Unknown" : "\(element.density!) g/cm³" }
    
    /// The boil.
    var boil: String { element.boil == nil ? "Unknown" : "\(element.boil!) K" }
    /// The melt.
    var melt: String { element.melt == nil ? "Unknown" : "\(element.melt!) K" }
    /// The phase.
    var phase: String { "\(element.phase)" }
    
    /// The discovered by.
    var discoveredBy: String { element.discoveredBy ?? "Unknown" }
    /// The summary.
    var summary: String { element.summary }
    /// The source URL.
    var sourceURL: URL { element.source }
    
    init(element: Element) {
        self.element = element
    }
}
