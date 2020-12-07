import UIKit

class ElementNavigationVC: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationBar.prefersLargeTitles = true
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = UIColor(named: "Primary")
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        let plainButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        plainButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.buttonAppearance = plainButtonAppearance
        
        let doneButtonAppearance = UIBarButtonItemAppearance(style: .done)
        doneButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.doneButtonAppearance = doneButtonAppearance
        coloredAppearance.backButtonAppearance = doneButtonAppearance
        
        navigationBar.standardAppearance = coloredAppearance
        navigationBar.scrollEdgeAppearance = coloredAppearance
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
