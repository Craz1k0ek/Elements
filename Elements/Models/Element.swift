import Foundation

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
    enum Phase: Int, CustomStringConvertible, Decodable {
        case gas, solid, liquid
        
        var description: String {
            switch self {
            case .gas: return "Gas"
            case .solid: return "Solid"
            case .liquid: return "Liquid"
            }
        }
    }
}
