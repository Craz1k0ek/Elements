import UIKit

// MARK: Element

struct Element: Decodable, Hashable {
    /// All elements from the loaded resource file.
    static var all: [Element] = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // All these bang operators are safe, as the data is validated and MUST
        // be included in a running app.
        return try! decoder.decode([Element].self, from: try! Data(contentsOf: Bundle.main.url(forResource: "elements", withExtension: "json")!))
    }()
    
    let number: Int
    let symbol: String
    let name: String
    let category: Category
    
    let atomicMass: Float
    let density: Float?
    
    let boil: Float?
    let melt: Float?
    let phase: Phase
    
    let discoveredBy: String?
    let summary: String
    
    let source: URL
}

// MARK: Element Phase

extension Element {
    enum Phase: Int, CaseIterable, CustomStringConvertible, Decodable {
        case gas, solid, liquid
        
        var description: String {
            switch self {
            case .gas:    return "Gas"
            case .solid:  return "Solid"
            case .liquid: return "Liquid"
            }
        }
    }
}

// MARK: Element Category

extension Element {
    enum Category: Int, CaseIterable, CustomStringConvertible, Decodable {
        case alkaliMetal
        case alkalineEarthMetal
        case lanthanide
        case actinide
        case transitionMetal
        case otherMetal
        case metalloid
        case otherNonmetal
        case halogen
        case nobleGas
        case unknown
        
        var description: String {
            switch self {
            case .alkaliMetal:        return "Alkali metal"
            case .alkalineEarthMetal: return "Alkaline earth metal"
            case .lanthanide:         return "Lanthanide"
            case .actinide:           return "Actinide"
            case .transitionMetal:    return "Transition metal"
            case .otherMetal:         return "Other metal"
            case .metalloid:          return "Metalloid"
            case .otherNonmetal:      return "Other nonmetal"
            case .halogen:            return "Halogen"
            case .nobleGas:           return "Noble gas"
            case .unknown:            return "Unknown"
            }
        }
        
        /// A color to group a category.
        ///
        /// - Note: Bang operator is fine, as all of these colors are defined.
        var color: UIColor {
            return UIColor(named: self.description)!
        }
    }
}
