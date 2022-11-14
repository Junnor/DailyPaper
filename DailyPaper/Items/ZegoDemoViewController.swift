//
//  ZegoPlayViewController.swift
//  DailyPaper
//
//  Created by ys on 2022/11/11.
//

import UIKit
import ZegoExpressEngine

// https://doc-zh.zego.im/article/7628

class ZegoDemoViewController: UIViewController {
    
    private lazy var remoteUserView: UIView = {
        let item = UIView(frame: CGRect(x: 100, y: 100, width: 180, height: 250))
        item.backgroundColor = .lightGray
        return item
    }()
    
    private lazy var startVideoTalkButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 100, y: UIDevice.screenHeight-280, width: 150, height: 50)
        button.setTitle("开始通话", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(startVideoTalk), for: .touchUpInside)
        return button
    }()
    
    private lazy var stopVideoTalkButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 100, y: UIDevice.screenHeight-200, width: 150, height: 50)
        button.setTitle("停止通话", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(stopVideoTalk), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(remoteUserView)
        view.addSubview(startVideoTalkButton)
        view.addSubview(stopVideoTalkButton)

    }
    
    @objc private func startVideoTalk() {
        createEngine()
        loginRoom()
        startPublish()
    }
    
    @objc private func stopVideoTalk() {
        ZegoExpressEngine.shared().logoutRoom()
        ZegoExpressEngine.destroy {
        }
    }
    
    private func createEngine() {
        let profile = ZegoEngineProfile()
        profile.appID = 667663123
        profile.appSign = "cac3c48a5e3af3f3f8b7990b03c920d8815e6d63140d7b2660b83f696e177d9d"
        //通用场景接入，请根据实际情况选择合适的场景
        profile.scenario = .default
        ZegoExpressEngine.createEngine(with: profile, eventHandler: self)
    }
    
    private func loginRoom() {
        // roomID 由您本地生成,需保证 “roomID” 全局唯一。不同用户要登录同一个房间才能进行通话
        let roomID = "daily_room"
        
        // 创建用户对象，ZegoUser 的构造方法 userWithUserID 会将 “userName” 设为与传的参数 “userID” 一样。“userID” 与 “userName” 不能为 “nil”，否则会导致登录房间失败。
        // userID 由您本地生成,需保证 “userID” 全局唯一。
        let user = ZegoUser(userID: "zdq-\(UIDevice.deviceId)")
        
        // 只有传入 “isUserStatusNotify” 参数取值为 “true” 的 ZegoRoomConfig，才能收到 onRoomUserUpdate 回调。
        let roomConfig = ZegoRoomConfig()
        roomConfig.isUserStatusNotify = true
        
        // 登录房间
        ZegoExpressEngine.shared().loginRoom(roomID, user: user, config: roomConfig) { errorCode, extendedData in
            if errorCode == 0 {
                dqLog("房间登录成功")
            } else {
                dqLog("房间登录失败, 错误码: \(errorCode)")
            }
        }
    }
    
    private func startPublish() {
        // 设置本地预览视图并启动预览，视图模式采用 SDK 默认的模式，等比缩放填充整个 View
        ZegoExpressEngine.shared().startPreview(ZegoCanvas(view: view))
        
        // 用户调用 loginRoom 之后再调用此接口进行推流
        // 在同一个 AppID 下，开发者需要保证 “streamID” 全局唯一，如果不同用户各推了一条 “streamID” 相同的流，后推流的用户会推流失败。
        ZegoExpressEngine.shared().startPublishingStream("stream1\(UIDevice.deviceId)")
    }
    

}

extension ZegoDemoViewController: ZegoEventHandler {
    
    //本地调用 loginRoom 加入房间后，您可通过监听 onRoomStateChanged 回调实时监控自己在本房间内的连接状态。
    //更多信息请参考 https://doc-zh.zego.im/article/12884
    func onRoomStateChanged(_ reason: ZegoRoomStateChangedReason, errorCode: Int32, extendedData: [AnyHashable : Any], roomID: String) {
        switch reason {
        case .logining:
            // 正在登录房间。当调用 [loginRoom] 登录房间或 [switchRoom] 切换到目标房间时，进入该状态，表示正在请求连接服务器。通常通过该状态进行应用界面的展示。
            dqLog("logining")
        case .logined:
            //登录房间成功。当登录房间或切换房间成功后，进入该状态，表示登录房间已经成功，用户可以正常收到房间内的其他用户和所有流信息增删的回调通知。
            //只有当房间状态是登录成功或重连成功时，推流（startPublishingStream）、拉流（startPlayingStream）才能正常收发音视频
            dqLog("logined")
        case .loginFailed:
            //登录房间失败。当登录房间或切换房间失败后，进入该状态，表示登录房间或切换房间已经失败，例如 AppID 或 AppSign 不正确等。
            dqLog("loginFailed")
        case .reconnecting:
            //房间连接临时中断。如果因为网络质量不佳产生的中断，SDK 会进行内部重试。
            dqLog("reconnecting")
        case .reconnected:
            //房间重新连接成功。如果因为网络质量不佳产生的中断，SDK 会进行内部重试，重连成功后进入该状态。
            dqLog("reconnected")
        case .reconnectFailed:
            //房间重新连接失败。如果因为网络质量不佳产生的中断，SDK 会进行内部重试，重连失败后进入该状态。
            dqLog("reconnectFailed")
        case .kickOut:
            //被服务器踢出房间。例如有相同用户名在其他地方登录房间导致本端被踢出房间，会进入该状态。
            dqLog("kickOut")
        case .logout:
            //登出房间成功。没有登录房间前默认为该状态，当调用 [logoutRoom] 登出房间成功或 [switchRoom] 内部登出当前房间成功后，进入该状态。
            dqLog("logout")
        case .logoutFailed:
            //登出房间失败。当调用 [logoutRoom] 登出房间失败或 [switchRoom] 内部登出当前房间失败后，进入该状态。
            dqLog("logoutFailed")
        @unknown default:
            dqLog("unknown default")
        }
    }
    
    //房间内其他用户推流/停止推流时，我们会在这里收到相应流增减的通知
    func onRoomStreamUpdate(_ updateType: ZegoUpdateType, streamList: [ZegoStream], extendedData: [AnyHashable : Any]?, roomID: String) {
        //当 updateType 为 ZegoUpdateTypeAdd 时，代表有音视频流新增，此时我们可以调用 startPlayingStream 接口拉取播放该音视频流
        if updateType == .add {
            // 开始拉流，设置远端拉流渲染视图，视图模式采用 SDK 默认的模式，等比缩放填充整个 View
            // 如下 remoteUserView 为 UI 界面上 View.这里为了使示例代码更加简洁，我们只拉取新增的音视频流列表中第的第一条流，在实际的业务中，建议开发者循环遍历 streamList ，拉取每一条音视频流
//            if let streamID = streamList.first?.streamID {
//                ZegoExpressEngine.shared().startPlayingStream(streamID, canvas: ZegoCanvas(view: remoteUserView))
//            } else {
//                dqLog("不应该出现，应该需要上报服务器")
//            }
            
            // test
            for list in streamList {
                ZegoExpressEngine.shared().startPlayingStream(list.streamID, canvas: ZegoCanvas(view: remoteUserView))
            }
        }
    }
    
    //同一房间内的其他用户进出房间时，您可通过此回调收到通知。回调中的参数 ZegoUpdateType 为 ZegoUpdateTypeAdd 时，表示有用户进入了房间；ZegoUpdateType 为 ZegoUpdateTypeDelete 时，表示有用户退出了房间。
    // 只有在登录房间 loginRoom 时传的配置 ZegoRoomConfig 中的 isUserStatusNotify 参数为 YES 时，用户才能收到房间内其他用户的回调。
    // 房间人数大于 500 人的情况下 onRoomUserUpdate 回调不保证有效。若业务场景存在房间人数大于 500 的情况，请联系 ZEGO 技术支持。
    func onRoomUserUpdate(_ updateType: ZegoUpdateType, userList: [ZegoUser], roomID: String) {
        if updateType == .add {
            for user in userList {
                print("用户\(user.userName)进入了房间\(roomID)")
            }
        } else if updateType == .delete {
            for user in userList {
                print("用户\(user.userName)退出了房间\(roomID)")
            }
        }
    }
    
    //用户推送音视频流的状态通知
    //用户推送音视频流的状态发生变更时，会收到该回调。如果网络中断导致推流异常，SDK 在重试推流的同时也会通知状态变化。
    func onPublisherStateUpdate(_ state: ZegoPublisherState, errorCode: Int32, extendedData: [AnyHashable : Any]?, streamID: String) {
        if errorCode != 0 {
            print("推流状态出错 errorCode: \(errorCode)")
        } else {
            switch state {
            case .publishing:
                print("正在推流")
            case .publishRequesting:
                print("正在请求推流")
            case .noPublish:
                print("没有推流")
            @unknown default:
                print("推流 unknown default")
            }
        }
    }
    
    //用户拉取音视频流的状态通知
    //用户拉取音视频流的状态发生变更时，会收到该回调。如果网络中断导致拉流异常，SDK 会自动进行重试。
    func onPlayerStateUpdate(_ state: ZegoPlayerState, errorCode: Int32, extendedData: [AnyHashable : Any]?, streamID: String) {
        if errorCode != 0 {
            
        } else {
            switch state {
            case .playing:
                print("正在拉流中")
            case .playRequesting:
                print("正在请求拉流中")
            case .noPlay:
                print("未进行拉流")
            @unknown default:
                print("拉流 unknown default")
            }
        }
    }
    
    func onNetworkQuality(_ userID: String, upstreamQuality: ZegoStreamQualityLevel, downstreamQuality: ZegoStreamQualityLevel) {
        if userID.isEmpty {
            // 代表本地用户（我）的网络质量
            print("我的上行网络质量是 \(upstreamQuality)")
            print("我的下行网络质量是 \(downstreamQuality)")
        } else {
            //代表房间内其他用户的网络质量
            print("用户 \(userID) 的上行网络质量是 \(upstreamQuality)")
            print("用户 \(userID) 的下行网络质量是 \(downstreamQuality)")
        }
        /*
         ZegoStreamQualityLevelExcellent 网络质量极好
         ZegoStreamQualityLevelGood 网络质量好
         ZegoStreamQualityLevelMedium 网络质量正常
         ZegoStreamQualityLevelBad 网络质量差
         ZegoStreamQualityLevelDie 网络异常
         ZegoStreamQualityLevelUnknown 网络质量未知
         */
    }
    
}
