//
//  MXSTableViewCell.swift
//  MXSSwift
//
//  Created by Alfred Yang on 24/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSTableViewCell: UITableViewCell {

	var cellData : Any? {
		didSet {
			
		}
	}
    
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		backgroundColor = UIColor.lightBlack
		selectionStyle = .none
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:actions
	public func drawBtmLine() {
		let line = UIView.init()
		addSubview(line)
		line.backgroundColor = UIColor.dullLine
		line.snp.makeConstraints { (make) in
			make.right.equalTo(self)
			make.left.equalTo(self).offset(15)
			make.bottom.equalTo(self)
			make.height.equalTo(0.5)
		}
		let line2 = UIView.init()
		addSubview(line2)
		line2.backgroundColor = UIColor.black
		line2.snp.makeConstraints { (make) in
			make.right.equalTo(self)
			make.left.equalTo(self).offset(15)
			make.bottom.equalTo(self).offset(-0.5)
			make.height.equalTo(0.5)
		}
	}
}
