//
//  IBPlaceHolderView.swfit
//  IBPlaceHolderView
//
//  Created by rcio on 16/2/1.
//  Copyright © 2016年 GF Securities. All rights reserved.
//

import UIKit

class IBPlaceHolderView: UIView {
    @IBInspectable var xibName: String?
    @IBInspectable var restorationID: String?
    
    private var nibView: UIView?
    var view: UIView {
        get {
            return nibView!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        assert(xibName != nil, "Xib place holder view need set xib name.")
        assert(restorationID != nil, "Xib place holder view need set restoration ID.")
        
        let nib = UINib(nibName: xibName!, bundle: nil)
        let views = nib.instantiateWithOwner(nil, options: nil)
        for view in views as! [UIView] {
            if view.restorationIdentifier == restorationID {
                nibView = view
                break
            }
        }
        
        assert(nibView != nil, "Xib place holder can't find a view with restoration ID \(restorationID!) in xib file \(xibName!)")
        
        let selfView = self
        let superView = superview
        let ancestorConstraints = superview!.constraints
        
        superview?.addSubview(nibView!)
        removeFromSuperview()
        
        nibView?.layer.zPosition = layer.zPosition
        nibView?.frame = self.frame
        nibView?.translatesAutoresizingMaskIntoConstraints = selfView.translatesAutoresizingMaskIntoConstraints
        nibView?.setContentCompressionResistancePriority(selfView.contentCompressionResistancePriorityForAxis(.Horizontal), forAxis: .Horizontal)
        nibView?.setContentCompressionResistancePriority(selfView.contentCompressionResistancePriorityForAxis(.Vertical), forAxis: .Vertical)
        nibView?.setContentHuggingPriority(selfView.contentHuggingPriorityForAxis(.Horizontal), forAxis: .Horizontal)
        nibView?.setContentHuggingPriority(selfView.contentHuggingPriorityForAxis(.Vertical), forAxis: .Vertical)
        nibView?.intrinsicContentSize()
        copyContrainsToView(constrains: ancestorConstraints, dstView: superView!, aboutView: nibView!)
        copyContrainsToView(constrains: self.constraints, dstView: nibView!, aboutView: nibView!)

    }

    
    func copyContrainsToView(constrains _constrains: [NSLayoutConstraint], dstView: UIView, aboutView: UIView) {
        for constraint in _constrains {
            var firstItem: AnyObject?
            var secondItem: AnyObject?
            
            if constraint.firstItem.isEqual(self) == true {
                firstItem = aboutView
            }
            
            if constraint.secondItem != nil
                && constraint.secondItem!.isEqual(self) {
                    secondItem = aboutView
            }
            
            if firstItem == nil && secondItem == nil {
                continue
            }
            
            let newConstraint = NSLayoutConstraint(
                item: firstItem != nil ? firstItem! : constraint.firstItem,
                attribute: constraint.firstAttribute,
                relatedBy: constraint.relation,
                toItem: secondItem != nil ? secondItem : constraint.secondItem,
                attribute: constraint.secondAttribute,
                multiplier: constraint.multiplier,
                constant: constraint.constant)
            
            newConstraint.priority = constraint.priority
            
            dstView.addConstraint(newConstraint)
        }

    }
}
