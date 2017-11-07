//
//  PhoneNumberFormatTextField.swift
//  PhoneNumberFormatTextFieldDemo
//
//  Created by ZhangYuan on 2017/11/6.
//  Copyright © 2017年 ZhangYuan. All rights reserved.
//

import UIKit

class PhoneNumberFormatTextField: UITextField {
    
    @IBInspectable var separator: String = "-"
    
    var realPhoneNumber: String? {
        return text?.replacingOccurrences(of: separator, with: "")
    }
    
    fileprivate var isDelete = false
    fileprivate var isPaste = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open func setup() {
        delegate = self
        keyboardType = .numberPad
        clearButtonMode = .whileEditing
        addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
    }
}

// MARK: - TextFieldDidChanged
extension PhoneNumberFormatTextField {
    
    @objc open func textFieldDidChanged(_ textField: UITextField) {
        guard let t = realPhoneNumber, t.characters.count > 0 else { return }
        
        let oldPostion = selectedTextRange?.start
        var postionOffset = 0
        
        var result = t.digitsString
        
        if result.characters.count > 11 {
            result = String(result[..<result.index(result.startIndex, offsetBy: 11)])
        }
        if result.characters.count > 7 {
            if !isDelete && oldPostion == position(from: beginningOfDocument, offset: 8+separator.characters.count) {
                postionOffset += separator.characters.count
            }
            result.insert(contentsOf: separator.characters, at: result.index(result.startIndex, offsetBy: 7))
        }
        if result.characters.count > 3 {
            if !isDelete && oldPostion == position(from: beginningOfDocument, offset: 4) {
                postionOffset += separator.characters.count
            }
            result.insert(contentsOf: separator.characters, at: result.index(result.startIndex, offsetBy: 3))
        }
        
        text = result
        
        
        if isPaste {
            DispatchQueue.main.async {
                self.selectedTextRange = self.textRange(from: self.endOfDocument, to: self.endOfDocument)
            }
        } else {
            let newPostion = position(from: oldPostion ?? endOfDocument, offset: postionOffset)
            selectedTextRange = textRange(from: newPostion ?? endOfDocument, to: newPostion ?? endOfDocument)
        }
    }
}

// MARK: - UITextFieldDelegate
extension PhoneNumberFormatTextField: UITextFieldDelegate {
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        isDelete = (string.characters.count <= 0)
        isPaste = (string.characters.count > 1)
        if realPhoneNumber?.characters.count == 11 && string.characters.count > 0 {
            return false
        }
        return true
    }
}
