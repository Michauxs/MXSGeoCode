//
//  UIColor+Extension.swift
//  MXSSwift
//
//  Created by Alfred Yang on 23/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
	
	open class var random: UIColor {
		get {
			return UIColor.init(red: CGFloat(arc4random() % 256)/255, green: CGFloat(arc4random() % 256)/255, blue: CGFloat(arc4random() % 256)/255, alpha: 1)
		}
	}
	
	open class var lightBlack: UIColor {
		get {
			return UIColor.init(white: 0.15, alpha: 1)
		}
	}
	
	open class var dullWhite: UIColor {
		get {
			return UIColor.init(white: 0.75, alpha: 1)
		}
	}
	open class var dullLine: UIColor {
		get {
			return UIColor.init(white: 0.55, alpha: 1)
		}
	}
	open class var darkLine: UIColor {
		get {
			return UIColor.init(white: 0.35, alpha: 1)
		}
	}
	
	open class var grayline: UIColor {
		get {
			return UIColor.init(white: 0.85, alpha: 1)
		}
	}
	//
	open class var theme: UIColor {
		get {
			return UIColor.init(red: 90/255, green: 210/255, blue: 200/255, alpha: 1)
		}
	}
	
	
}


