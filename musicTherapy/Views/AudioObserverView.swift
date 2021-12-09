//
//  AudioObserverView.swift
//  musicTherapy
//
//  Created by kkerors on 08.02.2021.
//

import Foundation
import UIKit
import AudioKitUI

protocol AudioObserverDelegate {
    func onClick(track : Track?)
    func onPlayButtonPressed()
}

class AudioObserverView : UIView {
    
    private var mainView = UIView()
    var playButton = UIButton()
    private var songName = UILabel()
    private var songTime = UILabel()
    private let waveForm = EZAudioPlot()
    
    var track : Track?
    
    var trackDelegate : AudioObserverDelegate?
    
    override init(frame : CGRect){
        super.init(frame: frame)
        self.initialSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup(){
        self.addSubview(self.mainView)
        self.mainView.addSubview(self.playButton)
        self.mainView.addSubview(self.songName)
        self.mainView.addSubview(self.songTime)
        self.mainView.addSubview(self.waveForm)
        self.setupViews()
        self.setupConstraints()
        
    }
    
    private func setupViews() {
        self.setupMainView()
        self.setupPlayButton()
        self.setupSongName()
        self.setupSongTime()
        self.setupWaveForm()
    }
    
    private func setupMainView() {
        self.backgroundColor = .white
        self.mainView.backgroundColor = .white
        self.mainView.layer.cornerRadius = 10
        self.mainView.layer.shadowRadius = 5
        self.mainView.layer.shadowOpacity = 0.3
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTrackTap(_:)))
        self.mainView.addGestureRecognizer(tap)
        
    }
    
    @objc func onTrackTap(_ sender: UITapGestureRecognizer? = nil) {
        trackDelegate?.onClick(track: track)
    }
    
    private func setupPlayButton() {
        self.playButton.backgroundColor = .black
        self.playButton.layer.cornerRadius = 10
        self.playButton.layer.shadowOpacity = 0.3
        self.playButton.tintColor = .white
        self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        self.playButton.addTarget(self, action: #selector(onPlayButtonTap), for: .touchUpInside)
    }
    
    
    @objc func onPlayButtonTap(_ sender: UIButton) {
        trackDelegate?.onPlayButtonPressed()
    }
    
    private func setupSongName() {
        self.songName.textColor = .black
    }
    
    private func setupSongTime() {
        self.songTime.textColor = .black
    }
    
    func fillInObserver(track : Track?) {
        self.songName.text = "\(track?.author ?? "") - \(track?.name ?? "")"
//        self.songTime.text =  "\(track?.time ?? "")"
    }
    
    private func setupWaveForm() {
        
        let file = createAudioPath(name: track?.path)
        
        guard let data = file?.getWaveformData() else { return }
        
        self.waveForm.plotType = EZPlotType.buffer
        self.waveForm.shouldFill = true
        self.waveForm.shouldMirror = true
        self.waveForm.color = UIColor.black
        
        self.waveForm.updateBuffer( data.buffers[0], withBufferSize: data.bufferSize )
        
    }
    
    func setupConstraints(){
        self.mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
        
        self.playButton.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.top).offset(10)
            $0.left.equalTo(self.mainView.snp.left).offset(10)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-10)
            $0.width.equalTo(self.playButton.snp.height)
        }

        self.songTime.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.top).offset(10)
            $0.right.equalTo(self.mainView.snp.right).offset(-10)
            $0.bottom.equalTo(self.mainView.snp.centerY).offset(-5)
        }
        
        self.songName.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.top).offset(10)
            $0.left.equalTo(self.playButton.snp.right).offset(10)
            $0.right.equalTo(self.songTime.snp.left).offset(-5)
            $0.bottom.equalTo(self.mainView.snp.centerY).offset(-5)
        }
        
        self.waveForm.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.centerY)
            $0.left.equalTo(self.playButton.snp.right).offset(10)
            $0.right.equalTo(self.mainView.snp.right).offset(-10)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-10)
        }
        
    }
    
}
