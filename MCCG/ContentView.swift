//
//  ContentView.swift
//  MCCG
//
//  Created by Ling6079 on 2021/12/20.
//

import SwiftUI
import Combine
import AudioToolbox
struct FriendList: Hashable {
    let id : Int
    let name: String
    var filter: String
    var getGift: String?
    var mimeGift: String
    var giftOpen :Bool

}

let test = [FriendList(id: 0, name: "te1", filter: "", getGift: nil, mimeGift:"1",giftOpen:false),
            FriendList(id: 0, name: "te2", filter: "", getGift: nil, mimeGift:"3",giftOpen:false),
            FriendList(id: 0, name: "te3", filter: "1", getGift: nil, mimeGift:"5",giftOpen:false),
            FriendList(id: 0, name: "te4", filter: "", getGift: nil, mimeGift:"7",giftOpen:false),
            FriendList(id: 0, name: "te5", filter: "", getGift: nil, mimeGift:"9",giftOpen:false),
            FriendList(id: 0, name: "te6", filter: "", getGift: nil, mimeGift:"11",giftOpen:false),
            FriendList(id: 0, name: "te7", filter: "3", getGift: nil, mimeGift:"12",giftOpen:false),
            FriendList(id: 0, name: "te8", filter: "", getGift: nil, mimeGift:"10",giftOpen:false),
            FriendList(id: 0, name: "te9", filter: "", getGift: nil, mimeGift:"8",giftOpen:false),
            FriendList(id: 0, name: "te10", filter: "4", getGift: nil, mimeGift:"13",giftOpen:false),
            FriendList(id: 0, name: "te11", filter: "", getGift: nil, mimeGift:"6",giftOpen:false),
            FriendList(id: 0, name: "te12", filter: "", getGift: nil, mimeGift:"4",giftOpen:false),
            FriendList(id: 0, name: "te13", filter: "5", getGift: nil, mimeGift:"2",giftOpen:false),
]

struct ContentView: View {
    
    @State var friendList:[FriendList] = test
    @State var addCount: Int=0
    @State var isInsertView: Bool = false
    @State var friendName: String=""
    @State var friendCompanion: String=""
    @State var giftId:String=""
    @State var yourGift:String=""
    @State var btn_AfterStart:Bool=true;
    @State var btn_OpenYourGift:Bool = true
    @State var openAlert:Bool=false;
    @State var reStartAlert:Bool=false;
    @State var StartAlert:Bool=false
    @State var repeatAlert:Bool=false
    
    @State var animalBear: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    
    //@State var isControlView: Bool = false
    var body: some View {
        VStack(spacing: 50) {
            VStack{
                Image("bear2")
                    .resizable()
                    .frame(width: 100, height: 100)
            }.frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .trailing)
                .offset(x: animalBear ? (UIScreen.main.bounds.width)-100 : 0)
                .animation(Animation.linear(duration: 1).repeatCount(3))
            /* title view */
            //titleView().frame(height: 80)
            
            /* body view */
            Button(action: {
                self.handleAdd()
                
            }, label: {
                Text("名單新增＋")
                    .font(.body.bold())
                    .foregroundColor(Color.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(btn_AfterStart == true ? Color.black:Color.gray)
                    .cornerRadius(12)
                    .shadow(color: Color.gray, radius: 3)
            }).disabled(btn_AfterStart == true ? false : true)
            VStack{
                ScrollView{
                        VStack {
                            ForEach(0..<friendList.count, id: \.self) { index in
                                HStack {
                                    Button(action: {
                                        self.handleDelete(index: index)

                                    }, label: {
                                        Image(systemName: "multiply.circle")
                                            .resizable()
                                            .frame(width:25, height: 25)
                                            
                                    }).disabled(btn_AfterStart == true ? false : true)
                                    
                                    
                                    if btn_OpenYourGift == true{
                                        Text("\(friendList[index].name)(\(friendList[index].mimeGift))")
                                            .frame(width: UIScreen.main.bounds.width / 5, alignment: .leading)
                                    }
                                    else{
                                        Text("\(friendList[index].name)()")
                                            .frame(width: UIScreen.main.bounds.width / 5, alignment: .leading)
                                    }
                                    
                                    
                                    
                                    
                                    
                                    Text("\(friendList[index].filter == "" ? "未攜伴": "攜伴:\(friendList[index].filter)")")
                                        .frame(width: UIScreen.main.bounds.width / 7, alignment: .leading)
                                    if friendList[index].giftOpen == true{
                                        Text("\(friendList[index].getGift ?? "")")
                                            .frame(width: UIScreen.main.bounds.width / 7, alignment: .leading)
                                    }
                                    else{
                                        if btn_AfterStart == false{
                                        Image(systemName: "gift.fill")
                                            .resizable()
                                            .frame(width:25, height: 25)}
                                    }
                                    Spacer()
                                    
                                    Button(action: {
                                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {
                                            self.handleOppen(index: index)
                                        }
                                       

                                    }, label: {
                                        Text("打開")
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.white)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal,15)
                                            .background(friendList[index].giftOpen == false ? Color.blue : Color.gray)
                                            .cornerRadius(12)
                                            .shadow(color: Color.gray, radius: 3)
                                    }) .alert("笑你", isPresented: $openAlert, actions: {
                                        Button("OK") { }
                                    }, message: {
                                        Text("還沒交換就想打開啊～")
                                    })
                        
                                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                   

                            
                        }
                    
                    }
                }.padding(.horizontal,15)
            }
            VStack{
                Button(action: {
                    self.handleStart()
                    
                   

                    
                }, label: {
                    Text("開始")
                        .font(.body.bold())
                        .foregroundColor(Color.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(btn_AfterStart == true ? Color.black : Color.gray)
                        .cornerRadius(12)
                        .shadow(color: Color.gray, radius: 3)
                }).alert("提示", isPresented: $StartAlert, actions: {
                    Button("確定") { self.handleStart_Action()
                        
                    }
                    Button("取消") {  }
                }, message: {
                    Text("確定要開始交換禮物嘛？")
                    
                        
            }).disabled(btn_AfterStart == true ? false : true)
                    
                    .alert("警告", isPresented: $repeatAlert, actions: {
                        Button("OK") {}
                    }, message: {
                        Text("有人禮物代碼重複")
                    })
                        
                        
                        
                        
                        
                Button(action: {
                    self.handleReStart()
                }, label: {
                    Text("重新")
                        .font(.body.bold())
                        .foregroundColor(Color.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.black)
                        .cornerRadius(12)
                        .shadow(color: Color.gray, radius: 3)
                }).alert("提示", isPresented: $reStartAlert, actions: {
                    Button("確定") { self.handleReStart_Action()
                        
                    }
                    Button("取消") {  }
                }, message: {
                    Text("確定要重新嘛？")
            })
            }
            VStack{
                
                Button(action: {
                    self.openGiftId()
                }, label:{
                    Image("bear")
                        .resizable()
                        .frame(width: 100, height: 100)
                        })
            }
            .frame(minWidth: 0,maxWidth: .infinity,alignment: .trailing)
            .offset(x: animalBear ? (-UIScreen.main.bounds.width)+100 : 0)
            .animation(Animation.linear(duration: 1).repeatCount(3))
            //  (-UIScreen.main.bounds.width)+100
          
        
    }.fullScreenCover(isPresented: $isInsertView, content: {
        InsertView(friendName: $friendName, friendCompanion: $friendCompanion,friendList: $friendList, yourGift: $yourGift, addCount: $addCount)
    })
        
        
    }
}
extension ContentView {
    /* func ... */
    
    func openGiftId(){
        btn_OpenYourGift = !btn_OpenYourGift
        
    }
    
    func handleAdd() {
        friendName=""
        friendCompanion=""
        yourGift=""
        isInsertView.toggle()
       
    }
   func handleStart(){
        StartAlert = true
    }
    func handleStart_Action() {
        
        
        var companionArry: [Int]=[]
        var yourGiftArry:[Int]=[]
        
        for index in 0..<friendList.count {
            if friendList[index].filter == "" {
                friendList[index].filter = "0"
            }
            var yourGiftCount = Int(friendList[index].mimeGift)
                yourGiftArry.append(yourGiftCount!)
            var companionCount = Int(friendList[index].filter)
                companionArry.append(companionCount!)
        }
        var repeat_:Bool = checkRepeat(array2: companionArry,array3:yourGiftArry)//檢查自己禮物代碼是否重複填寫
        if repeat_ == true{
            repeatAlert = true
        }
        if repeat_ == false{
            animalBear.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.3){
            btn_OpenYourGift = false
            btn_AfterStart = false
        for index in 0..<friendList.count {
            var randomCount:Int = 0
            var randomArray = Int.random(in: 1...friendList.count, count: friendList.count)
            for index in 0..<9999 {
                var result:Bool = checkArray(array1: randomArray, array2: companionArry,array3:yourGiftArry)
                if result==false{
                    break
                }
                randomArray = Int.random(in: 1...friendList.count, count: friendList.count)
            }
            for index in 0..<randomArray.count {
                randomCount = randomArray[index]
                friendList[index].getGift = "取得: \(randomCount)"
            }
        }
        }
    }
    }
    func checkArray(array1: Array<Int>, array2: Array<Int>,array3:Array<Int>) -> Bool {//判斷是否重新產生亂數
        var result:Bool=false
        
        for i in 0..<array1.count {
            if array1[i] == array2[i]{
                result = true
            }
            if array1[i] == array3[i]{
                result = true
            }
        }
        return result
    }
    func checkRepeat(array2: Array<Int>,array3:Array<Int>)-> Bool{
        var repeat_:Bool=false
        var newArray: [Int] = []
        print(array3)
        for value in array3 {
            if (newArray.contains(value)) {
                repeat_ = true
                continue
            }
            newArray.append(value)
        }
        print(repeat_)
       return repeat_
    }
    
    
    
    func random(){
//        var number = Int.random(in: 1...friendList.count )
//            if number
    }
       
    
    
    
    func  handleOppen(index: Int){
        
    
        
        
        if btn_AfterStart == false{
            friendList[index].giftOpen = true
        }
        else{
            openAlert=true
        }
       
            
        
            
    }
    func handleDelete(index: Int){
        friendList.remove(at: index)
    }
    func handleReStart(){
        reStartAlert = true
        btn_AfterStart = true
        
    }
    func handleReStart_Action(){
        friendList.removeAll()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct InsertView: View {
    @Binding var friendName: String
    @Binding var friendCompanion: String
    @Binding var friendList:[FriendList]
    @Binding var yourGift:String
    @Binding var addCount: Int
    @Environment(\.presentationMode) var presentationMode
    @State var requiredAlert:Bool=false
    @State var requiredAlert2:Bool=false
    var body: some View {
        ZStack{
            Color.gray.edgesIgnoringSafeArea(.all)
            VStack{
                
                Spacer()
                Text("新增人員名單")
                TextField("請輸入名稱", text: $friendName)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 2)
                    ).frame(width: 250)
                    .shadow(color: Color.gray, radius: 3)

                TextField("請輸入伴侶禮物代號", text: $friendCompanion)
                    .keyboardType(.numberPad)
                    .onReceive(Just(friendCompanion)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.friendCompanion = filtered
                        }
                }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 2)
                    ).frame(width: 250)
                    .shadow(color: Color.gray, radius: 3)
                TextField("請輸入自己禮物代碼", text: $yourGift)
                    .keyboardType(.numberPad)
                    .onReceive(Just(friendCompanion)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.friendCompanion = filtered
                        }
                }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 2)
                    ).frame(width: 250)
                    .shadow(color: Color.gray, radius: 3)
                    
                Spacer()
                Divider()
                
                HStack{
                    Button(action: {
                        self.handleInsert()
                    }, label: {
                        Text("開始")
                            .font(.body.bold())
                            .foregroundColor(Color.blue)
                            .frame(minWidth: 0 ,maxWidth:.infinity)
                        
                    }).alert("提示", isPresented: $requiredAlert, actions: {
                        Button("OK") { }
                    }, message: {
                        Text("自己的禮物代碼要填喔～")
                    })
                        .alert("提示", isPresented: $requiredAlert2, actions: {
                            Button("OK") { }
                        }, message: {
                            Text("名稱要填喔～")
                        })
                    Divider().frame(height:50 )
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("取消")
                            .font(.body.bold())
                            .foregroundColor(Color.blue)
                            .frame(minWidth: 0 ,maxWidth:.infinity)
                    })
                }
                
                
                
                
                
            }.frame(width: 300, height: 300)
            .background(Color.white)
            .cornerRadius(12)
        }
    }
    
}
extension InsertView {
    func handleInsert(){
       
        if yourGift == ""{
            requiredAlert=true
        }
        if friendName == ""{
            requiredAlert2=true
        }
        else{
            if friendName != ""{
                addCount=addCount+1
                //friendList.append(FriendList(id: addCount, name:friendName , filter: friendCompanion))
                friendList.append(FriendList(id: addCount, name:friendName , filter: friendCompanion, getGift: nil,  mimeGift: yourGift,giftOpen: false))
                
            }
            presentationMode.wrappedValue.dismiss()
        }
       
    }

}
extension Int {
    static func random(in range: ClosedRange<Int>, excluding data: [Int]?) -> Int {
        let random = Int.random(in: range)
        if data?.contains(random) ?? false {
            return Int.random(in: range, excluding: data)
        }
        return random
    }
    
    static func random(in range: ClosedRange<Int>, count: Int) -> [Int] {
        
        var randomValue = [Int]()
        while randomValue.count < count {
            randomValue.append(Int.random(in: range, excluding: randomValue))
        }
        return randomValue
    }
}

struct PageLoadView: View {
    @State private var logoDelayToogle = false
    var body: some View {
               if logoDelayToogle {
                   PageStartView()
               }else {
                   /* 這邊只為了 Logo 所呈現的 畫面 */
                   VStack{
                               Image("bear3")
                                   .resizable()
                                   .edgesIgnoringSafeArea(.all)
                   //                .resizable()
                                   //.frame(width: 500, height: 500)
                                   .scaledToFill()
                                   .offset(x: -20)
                           }
                       .onAppear(perform: {
                           // 只讓它顯示 logo View
                           DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                               withAnimation(.default) {
                                   logoDelayToogle = true
                               }
                               
                           }
                       })
               } // end if

    }
}
struct PageLoadView_Previews: PreviewProvider {
    static var previews: some View {
        PageLoadView()
    }
    
}
struct PageStartView: View {
    @State var isContentView: Bool = false
    var body: some View {
        ZStack{
            
            Image("bear4")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            VStack {
                
                Image("gift")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .offset(y:30)
                
                Button(action: {
                    self.handlEnter()
                }, label: {
                    Text("交換禮物")
                        .font(.body.bold())
                        .foregroundColor(Color.white)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 100)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .shadow(color: Color.gray, radius: 3)
                })
            }.frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
        }.fullScreenCover(isPresented: $isContentView, content: {
            ContentView()
            
        })
    }
}
extension PageStartView {
    func handlEnter()
    {
        isContentView.toggle()
    }
    
}
struct PageStartView_Previews: PreviewProvider {
    static var previews: some View {
        PageStartView()
    }
    
}
