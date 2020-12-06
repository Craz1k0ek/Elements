import Foundation

// MARK: Element

struct Element: Hashable {
    let number: Int
    let symbol: String
    let name: String
    
    let atomicMass: Float
    let density: Float
    
    let boil: Float
    let melt: Float
    let phase: Phase
    
    let discoveredBy: String?
    let summary: String
    
    let source: URL
}

// MARK: Element Phase

extension Element {
    enum Phase: Int, CustomStringConvertible {
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
