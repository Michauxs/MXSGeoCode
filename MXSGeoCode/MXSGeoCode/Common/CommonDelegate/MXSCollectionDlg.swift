//
//  MXSCollectionDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 27/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSCollectionDlg: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	var queryData : Array<Any>?
	var itemSize : CGSize?
	var cellName : String?
	var controller : MXSBaseVC?
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if queryData != nil {
			MXSLog(queryData as Any, "collection dlg")
			return (queryData?.count)!
		} else {
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell:MXSCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName!, for: indexPath) as! MXSCollectionViewCell
		cell.cellData = queryData?[indexPath.row]
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		controller?.collectionSelectedRowAt(indexPath)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return itemSize!
	}
	
	
	//MARK:scrollview
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offset_y = scrollView.contentOffset.y
		controller?.tableDidScroll(offset_y: offset_y)
	}
	
}
