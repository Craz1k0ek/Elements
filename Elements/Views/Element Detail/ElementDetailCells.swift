import UIKit

class ElementDetailInfoCell: UITableViewCell {
    /// The identifier used to dequeue it on the table view.
    static let reuseIdentifier = "DetailInfoCell"
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: Self.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String, detail: String?) {
        textLabel?.text       = title
        detailTextLabel?.text = detail ?? "Unknown"
    }
}

class ElementDetailContentCell: UITableViewCell {
    /// The identifier used to dequeue it on the table view.
    static let reuseIdentifier = "DetailContentCell"
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Self.reuseIdentifier)
        textLabel?.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(_ content: String) {
        textLabel?.text = content
    }
}

class ElementDetailUrlCell: UITableViewCell {
    /// The identifier used to dequeue it on the table view.
    static let reuseIdentifier = "DetailUrlCell"
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Self.reuseIdentifier)
        accessoryType        = .disclosureIndicator
        textLabel?.textColor = UIColor(named: "Accent")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
