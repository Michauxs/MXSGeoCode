//
//  MXSLoadingView.swift
//  MXSSwift
//
//  Created by Alfred Yang on 27/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSBtmAlertView: UIView {

	public var closeBtn : UIButton?
	public var titleLabel : UILabel?
	public var Bground : UIView?
	weak var controller : MXSBaseVC?
	
	let playHeight : CGFloat = 64
	
	override init(frame: CGRect) {
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
		
		Bground = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: playHeight))
		Bground?.backgroundColor = UIColor.dullWhite
		addSubview(Bground!)
		Bground?.isUserInteractionEnabled = true
		Bground?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapBground)))
		
		titleLabel = UILabel.init(text:"Title", fontSize:15, textColor:UIColor.black, alignment:.left)
		titleLabel?.numberOfLines = 2
		Bground?.addSubview(titleLabel!)
		titleLabel?.snp.makeConstraints({ (make) in
			make.left.equalTo(Bground!).offset(15)
			make.centerY.equalTo(Bground!)
		})
		
		closeBtn = UIButton.init(text: "Close", fontSize: 16, textColor: UIColor.black, background: MXSNothing.shared)
		Bground?.addSubview(closeBtn!)
		closeBtn?.snp.makeConstraints({ (make) in
			make.right.equalTo(Bground!).offset(-10)
			make.centerY.equalTo(Bground!)
			make.size.equalTo(CGSize.init(width: 44, height: 44))
		})
		closeBtn?.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
		let line = CALayer.init()
		line.backgroundColor = UIColor.theme.cgColor
		line.frame = CGRect.init(x: 0, y: 43.5, width: 44, height: 0.5)
		closeBtn?.layer.addSublayer(line)
		
		isUserInteractionEnabled = false
		addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapElse)))
	}
	
	//MARK:Actions
	@objc func tapBground(){
		//避免点击底部bg时回弹alert
	}
	
	@objc func tapElse() {
		hideAlert()
	}
	
	@objc func closeBtnClick() {
		hideAlert()
	}
	
	func hideAlert() {
		isUserInteractionEnabled = false
		UIView.animate(withDuration: 0.25, animations: {
			self.Bground?.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: self.playHeight)
		}) { (complete) in
			self.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
			self.controller?.hideBtmAlertComplete((self.titleLabel?.text)!)
		}
	}
	
	func showAlert() {
		self.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
		UIView.animate(withDuration: 0.25, animations: {
			self.Bground?.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT-self.playHeight, width: SCREEN_WIDTH, height: self.playHeight)
		}) { (complete) in
			self.isUserInteractionEnabled = true
		}
	}
}
