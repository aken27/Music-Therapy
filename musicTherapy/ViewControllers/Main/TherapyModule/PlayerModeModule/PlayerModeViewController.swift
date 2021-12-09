//
//  PlayerModeViewController.swift
//  musicTherapy
//
//  Created by kkerors on 08.02.2021.
//

import Foundation
import UIKit
import SnapKit
import AudioKit
import AudioKitUI

class PlayerModeViewController : UIViewController {
    
    // MARK: UIVIEW
    
    private let mainView = UIView()

    private let songLabel = UILabel()
    private let authorLabel = UILabel()
    
    private var slider = UISlider()
    private let playButton = UIButton()
    
    fileprivate var player: AKPlayer!
    fileprivate var timer: Timer?
    
    var track : Track?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.addSubview(self.mainView)

        self.mainView.addSubview(self.songLabel)
        self.mainView.addSubview(self.authorLabel)
        self.mainView.addSubview(self.slider)
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
            $0.top.equalTo(self.mainView.snp.top).offset(topBarHeight)
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.bottom.equalTo(self.mainView.snp.centerY).offset(-30)
        }
        
        self.view.layoutSubviews()
        
    }
    
    private func createAudioSession() {
        guard let url = Bundle.main.url(forResource: track?.path, withExtension: "mp3"),
              let file = try? AKAudioFile(forReading: url) else {
                        fatalError("load audio file error")
                }
        
        try? AKSettings.setSession(category: .playback)

            slider.minimumValue = 0
            slider.maximumValue = Float(file.duration)

            player = AKPlayer(audioFile: file)
            player.completionHandler = playingEnded

            AKManager.output = player
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkProgress), userInfo: nil, repeats: true)
            do {
                try AKManager.start()
            } catch {
                fatalError("AudioKit crash")
            }
    }
    
    // MARK: SETUP UIVIEW
    
    private func setupViews(){
        self.setupMainView()
        self.setupSongLabel()
        self.setupAuthorLabel()
        self.setupSlider()
        self.setupPlayButton()
    }
    
    private func setupMainView(){
        self.mainView.backgroundColor = .white
    }
    
    private func setupSongLabel() {
        self.songLabel.text = self.track?.name
        self.songLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.songLabel.textColor = .black
    }
    
    private func setupAuthorLabel() {
        self.authorLabel.text = self.track?.author
        self.authorLabel.font = UIFont.systemFont(ofSize: 15)
        self.authorLabel.textColor = .black
    }
    
    private func setupSlider() {
        self.slider.addTarget(self, action: #selector(self.sliderValueChanged(_:)), for: .valueChanged)
        self.slider.minimumTrackTintColor = .black
    }
    
    private func setupPlayButton() {
        self.playButton.backgroundColor = .black
        self.playButton.layer.cornerRadius = 10
        self.playButton.layer.shadowOpacity = 0.3
        self.playButton.tintColor = .white
        self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        self.playButton.addTarget(self, action: #selector(self.playButtonPressed(_:)), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func playingEnded() {
        self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        player.stop()
        player.setPosition(0.0)
        slider.setValue(0.0, animated: false)
    }

    @objc dynamic func checkProgress() {
        slider.value = Float(player.currentTime)
    }

    @objc func sliderValueChanged(_ sender: UISlider) {
        
        let startTime = Double(sender.value)
        if player.isPlaying {
            player.setPosition(startTime)
        } else {
            player.startTime = startTime
        }
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
    
    // MARK: SETUP CONSTRAINTS
    
    private func setupSubview() {
        self.mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.songLabel.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.centerY).offset(20)
            $0.centerX.equalTo(self.mainView.snp.centerX)
        }
        
        self.authorLabel.snp.makeConstraints {
            $0.top.equalTo(self.songLabel.snp.bottom).offset(7)
            $0.centerX.equalTo(self.mainView.snp.centerX)
        }
        
        self.slider.snp.makeConstraints {
            $0.top.equalTo(self.authorLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(self.mainView.snp.centerX)
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.height.equalTo(20)
        }
        
        self.playButton.snp.makeConstraints {
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-self.bottomHeight)
            $0.centerX.equalTo(self.mainView.snp.centerX)
            $0.width.equalTo(70)
            $0.height.equalTo(70)
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

