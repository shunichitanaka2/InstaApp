//
//  LogUtils.swift
//  MealPix
//
//  Created by KazumaKamiaka on 2016/08/15.
//  Copyright © 2016年 aihara hidehiko. All rights reserved.
//

import Foundation
//ログ出力
func Log(message: String,
         function: String = #function,
         file: String = #file,
         line: Int = #line) {
    //#if DEBUG
        let cells = file.componentsSeparatedByString("/")
        let fileName = cells[cells.count-1]
        print("INPUT \"\(message)\" (File: \(fileName), Function: \(function), Line: \(line))")
    //#elseif DEBUG_STAGING
        //print("INPUT \(message)")
    //#else
    //#endif
}

//関数呼び出しトレース用ログ出力
func LogTrace(function: String = #function,
              file: String = #file,
              line: Int = #line) {
    //#if DEBUG
        let cells = file.componentsSeparatedByString("/")
        let fileName = cells[cells.count-1]
        print("File: \(fileName), Function: \(function), Line: \(line))")
    //#elseif DEBUG_STAGING
    //#else
    //#endif
}