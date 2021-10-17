import UIKit

class FHIdeasButton: UIButton {

    @IBInspectable var habitColor: UIColor = .black
    @IBInspectable var habitTitleColor: UIColor = .white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initButton()
    }
    
    func initButton() {
        layer.cornerRadius = 12
        backgroundColor = habitColor
        setTitleColor(habitTitleColor, for: .normal)
    }
    
}
