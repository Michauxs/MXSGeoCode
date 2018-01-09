//
//  MXSHomeVC.swift
//  MXSGeoCode
//
//  Created by Alfred Yang on 9/1/18.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit
import CoreLocation

class MXSHomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.white
		
		let startBtn = UIButton.init(text: "Start", fontSize: 14, textColor: .black, background: MXSNothing.shared)
		view.addSubview(startBtn)
		startBtn.frame = CGRect.init(x: 50, y: 150, width: 205, height: 50)
		startBtn.addTarget(self, action: #selector(startBtnClick), for: .touchUpInside)
		
    }

	
	//MARK:actions
	@objc func startBtnClick () {
		
		let para = ["token":"bearerffa9837a3811b82f103b76efeafe0f1b", "condition":[]] as [String : Any]
		MXSNetWork.shared.requestRemote(route: MXSNetWork.shared.QueryServices, para: para) { (result) in
			
			let services = result["services"] as! Array<Dictionary<String,Any>>
			
			let mySemaphore = DispatchSemaphore(value: 0)
			
			DispatchQueue(label: "一条线程").async {
				for var dic in services {
					let addr = dic["address"]
					print(addr as Any)
					
					MXSLocationMng.shared.getLocation(addr as! String, completeBlock: { (place) in
						if place is MXSNothing {
							print("no")
						} else {
							print((place as! CLPlacemark).location?.coordinate.latitude as Any)
							print((place as! CLPlacemark).location?.coordinate.longitude as Any)
						}
						mySemaphore.signal()
					})
					
					let _ = mySemaphore.wait(timeout: DispatchTime.now() + 30.0)
				}
			}
		}
	}
	func GCDTest5() {
		//初始化信号量, 计数为三
		let mySemaphore = DispatchSemaphore(value: 1)
		for i in 0...10 {
			print(i)
//			let _ = mySemaphore.wait()  //获取信号量，信号量减1，为0时候就等待,会阻碍当前线程
			let _ = mySemaphore.wait(timeout: DispatchTime.now() + 30.0) //阻碍时等两秒信号量还是为0时将不再等待, 继续执行下面的代码
			DispatchQueue(label: "第一条线程").async {
				for j in 0...4 {
					print("有限资源\(j)")
					sleep(UInt32(3.0))
				}
				print("-------------------")
				mySemaphore.signal()
			}
			
		}
		
	}
    /*
    // MARK: - Navigation
*/
}
