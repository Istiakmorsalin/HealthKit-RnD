import UIKit

@IBDesignable
class FAButton: UIButton {


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 12
        self.showsTouchWhenHighlighted = true
        
        self.layer.masksToBounds = false

        self.layer.shadowColor = self.backgroundColor?.cgColor;
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.cornerRadius = 12
//        self.showsTouchWhenHighlighted = true
        
        self.layer.masksToBounds = true

        self.layer.shadowColor = self.backgroundColor?.cgColor;
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
    }
    
}
