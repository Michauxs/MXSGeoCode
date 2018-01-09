//
//  String+Extension.swift
//  MXSSwift
//
//  Created by Alfred Yang on 21/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import Foundation

extension String {
	
	static func MD5String () -> String {
		
		let identifier = CFUUIDCreate(nil)
		let identifierString = CFUUIDCreateString(nil, identifier) as String
		let cStr = identifierString.cString(using: .utf8)
		
		var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
		
		CC_MD5(cStr, CC_LONG(strlen(cStr)), &digest)
		
		var output = String()
		
		for i in digest {
			
			output = output.appendingFormat("%02X", i)
		}
		
		return output;
	}
	
//	作者：流火绯瞳
//	链接：http://www.jianshu.com/p/b7f2a6912f4c
//	來源：简书
//	著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
}
