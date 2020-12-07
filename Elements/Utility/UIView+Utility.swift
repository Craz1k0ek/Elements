import UIKit

extension UIView {
    /// A wrapper Boolean value that determines whether the view’s autoresizing mask is translated into Auto Layout constraints.
    var useConstraints: Bool {
        get {
            return translatesAutoresizingMaskIntoConstraints
        }
        set {
            translatesAutoresizingMaskIntoConstraints = newValue
        }
    }
}
