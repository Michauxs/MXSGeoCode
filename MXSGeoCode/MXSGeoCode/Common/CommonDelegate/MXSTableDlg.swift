//
//  MXSTableDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

/*
*	子类注意事项：
		1.注册/获取cell都是通过 具体cell类的String，不能使用通用cell基类的名字String， 必须独自实现 cellForRowAt；
		2.自动高度UITableViewAutomaticDimension的cell 不能再实现heightForRowAt，所以此方法交由子类自行实现；
	PS：通用TableView基类的注册方法的rowheight高的设置选项：
		1.设置：即row的高度
		2:不设置：使用方法的默认64
		3.设置为0:即 使用自动高度，此时子类Dlg不用且不能实现方法：heightForRowAt
*/
class MXSTableDlg: NSObject, UITableViewDelegate, UITableViewDataSource {
	
	var queryData : Array<Any>?
	var cellName : String?
	var rowHeight : CGFloat?
	var controller : MXSBaseVC?
	
	
	func changeData(data:Array<Any>) {
		queryData = data
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (queryData?.count)!;
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:MXSTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellName!, for: indexPath) as! MXSTableViewCell
		cell.cellData = queryData?[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		controller?.tableSelectedRowAt(indexPath)
	}
	
	//MARK:scrollview
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offset_y = scrollView.contentOffset.y
		controller?.tableDidScroll(offset_y: offset_y)
	}
}
