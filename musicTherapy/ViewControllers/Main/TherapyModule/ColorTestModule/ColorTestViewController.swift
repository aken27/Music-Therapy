//
//  ColorTestViewController.swift
//  musicTherapy
//
//  Created by kkerors on 08.02.2021.
//

import Foundation
import UIKit
import SnapKit

class ColorTestViewController : UIViewController {
    
    // MARK: UIVIEW
    
    private let mainView = UIView()
    private let colorCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let colorArray = [UIColor.black, UIColor.brown, UIColor.purple, UIColor.gray, UIColor.blue, UIColor.red, UIColor.green, UIColor.yellow]
    
    // MARK: AUDIO ARRAY
    
    var audioArray : [Track?] = []
    var currentAudioArray : [Track?] = []
    var trackType : TrackType?
    var audioSession = AudioSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLargeTitle(title: "Choose a color")
        
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(colorCollectionView)
        
        self.colorCollectionView.delegate = self
        self.colorCollectionView.dataSource = self
        
        let colorCollectionViewCell = UINib(nibName: "ColorCollectionViewCell",
                                      bundle: nil)
        self.colorCollectionView.register(colorCollectionViewCell, forCellWithReuseIdentifier: "ColorCollectionViewCell")
        
        self.setupTrackArray()
        self.setupViews()
        self.setupSubview()
        self.view.layoutSubviews()
        
    }
    
    // MARK: SETUP TRACK ARRAY
    
    private func setupTrackArray() {
        
        // Black
        
        let black1 = Track(id: "0", author: "Albioni", name: "Adagio", time: "0:12", type: .black, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Black/Albinoni Adagio", state: .stop)
        let black2 = Track(id: "1", author: "Brahms", name: "Symphony No. 3", time: "0:12", type: .black, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Black/Brahms Symphony No. 3 (2nd movement)", state: .stop)
        let black3 = Track(id: "2", author: "Glinka", name: "Parting", time: "0:12", type: .black, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Black/Glinka Farewell", state: .stop)
        let black4 = Track(id: "3", author: "Marcello", name: "Concerto for oboe", time: "0:12", type: .black, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Black/Marcello Concerto for oboe", state: .stop)
        let black5 = Track(id: "4", author: "Terrega", name: "Remembrance of the Alhambra", time: "0:12", type: .black, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Black/Terrega Memories of the Alhambra", state: .stop)
        
        // Blue
        
        let blue1 = Track(id: "5", author: "Beethoven", name: "Concert No. 5 (part 2)", time: "0:12", type: .blue, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Blue/Concert No. 5 (part 2)", state: .stop)
        let blue2 = Track(id: "6", author: "Grieg", name: "Spring", time: "0:12", type: .blue, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Blue/Grieg Spring", state: .stop)
        let blue3 = Track(id: "7", author: "Chopin", name: "Impromptu fantasy", time: "0:12", type: .blue, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Blue/Chopin Fantasy Impromptu", state: .stop)
        
        // Brown
        
        let brown1 = Track(id: "8", author: "Beethoven", name: "To Eliza", time: "0:12", type: .brown, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Brown/Beethoven To Eliza", state: .stop)
        let brown2 = Track(id: "9", author: "Grieg", name: "Solveig's song", time: "0:12", type: .brown, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Brown/Grieg Song Solveig", state: .stop)
        let brown3 = Track(id: "10", author: "Dvorak", name: "Melody", time: "0:12", type: .brown, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Brown/Dvorak Melody", state: .stop)
        let brown4 = Track(id: "11", author: "Rachmaninov", name: "Vocalise", time: "0:12", type: .brown, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Brown/Rachmaninov Vocalise", state: .stop)
        let brown5 = Track(id: "12", author: "Tchaikovsky", name: "Autumn song", time: "0:12", type: .brown, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Brown/Tchaikovsky Autumn Song", state: .stop)
        
        // Green
        
        let green1 = Track(id: "13", author: "Bach", name: "Prelude No. 1", time: "0:12", type: .green, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Green/Bach Prelude No. 1", state: .stop)
        let green2 = Track(id: "14", author: "Mozart", name: "Elvira Madigan", time: "0:12", type: .green, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Green/Mozart Elvira Madigan", state: .stop)
        let green3 = Track(id: "15", author: "Schubert", name: "Impromptu", time: "0:12", type: .green, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Green/Schubert Impromptu", state: .stop)
        
        // Grey
        
        let grey1 = Track(id: "15", author: "Scriabin", name: "Etude", time: "0:12", type: .grey, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Grey/Scriabin Etude", state: .stop)
        let grey2 = Track(id: "16", author: "Schubert", name: "Barcarola", time: "0:12", type: .grey, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Grey/Schubert Barcarola", state: .stop)
        let grey3 = Track(id: "17", author: "Schumann", name: "Intermezzo", time: "0:12", type: .grey, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Grey/Noisy Intermezzo", state: .stop)
        
        // Purple
        
        let purple1 = Track(id: "18", author: "Borodin", name: "Choir of captives", time: "0:12", type: .purple, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Purple/Borodin Choir of polonyans", state: .stop)
        let purple2 = Track(id: "19", author: "Grig", name: "Poet's heart", time: "0:12", type: .purple, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Purple/Grieg The heart of a poet", state: .stop)
        let purple3 = Track(id: "20", author: "Chopin", name: "Nocturne", time: "0:12", type: .purple, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Purple/Chopin Nocturne", state: .stop)
        
        // Red
        
        let red1 = Track(id: "21", author: "Paganini", name: "Concert No. 2 (part 2)", time: "0:12", type: .red, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Red/Paganini Concert (part 2)", state: .stop)
        let red2 = Track(id: "22", author: "Chopin", name: "Etude 25 No. 1", time: "0:12", type: .red, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Red/Chopin Etude 25 No. 1", state: .stop)
        let red3 = Track(id: "23", author: "Schubert", name: "Ave Maria", time: "0:12", type: .red, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Red/Schubert Ave Maria", state: .stop)
        
        // Yellow

        let yellow1 = Track(id: "24", author: "Grig", name: "Wedding day at Trodlehouse", time: "0:12", type: .yellow, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Yellow/Grieg Wedding Day at Trodlehouse", state: .stop)
        let yellow2 = Track(id: "25", author: "Chopin", name: "Prelude", time: "0:12", type: .yellow, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Yellow/Chopin Prelude", state: .stop)
        let yellow3 = Track(id: "26", author: "Chopin", name: "Etude 10 No. 3", time: "0:12", type: .yellow, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Yellow/Chopin Etude 10 No. 3", state: .stop)
        
        self.audioArray.append(black1)
        self.audioArray.append(black2)
        self.audioArray.append(black3)
        self.audioArray.append(black4)
        self.audioArray.append(black5)
        
        self.audioArray.append(blue1)
        self.audioArray.append(blue2)
        self.audioArray.append(blue3)
        
        self.audioArray.append(brown1)
        self.audioArray.append(brown2)
        self.audioArray.append(brown3)
        self.audioArray.append(brown4)
        self.audioArray.append(brown5)
        
        self.audioArray.append(green1)
        self.audioArray.append(green2)
        self.audioArray.append(green3)
        
        self.audioArray.append(grey1)
        self.audioArray.append(grey2)
        self.audioArray.append(grey3)
        
        self.audioArray.append(purple1)
        self.audioArray.append(purple2)
        self.audioArray.append(purple3)
        
        self.audioArray.append(red1)
        self.audioArray.append(red2)
        self.audioArray.append(red3)
        
        self.audioArray.append(yellow1)
        self.audioArray.append(yellow2)
        self.audioArray.append(yellow3)
        
    }
    
    private func sortByType (type: TrackType?) {
        for i in audioArray {
            if i?.type == type {
                self.currentAudioArray.append(i)
            }
        }
    }
    
    // MARK: SETUP UIVIEW
    
    private func setupViews(){
        self.setupMainView()
        self.setupColorCollectionView()
    }
    
    private func setupMainView(){
        self.mainView.backgroundColor = .white
    }
    
    private func setupColorCollectionView() {
        self.colorCollectionView.backgroundColor = .white
    }
    
    // MARK: SETUP CONSTRAINTS
    
    private func setupSubview() {
        
        self.mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.colorCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.top).offset(self.topBarHeight)
            $0.left.equalTo(self.mainView.snp.left).offset(10)
            $0.right.equalTo(self.mainView.snp.right).offset(-10)
            $0.bottom.equalTo(self.mainView.snp.bottom)
        }
        
    }
    
}

extension ColorTestViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as? ColorCollectionViewCell)!
        cell.mainView.backgroundColor = colorArray[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch colorArray[indexPath.row] {
        case .black:
            trackType = .black
        case .brown:
            trackType = .brown
        case .purple:
            trackType = .purple
        case .gray:
            trackType = .grey
        case .blue:
            trackType = .blue
        case .red:
            trackType = .red
        case .green:
            trackType = .green
        case .yellow:
            trackType = .yellow
        default:
            return
        }
        
        self.sortByType(type: trackType)
            
        self.audioSession.type = self.trackType!
        
        
        
        SuggestedAudioRouting.presentSuggestedAudioViewController(fromVC: self, trackType: self.trackType, trackArray: self.currentAudioArray)
    }
    
    func collectionView(_ collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout,
          sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        return CGSize(width: 80, height: 80)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.currentAudioArray = []
    }
    
}
