//
//  HomeViewModel.swift
//  Peter017_1
//
//  Created by DONG SHENG on 2022/7/27.
//

import SwiftUI

class HomeViewModel: ObservableObject{
    
    @Published var image: UIImage?
    @Published var showPicker = false   // 控制 sheet的顯示
    @Published var source: Picker.Source = .library
    @Published var showCameraAlert = false
    @Published var cameraError: Picker.CameraErrorType?
    
    // 檢查設備的權限及鏡頭
    func showPhotoPicker(){
        do{
            if source == .camera{
                try Picker.checkPermissions()
            }
            showPicker = true // 這邊有執行代表成功(可以使用)
        } catch {
            showCameraAlert = true
            cameraError = Picker.CameraErrorType(error: error as! Picker.PickerError)
        }
    }
    // - - - - - - - - - - - - - - - - 以上相機 - - - - - - - - - - - - - - - - -
    
    @Published var users: [UserModel] = []
    
    let comment1: [String] = ["很醜","很友善","很滑稽","無厘頭","很心機","講義氣","很健談","自律","愛吵架"] // 同性覺得你
    let comment2: [String] = ["人很好","很機車","長得幽默","很老實","阿里不達","幽默風趣","善解人意","才華洋溢"]  // 異性覺得你
    
    var enoji: [String] = []
    
    func fetchUsers(){
        
        self.users.removeAll() // 避免 從NavigationLink Back時一直重複添加
        
        let user1 = UserModel(name: "Kevin Durant", ago: 1, contentText: "KD : KD是最強的！", contentImage: nil)
        let user2 = UserModel(name: "馬雲", ago: 5, contentText: "當你成功的時候，你說的所有話都是真理", contentImage: nil)
        let user3 = UserModel(name: "羅時豐", ago: 9, contentText: "趕貓用斯斯～ 咳嗽用斯斯～ ", contentImage: "羅時豐1")
        let user4 = UserModel(name: "Kevin Durant", ago: 16, contentText: "KD : 除了KD 隊友都是小貓", contentImage: nil)
        let user5 = UserModel(name: "QoolQuiz", ago: 11, contentText: "測你給人什麼樣的感覺？", contentImage: "Image5")
        let user6 = UserModel(name: "Archimedes", ago: 16, contentText: "Give me a place to stand on,and I will move the Earth.", contentImage: "Image6")
        let user7 = UserModel(name: "李白", ago: 3, contentText: nil, contentImage: "Image7")
        let user8 = UserModel(name: "李榮浩", ago: 2, contentText: "如果能重來 我要選李白", contentImage: "Image8")
        let user9 = UserModel(name: "Steve Jobs", ago: 12, contentText: nil, contentImage: "Image9")
        
        self.users.append(contentsOf: [user1 ,user2 ,user3 ,user4 ,user5 ,user6 ,user7 ,user8 ,user9])
        self.users.shuffle() // 打亂
    }
    
    func fetchEmoji() -> [String] {
        self.enoji.removeAll()
        self.enoji.append(contentsOf: ["愛心","笑死","讚","怒","哭臉"])
        self.enoji.shuffle() // 打亂
        // 已經打亂後可以隨機刪除2個
        // 也可以刪除頭尾 .first .last
        self.enoji.remove(at: Int.random(in: 0...enoji.count - 1))
        self.enoji.removeLast()
        print(enoji)
        
        return enoji
    }
    
    // 評語
    func fetchComment(comment: [String]) -> [String]{
        let commentString = comment.randomElement()?.map{ String($0) } ?? ["真","棒"]
        return commentString
    }
    
}
