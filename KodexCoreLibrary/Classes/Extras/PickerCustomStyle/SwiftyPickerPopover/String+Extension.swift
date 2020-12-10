//
//  String+Extension.swift
//  SwiftyPickerPopover
//
//  Created by J Aiden on 2017/07/24.
//  Copyright © 2017年 Yuta Hoshino. All rights reserved.
//

import Foundation


extension String {
    func removeWhitespacesInBetween() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}
