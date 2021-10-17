import UIKit

class FHTypeView: UIView {
    
    lazy var title: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var type: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        
        return segmentedControl
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        setupUI()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private func setupUI() {
        self.backgroundColor = .white
    }

}
