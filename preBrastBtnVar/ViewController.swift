//
//  ViewController.swift
//  preBrastBtnVar
//
//  Created by 小西壮 on 2018/09/26.
//  Copyright © 2018年 小西壮. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var theme: UILabel!
    @IBOutlet weak var detail: UITextView!
    
    
    var longGesture = UILongPressGestureRecognizer()
    //表示するテキストデータの配列
    var textLabelList:[UILabel] = []
    var tag:Int = 1
    var taptag:Int!
    
    // タッチしたビューの中心とタッチした場所の座標のズレを保持する変数
    var gapX:CGFloat = 0.0  // x座標
    var gapY:CGFloat = 0.0  // y座標

    @IBOutlet var popOver: UIView!
    @IBOutlet var detailPop: UIView!
    
    var getLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.popOver.layer.cornerRadius = 10
        
        longGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(_:)))
        longGesture.minimumPressDuration = 0.5
        view.addGestureRecognizer(longGesture)
    }
    
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        print("ロングプッシュ")
//        print(textLabelList[taptag - 1].title)
//        print(textLabelList[taptag - 1].detail)
        self.view.addSubview(detailPop)
        detailPop.center = self.view.center
        theme.text = textLabelList[taptag - 1].text
        detail.text = textLabelList[taptag - 1].text
    }
    
    @IBAction func popBt(_ sender: Any) {
        self.view.addSubview(popOver)
        popOver.center = self.view.center
    }
    
    
    @IBAction func doneBtn(_ sender: Any) {
        
        var getLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 160, height: 80))
        getLabel.text = textField.text
        getLabel.textAlignment = NSTextAlignment.center
        //        getLabel.backgroundColor = UIColor.red
        getLabel.layer.borderColor = UIColor.red.cgColor
        getLabel.layer.borderWidth = 3
        getLabel.layer.cornerRadius = 10
        getLabel.layer.masksToBounds = true
        // ユーザーの操作を有効にする
        getLabel.isUserInteractionEnabled = true
        // タッチしたものがおじさんかどうかを判別する用のタグ
        getLabel.tag = 1
        tag += 1
        //配列に追加
        textLabelList.append(getLabel)
        //ビューに追加
        for text in self.textLabelList{
            self.view.addSubview(text)
        }
        
        // おじさんの初期位置を調整
        //        getLabel.center = CGPoint(x: view.center.x, y: view.center.y + 100)
        
        self.popOver.removeFromSuperview()
        
        print(textLabelList)
    }
    
    
    @IBAction func doneDetailPop(_ sender: UIButton) {
        self.detailPop.removeFromSuperview()
    }
    
    
    // タッチした位置で最初に見つかったところにあるビューを取得してしまおうという魂胆
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 最初にタッチした指のみ取得
        if let touch = touches.first {
            // タッチしたビューをviewプロパティで取得する
            if let touchedView = touch.view {
                // tagでおじさんかそうでないかを判断する
                if touchedView.tag >= 1 {
                    // タッチした場所とタッチしたビューの中心座標がどうずれているか？
                    gapX = touch.location(in: view).x - touchedView.center.x
                    gapY = touch.location(in: view).y - touchedView.center.y
                    // 例えば、タッチしたビューの中心のxが50、タッチした場所のxが60→中心から10ずれ
                    // この場合、指を100に持って行ったらビューの中心は90にしたい
                    // ビューの中心90 = 持って行った場所100 - ずれ10
                    touchedView.center = CGPoint(x: touch.location(in: view).x - gapX, y: touch.location(in: view).y - gapY)
                    taptag = touchedView.tag
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // touchesBeganと同じ処理だが、gapXとgapYはタッチ中で同じものを使い続ける
        // 最初にタッチした指のみ取得
        if let touch = touches.first {
            // タッチしたビューをviewプロパティで取得する
            if let touchedView = touch.view {
                // tagでおじさんかそうでないかを判断する
                if touchedView.tag == 1 {
                    // gapX,gapYの取得は行わない
                    touchedView.center = CGPoint(x: touch.location(in: view).x - gapX, y: touch.location(in: view).y - gapY)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // gapXとgapYの初期化
        gapX = 0.0
        gapY = 0.0
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // touchesEndedと同じ処理
        self.touchesEnded(touches, with: event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

