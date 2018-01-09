//
//  MXSPickerDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 25/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSPickerDlg: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
	
	var loadData : Array<Any>?
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return loadData?.count ?? 0
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return loadData?[row] as? String
	}
	
}
