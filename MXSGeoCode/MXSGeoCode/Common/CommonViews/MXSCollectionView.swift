//
//  MXSCollectionView.swift
//  MXSSwift
//
//  Created by Alfred Yang on 27/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSCollectionView: UICollectionView {

	var dlg : MXSCollectionDlg?

	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		showsVerticalScrollIndicator = false
		showsHorizontalScrollIndicator = false
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func register(cellName:String, delegate:MXSCollectionDlg, vc:MXSBaseVC, itemSize:CGSize) {
		//获取命名空间
		let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
		let cellClass : AnyClass = NSClassFromString(namespace + "." + cellName)!
		register(cellClass, forCellWithReuseIdentifier: cellName)
		
		dlg = delegate
		self.delegate = dlg
		self.dataSource = dlg
		dlg?.controller = vc
		dlg?.cellName = cellName
		dlg?.itemSize = itemSize
		
		// 告诉编译器它的真实类型
//		let viewControllerClass = cellClass as! UIViewController.Type
//		let viewController = viewControllerClass.init()
	}
}
