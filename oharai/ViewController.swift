//
//  ViewController.swift
//  oharai
//
//  Created by Takemura Asuka on 2018/01/14.
//  Copyright © 2018年 Takemura Asuka. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    var bellAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    var failAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    var successAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bellAudioPlayer = setSE(seName: "1-bell")
        failAudioPlayer = setSE(seName: "1-fail")
        successAudioPlayer = setSE(seName: "1-success")
    }
    func setSE(seName: String) -> AVAudioPlayer {
        var audioPlayer: AVAudioPlayer = AVAudioPlayer()
        // サウンドファイルのパスを生成
        let soundFilePath = Bundle.main.path(forResource: seName, ofType: "mp3")!
        let sound:URL = URL(fileURLWithPath: soundFilePath)
        // AVAudioPlayerのインスタンスを作成
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
        } catch {
            print("AVAudioPlayerインスタンス作成失敗")
        }
        // バッファに保持していつでも再生できるようにする
        audioPlayer.prepareToPlay()
        
        return audioPlayer
    }

    override var canBecomeFirstResponder: Bool { get { return true } }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == UIEventSubtype.motionShake {
            bellAudioPlayer.play()
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == UIEventSubtype.motionShake {
            let _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                let random = Int(arc4random_uniform(10))
                
                if random < 8 {
                    
                    self.successAudioPlayer.play()
                } else {
                    
                    self.failAudioPlayer.play()
                }
            })
        }
    }
    
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == UIEventSubtype.motionShake {
            print("  SHAKE!!!")
        }
    }
   
}

