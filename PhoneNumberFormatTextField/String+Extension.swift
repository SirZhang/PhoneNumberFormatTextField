//
//  String+Extension.swift
//  PhoneNumberFormatTextFieldDemo
//
//  Created by ZhangYuan on 2017/11/7.
//  Copyright © 2017年 ZhangYuan. All rights reserved.
//

import Foundation

extension String {
    //除去非数字字符
    var digitsString: String {
        var result = ""

        enumerated().forEach { (index, item) in
            if "0" <= item && item <= "9" {
                result.append(item)
            }
        }
        
        return result
    }
}
