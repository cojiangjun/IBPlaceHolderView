//
//  ViewController.swift
//  IBPlaceHolderViewDemo
//
//  Created by rcio on 16/2/19.
//  Copyright © 2016年 GF Securities. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var placeHolder: IBPlaceHolderView?
    var contentView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView = placeHolder?.view
        
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "I'm added programmatically"
        contentView?.addSubview(lable)
        
        contentView?.addConstraint(NSLayoutConstraint(
            item: lable,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: contentView,
            attribute: .CenterX,
            multiplier: 1,
            constant: 0))
        contentView?.addConstraint(NSLayoutConstraint(
            item: lable,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: contentView,
            attribute: .CenterY,
            multiplier: 1,
            constant: 0))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

