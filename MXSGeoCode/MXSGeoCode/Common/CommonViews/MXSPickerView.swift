//
//  MXSPickerView.swift
//  MXSSwift
//
//  Created by Alfred Yang on 25/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSPickerView: UIView {

	public var cancelBtn : UIButton?
	public var saveBtn : UIButton?
	public var titleLabel : UILabel?
	
	public var Bground : UIView?
	public var btmLineLayer : CALayer?
	
	public var picker : UIPickerView?
	public var dlg : MXSPickerDlg?
	weak var controller : MXSBaseVC?
	
	private override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubviews()
	}
	
	//init with controller
	convenience init(vc:MXSBaseVC) {
		self.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
		controller = vc
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupSubviews() {
		backgroundColor = UIColor.clear
		
		Bground = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 192))
		addSubview(Bground!)
		Bground?.backgroundColor = UIColor.lightGray
		
		isUserInteractionEnabled = true
		addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapElse)))
		
		cancelBtn = UIButton.init(text: "Cancel", fontSize: 13, textColor: UIColor.gray, background: MXSNothing.shared)
		Bground?.addSubview(cancelBtn!)
		cancelBtn?.snp.makeConstraints({ (make) in
			make.left.equalTo(Bground!)
			make.top.equalTo(Bground!)
			make.size.equalTo(CGSize.init(width: 50, height: 30))
		})
		cancelBtn?.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
		
		saveBtn = UIButton.init(text: "Save", fontSize: 13, textColor: UIColor.black, background: MXSNothing.shared)
		Bground?.addSubview(saveBtn!)
		saveBtn?.snp.makeConstraints({ (make) in
			make.right.equalTo(Bground!)
			make.top.equalTo(Bground!)
			make.size.equalTo(CGSize.init(width: 50, height: 30))
		})
		saveBtn?.addTarget(self, action: #selector(saveBtnClick), for: .touchUpInside)
		
		picker = UIPickerView.init(frame: CGRect.init(x: 0, y: 30, width: SCREEN_WIDTH, height: 162))
		Bground?.addSubview(picker!)
	}

	//MARK:User Actions
	@objc private func tapElse() {
		hideFromSupView()
	}
	
	@objc func saveBtnClick() {
		hideFromSupView()
		controller?.pickerSave()
	}
	@objc func cancelBtnClick() {
		hideFromSupView()
		controller?.pickerCancel()
	}
	
	//MARK:System Actions
	public func registDelegate (_ dlg:MXSPickerDlg) {
		picker?.delegate = dlg
		picker?.dataSource = dlg
		self.dlg = dlg
	}
	
	public func showInSupView () {
		
		self.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
		UIView.animate(withDuration: 0.25, animations: {
			self.Bground?.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT-192, width: SCREEN_WIDTH, height: 192)
		}) { (complete) in
			
		}
	}
	public func hideFromSupView () {
		
		UIView.animate(withDuration: 0.25, animations: {
			self.Bground?.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 192)
		}) { (complete) in
			self.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
		}
	}
	
}
