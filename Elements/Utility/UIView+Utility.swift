import UIKit

extension UIView {
    /// Whether or not to use constraints.
    var useConstraints: Bool {
        get { return !translatesAutoresizingMaskIntoConstraints }
        set { translatesAutoresizingMaskIntoConstraints = !newValue }
    }
}
