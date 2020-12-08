import UIKit

class ElementNavigationVC: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupNavigationBarAppearance()
        setupToolBarAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Appearance Setup
    
    fileprivate final func setupNavigationBarAppearance() {
        navigationBar.prefersLargeTitles = true
        
        // Used to configure the style of the navigation bar.
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor          = UIColor(named: "Primary")
        coloredAppearance.titleTextAttributes      = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Used to style some buttons of the navigation bar.
        let plainButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        plainButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.buttonAppearance = plainButtonAppearance
        
        let doneButtonAppearance = UIBarButtonItemAppearance(style: .done)
        doneButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.doneButtonAppearance = doneButtonAppearance
        coloredAppearance.backButtonAppearance = doneButtonAppearance
        
        navigationBar.standardAppearance   = coloredAppearance
        navigationBar.scrollEdgeAppearance = coloredAppearance
        
        // Used to give the back button image (<) the correct color.
        navigationBar.tintColor = .white
    }
    
    fileprivate final func setupToolBarAppearance() {
        let toolBarAppearance = UIToolbarAppearance()
        toolBarAppearance.configureWithOpaqueBackground()
        
        let toolBarButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        toolBarButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(named: "Accent")!]
        toolBarAppearance.buttonAppearance     = toolBarButtonAppearance
        toolBarAppearance.doneButtonAppearance = toolBarButtonAppearance
        
        toolbar.standardAppearance = toolBarAppearance
        toolbar.compactAppearance = toolBarAppearance
        toolbar.tintColor = UIColor(named: "Accent")!   // Used to style buttons with images, cannot be set at this point
    }
}

extension UINavigationItem {
    /// Set the colors for the current navigation item.
    /// - Parameters:
    ///   - backgroundColor: The background color.
    ///   - titleColor: The title color.
    ///   - barButtonColor: The bar button colors (excluding the back bar button icon).
    func setColors(backgroundColor: UIColor, titleColor: UIColor, barButtonColor: UIColor) {
        // Used to configure the style of the navigation bar.
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor          = backgroundColor
        coloredAppearance.titleTextAttributes      = [.foregroundColor: titleColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        
        let doneButtonAppearance = UIBarButtonItemAppearance(style: .done)
        doneButtonAppearance.normal.titleTextAttributes = [.foregroundColor: titleColor]
        
        coloredAppearance.doneButtonAppearance = doneButtonAppearance
        coloredAppearance.backButtonAppearance = doneButtonAppearance
                
        standardAppearance   = coloredAppearance
        scrollEdgeAppearance = coloredAppearance
    }
}
