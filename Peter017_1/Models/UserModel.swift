//
//  UserModel.swift
//  Peter017_1
//
//  Created by DONG SHENG on 2022/7/27.
//

import Foundation

struct UserModel: Hashable{
    let name: String    // 用戶名稱 (直接與圖片共用 也能另外宣告一個 userImage)
    let ago: Int        // 幾小時前(發文)
    let contentText: String? // 內文
    let contentImage: String?
}
