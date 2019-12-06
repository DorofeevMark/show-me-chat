import Foundation
import UIKit

class InfoWindow: UIView {
  var contentView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

   private func commonInit(){
    Bundle.main.loadNibNamed("InfoWindow", owner: self, options: nil)
    addSubview(contentView)
    }
}
