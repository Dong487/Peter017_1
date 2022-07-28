//
//  HomeView.swift
//  Peter017_1
//
//  Created by DONG SHENG on 2022/7/27.
//

// 仿FB 滑動頁面 (有些顯示只用Text 可以改成Button)
// 基本拍照功能 + 選取相簿中的相片 ->來做假的FB算命
// iOS 16 才能使用.toolBarBackground(.red, in: .navigationBar)

// 待學習 toolBar 無法延伸至topSafeArea

// 要注意 .background 跟 .Zstack 的運用 以及.frame框架限制

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    
    init(){
        // 注意 UIColor 有 alpha
//        UINavigationBar.appearance().backgroundColor = UIColor(red: 57 / 255, green:  117 / 255, blue: 232 / 255, alpha: 1)
    }
    
    var body: some View {
        NavigationView {

            ScrollView(showsIndicators: false){
                VStack{
                    ForEach(viewModel.users ,id: \.self){ user in
                        if user.name == "QoolQuiz"{
                            NavigationLink {
                                MainView
                            } label: {
                                MockView(name: user.name, ago: user.ago, contentText: user.contentText, contextImage: user.contentImage)
                            }
                            
                        } else {
                            MockView(name: user.name, ago: user.ago, contentText: user.contentText, contextImage: user.contentImage)
                        }
                    }
                }
                .background(.gray)
            }
            .background(Color(red: 57 / 255, green:  117 / 255, blue: 232 / 255))
            
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                // 無法延伸至 topSafeArea
                ToolbarItem(placement: .principal) {
                    Text("Facebook")
                        .bold()
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.6), radius: 0.5, x: 1, y: 1)
                        .shadow(color: Color(red: 57 / 255, green:  117 / 255, blue: 232 / 255).opacity(0.7), radius: 6, x: 1, y: 1)
                }
            }
            .onAppear {
                viewModel.image = nil // 從NavigationLink Back 清空圖片
                
                viewModel.fetchUsers()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}

extension HomeView{
    
    // 第一頁 模擬FaceBook的發文 單個View
    private func MockView(name: String ,ago: Int ,contentText: String? ,contextImage: String?) -> some View {
        VStack{
            HStack{
                Image(name)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width / 10, height: UIScreen.main.bounds.width / 10)
       
                VStack(alignment: .leading){
                    
                    Text(name)
                        .font(.headline.bold())
                    
                    HStack{
                        Text("\(ago)小時 ·")
                            .font(.body)
                            .foregroundColor(.gray)
                        
                        Image(systemName: "globe.asia.australia.fill")
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
            }
            .padding(12)
            
            // 內文
            VStack {
                HStack {
                    Text(contentText ?? "")
                        .font(.title3)
                        .frame(alignment: .leading)
                    Spacer()
                }
                
                if contextImage != nil{
                    Image(contextImage ?? "")
                        .resizable()
                        .frame(maxHeight: UIScreen.main.bounds.width - 50)
                }
           
            }
            .padding(.horizontal ,20)
            .padding(.bottom ,12)

            Spacer()
     
            // 表情符號 + XXX則留言 分享 瀏覽?
            HStack(spacing: 6){
                // 為了部份達到重疊效果 所以 spacing 設為 負數
                HStack(spacing: -3){
                    ForEach(viewModel.fetchEmoji() ,id: \.self){ item in
                        Image(item)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .background(
                                // 集合的地方會比較有層次感
                                Circle()
                                    .fill(.white)
                                    .frame(width: 23,height: 23)
                            )
                    }
                }
                .padding(.leading ,12)
                
                Text("\(Int.random(in: 999...10000))")
                
                Spacer()
                
                Text("\(Int.random(in: 1...1234))則留言")
                Text("\(Int.random(in: 1...99))分享")
                Text("\(Double.random(in: 1...7) , specifier: "%.1f")萬次瀏覽")
                    .padding(.trailing ,6)
                
            }
            .font(.caption)
            .foregroundColor(.gray)
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width * 0.95, height: 0.7)
        
            HStack{
                
                Image(systemName: "hand.thumbsup.fill")
                    .foregroundColor(name == "Kevin Durant" ? .blue : .gray)
                Text("讚")
                    .foregroundColor(name == "Kevin Durant" ? .blue : .gray)
                
                Spacer()
                
                Image(systemName: "bubble.left.fill")
                Text("留言")
                
                Spacer()
                
                Image(systemName: "arrowshape.turn.up.right.fill")
                Text("分享")
            }
            .foregroundColor(.gray)
            .padding(.horizontal ,40)
            .padding(.bottom ,8)
            .padding(6)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(.white)
    }
    
    // 第二頁NavigationLink 做測驗用
    private var MainView: some View{
        ZStack {
            Color.white.ignoresSafeArea()
            VStack{
                
                HStack {

                    Image("QoolQuizTitle")
                       .resizable()
                       .scaledToFit()
                       .frame(width: UIScreen.main.bounds.width)
                       .frame(maxHeight: 75)
                       .offset(x: -75)
                  
                }
                .background(
                     Color(red: 229 / 255, green: 157 / 255, blue: 162 / 255)
                         .frame(width: UIScreen.main.bounds.width)
                         .frame(maxHeight: 85)
                )
                   
                VStack {
                    
                    Text("測你給人什麼樣的感覺？")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width)
                        .frame(maxHeight: 50)
                        .background(Color(red: 54 / 255 ,green: 54 / 255 ,blue: 54 / 255).frame(maxHeight: UIScreen.main.bounds.height / 3)) // 灰黑
                    
                    // 測驗結果
                    if let image = viewModel.image {
                        HStack(alignment: .top,spacing: 0){
                            VStack(spacing: 3){
                                Text("同性覺得你")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(height: UIScreen.main.bounds.height / 17)
                                    .frame(width: (UIScreen.main.bounds.width - 20) / 4 )
                                    .background(Color(red: 44 / 255, green: 102 / 255, blue: 177 / 255)) // 偏藍
                                
                                VStack(spacing: 2) {
                                    ForEach(viewModel.fetchComment(comment: viewModel.comment1) ,id: \.self){
                                        Text($0)
                                            .font(.largeTitle.bold())
                                    }
                                }

                            }
                           
                            VStack {
                                Spacer()
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(minWidth: 0 ,maxWidth: .infinity)
                                Spacer()
                            }
                            
                            VStack(spacing: 3){
                                Text("異性覺得你")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(height: UIScreen.main.bounds.height / 17)
                                    .frame(width: (UIScreen.main.bounds.width - 20) / 4 )
                                    .background(Color(red: 209 / 255, green: 45 / 255, blue: 82 / 255)) // 偏紅

                                VStack(spacing: 2) {
                                    ForEach(viewModel.fetchComment(comment: viewModel.comment2) ,id: \.self){
                                        Text($0)
                                            .font(.largeTitle.bold())
                                    }
                                }
                            }
                        }
                    } else {
                        // 還沒開始測驗
                        VStack {
                            Image(systemName: "photo.fill")
                                              .resizable()
                                              .scaledToFit()
                                              .frame(minWidth: 0 ,maxWidth: .infinity)
                                              .padding(.horizontal)
                                              .padding()
                        }
                    }
                    
                }
                .frame(width: UIScreen.main.bounds.width)
                .frame(maxHeight: UIScreen.main.bounds.height / 3)
                .background(Color(red: 0.99, green: 0.99, blue: 154 / 255).frame(maxHeight: UIScreen.main.bounds.height / 3))
                
                // 還沒開始測驗
                if viewModel.image == nil {
                    VStack{
                        Button {
                            viewModel.source = .camera
                            viewModel.showPhotoPicker() // 多一層檢查
        
                        } label: {
                            Text("拍攝照片")
                        }

                        Button {
                            viewModel.source = .library
                            viewModel.showPhotoPicker()
                        } label: {
                            Text("從相簿中選取")
                        }
                    }
                    .font(.title)
                    
                } else {
                    // 有圖片後(測驗完後show)
                    Button {
                        // 清空圖片
                        viewModel.image = nil
                    } label: {
                        Text("重新測驗")
                            .font(.largeTitle)
                    }
                }
                
                Spacer()
                
                HStack{
                    Image("QoolQuiz")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width / 13, height: UIScreen.main.bounds.width / 13)
                    Text("QoolQuiz的貼文")
                    
                    Spacer()
                    
                    HStack(spacing: -3){
                        ForEach(viewModel.fetchEmoji() ,id: \.self){ item in
                            Image(item)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .background(
                                    // 集合的地方會比較有層次感
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 23,height: 23)
                                )
                        }
                    }
                    Text("\(Int.random(in: 99...2000))")
                    
                    HStack(spacing: 2){
                        Image(systemName: "bubble.left.circle.fill")
                            .scaledToFit()
                            .foregroundColor(.green)
                            .frame(width: 25, height: 25)
                        
                        Text("\(Int.random(in: 6...100))")
                    }
                }
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal ,12)
                .padding(.bottom ,6)
                
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.gray)
                    .frame(width: UIScreen.main.bounds.width * 0.95, height: 0.7)
            
                HStack{
                    
                    Image(systemName: "hand.thumbsup.fill")
                        
                    Text("讚")
                    
                    Spacer()
                    
                    Image(systemName: "bubble.left.fill")
                    Text("留言")
                    
                    Spacer()
                    
                    Image(systemName: "arrowshape.turn.up.right.fill")
                    Text("分享")
                }
                .foregroundColor(.gray)
                .padding(.horizontal ,40)
                .padding(.bottom ,8)
                .padding(6)
            }
            .sheet(isPresented: $viewModel.showPicker) {

            } content: {
                ImagePicker(sourceType: viewModel.source == .library ? .photoLibrary : .camera, selectedImage: $viewModel.image)
                    .ignoresSafeArea()
            }
            .alert("Error!", isPresented: $viewModel.showCameraAlert, presenting: viewModel.cameraError, actions: { cameraError in
                cameraError.button
            }, message: { cameraError in
                Text(cameraError.message)
            })
        }
    }
}
