//
//  VisualModeViewController.swift
//  musicTherapy
//
//  Created by kkerors on 08.02.2021.
//

import Foundation
import UIKit
import SnapKit
import AudioKit
import AudioKitUI

class Canvas: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(3)
        context.setLineJoin(.round)
        context.setLineCap(.round)
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
    }
    
    var lines = [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
            self.lines.removeAll()
            //
        } completion: { _ in
            
        }

    }
    
}


class VisualModeViewController : UIViewController {
    
    // MARK: UIVIEW
    
    private let mainView = UIView()
    
    private let playButton = UIButton()
    
    fileprivate var player: AKPlayer!
    fileprivate var tracker: AKAmplitudeTracker!
    fileprivate var timer: Timer?
    
    private let canvas = Canvas()
    
    var track : Track?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.addSubview(self.mainView)
        
        self.mainView.addSubview(self.canvas)
        
        self.mainView.addSubview(self.playButton)
        
        self.createAudioSession()
        
        // MARK: SETUP AUDIO PLOT
        
        let plot = AKNodeOutputPlot(player)
        plot.plotType = .rolling
        plot.shouldFill = true
        plot.shouldMirror = true
        plot.color = AKColor.black
        self.mainView.addSubview(plot)
        
        self.setupViews()
        self.setupSubview()
        
        plot.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.bottom).offset(-bottomHeight)
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.bottom.equalTo(self.mainView.snp.bottom)
        }

        self.view.layoutSubviews()

    }
    
    private func createAudioSession() {
        guard let url = Bundle.main.url(forResource: track?.path, withExtension: "mp3"),
              let file = try? AKAudioFile(forReading: url) else {
                        fatalError("load audio file error")
                }
        
        try? AKSettings.setSession(category: .playback)

            player = AKPlayer(audioFile: file)
            player.completionHandler = playingEnded
            AKManager.output = player
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkProgress), userInfo: nil, repeats: true)
            do {
                try AKManager.start()
                tracker = AKAmplitudeTracker(player)
            } catch {
                fatalError("AudioKit crash")
            }
    }
    
    func playingEnded() {
        self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        player.stop()
        player.setPosition(0.0)
    }

    @objc dynamic func checkProgress() {
        //
    }
    
    // MARK: SETUP UIVIEW
    
    private func setupViews(){
        self.setupMainView()
        self.setupCanvas()
        self.setupPlayButton()
    }
    
    private func setupMainView(){
        self.mainView.backgroundColor = .white
    }
    
    private func setupCanvas() {
        canvas.backgroundColor = .black
        canvas.layer.cornerRadius = 12
        canvas.clipsToBounds = true
    }
    
    private func setupPlayButton() {
        self.playButton.backgroundColor = .black
        self.playButton.layer.cornerRadius = 10
        self.playButton.layer.shadowOpacity = 0.3
        self.playButton.tintColor = .white
        self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        self.playButton.addTarget(self, action: #selector(self.playButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func playButtonPressed(_ sender: UIButton) {
        if player.isPlaying {
            self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            sender.isSelected = false
            player.pause()
        } else {
            self.playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            player.play()
            sender.isSelected = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: SETUP CONSTRAINTS
    
    private func setupSubview() {
        self.mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.playButton.snp.makeConstraints {
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-self.bottomHeight)
            $0.centerX.equalTo(self.mainView.snp.centerX)
            $0.width.equalTo(70)
            $0.height.equalTo(70)
        }
        
        self.canvas.snp.makeConstraints {
            $0.top.equalTo(topBarHeight)
            $0.left.equalTo(self.mainView.snp.left).offset(10)
            $0.right.equalTo(self.mainView.snp.right).offset(-10)
            $0.bottom.equalTo(playButton.snp.top).offset(-10)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            player.stop()
            do {
                try AKManager.stop()
            } catch {
                fatalError("AudioKit crash")
            }
        }
}
