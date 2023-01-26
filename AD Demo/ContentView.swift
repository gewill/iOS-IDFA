//
//  ContentView.swift
//  AD Demo
//
//  Created by will on 2023/1/21.
//

import AdSupport
import AppTrackingTransparency
import SwiftUI

struct ContentView: View {
    @State var statusString: String = ""
    @State var idfa: String = ASIdentifierManager.shared().advertisingIdentifier.uuidString
    var body: some View {
        ScrollView {
            VStack {
                Button {
                    ATTrackingManager.requestTrackingAuthorization { status in
                        switch status {
                        case .denied:
                            statusString = "用户拒绝"
                        case .authorized:
                            statusString = "用户允许"
                            idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                        case .notDetermined:
                            statusString = "用户没有选择"
                        default:
                            break
                        }
                    }
                } label: {
                    Text("获取追踪权限和IDFA")
                }
                .buttonStyle(.bordered)

                Text("设置->隐私->追踪->当前App")

                Divider()
                VStack(alignment: .leading) {
                    Text("追踪权限：").font(.headline) + Text("\(statusString)")
                    HStack {
                        Text("IDFA：").font(.headline)
                            + Text("\(idfa)")
                        if idfa.isEmpty == false {
                            Button {
                                UIPasteboard.general.string = idfa
                            } label: {
                                Text("复制")
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
