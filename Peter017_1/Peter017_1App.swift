//
//  Peter017_1App.swift
//  Peter017_1
//
//  Created by DONG SHENG on 2022/7/27.
//

import SwiftUI

@main
struct Peter017_1App: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(HomeViewModel())
                .onAppear{
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutUnsatisfiable") // 抑制錯誤警告
                }
        }
    }
}
