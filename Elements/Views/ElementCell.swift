import UIKit

class ElementCell: UITableViewCell {
    /// The identifier used to dequeue it on the table view.
    static let reuseIdentifier = "ElementCell"
    
    /// The background view of the symbol label.
    var symbolBackgroundView: UIView!
    /// The symbol label view,
    var symbolLabel: UILabel!
    /// The name label.
    var nameLabel: UILabel!
    
    /// The element to display in the cell.
    var element: Element! {
        didSet {
            symbolBackgroundView.backgroundColor = element.category.color
            symbolLabel.text                     = element.symbol
            nameLabel.text                       = element.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Self.reuseIdentifier)
        accessoryType = .disclosureIndicator
        setupSymbolView()
        setupNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View & Layouts
    
    /// Setup the round symbol view and its label.
    fileprivate final func setupSymbolView() {
        symbolBackgroundView                     = UIView()
        symbolBackgroundView.useConstraints      = true
        symbolBackgroundView.layer.cornerRadius  = 20
        symbolBackgroundView.layer.masksToBounds = true
        symbolBackgroundView.layer.borderWidth   = 2
        symbolBackgroundView.layer.borderColor   = UIColor.systemGray.cgColor
        
        symbolLabel                = UILabel()
        symbolLabel.useConstraints = true
        symbolLabel.textAlignment  = .center
        symbolLabel.font           = UIFont.systemFont(ofSize: 14, weight: .bold)
        symbolLabel.textColor      = .darkGray
        
        addSubview(symbolBackgroundView)
        symbolBackgroundView.addSubview(symbolLabel)
        NSLayoutConstraint.activate([
            symbolBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            symbolBackgroundView.heightAnchor.constraint(equalToConstant: 38),
            symbolBackgroundView.widthAnchor.constraint(equalToConstant: 38),
            symbolBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            symbolLabel.centerXAnchor.constraint(equalTo: symbolBackgroundView.centerXAnchor),
            symbolLabel.centerYAnchor.constraint(equalTo: symbolBackgroundView.centerYAnchor),
            symbolLabel.widthAnchor.constraint(equalTo: symbolBackgroundView.widthAnchor, multiplier: 0.95),
            symbolLabel.heightAnchor.constraint(equalTo: symbolBackgroundView.heightAnchor)
        ])
    }
    
    /// Setup the name label.
    fileprivate final func setupNameLabel() {
        nameLabel                = UILabel()
        nameLabel.useConstraints = true
        
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: symbolBackgroundView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
}
