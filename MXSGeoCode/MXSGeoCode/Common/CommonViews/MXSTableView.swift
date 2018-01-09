//
//  MXSTableView.swift
//  MXSSwift
//
//  Created by Alfred Yang on 22/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
//import Refresher

class MXSTableView: UITableView {

	var dlg : MXSTableDlg?
	
	override init(frame: CGRect, style: UITableViewStyle) {
		super.init(frame: .zero, style: style)
		backgroundColor = UIColor.lightBlack
		separatorStyle = .none
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/*
	*不设置rowHeight:使用默认64，设置为0:使用自动高度的cell
	*/
	func register(cellName:String, delegate:MXSTableDlg, vc:MXSBaseVC, rowHeight:CGFloat = 64) {
		
		//获取命名空间
		let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
		let cellClass : AnyClass = NSClassFromString(namespace + "." + cellName)!
		register(cellClass, forCellReuseIdentifier: cellName)
//		register(MXSHomeCell.classForCoder(), forCellReuseIdentifier: cellName)
		
        if rowHeight == 0 {
            estimatedRowHeight = 80;
            self.rowHeight = UITableViewAutomaticDimension;
        }
        
		dlg = delegate
		self.delegate = dlg
		self.dataSource = dlg
		dlg?.controller = vc
		dlg?.cellName = cellName
		dlg?.rowHeight = rowHeight
	}
	
	
}
