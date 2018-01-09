//
//  UIButton+Extension.swift
//  MXSSwift
//
//  Created by Alfred Yang on 16/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
	
	public convenience init(text:String, fontSize:CGFloat, textColor:UIColor, background:Any) {
		self.init()
		self.setTitle(text, for: .normal)
		self.setTitleColor(textColor, for: .normal)
		self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
		if !(background is MXSNothing) {
			self.backgroundColor = (background as! UIColor)
		}
	}
}
