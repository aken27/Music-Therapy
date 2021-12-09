//
//  MTRecommendViewController.swift
//  musicTherapy
//
//  Created by kkerors on 09.01.2021.
//

import Foundation
import UIKit
import SnapKit

class RecommendViewController : UIViewController {
    
    // MARK: UIVIEW
    
    private let mainView = UIView()
    private let recommendCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    private var keys: [MusicalKey] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupLargeTitle(title: "Info Cards")
        
        self.fillInKeys()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.mainView)

        self.mainView.addSubview(self.recommendCollectionView)
        
        self.recommendCollectionView.delegate = self
        self.recommendCollectionView.dataSource = self
        self.recommendCollectionView.isPagingEnabled = true
        self.recommendCollectionView.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.recommendCollectionView.collectionViewLayout = layout
        
        let recommmendCollectionViewCell = UINib(nibName: "RecommendCollectionViewCell",
                                      bundle: nil)
        self.recommendCollectionView.register(recommmendCollectionViewCell, forCellWithReuseIdentifier: "RecommendCollectionViewCell")
        
        let profileBarButtonItem = UIBarButtonItem(title: "Profile", style: .done, target: self, action: #selector(showUserProfile))
            self.navigationItem.rightBarButtonItem  = profileBarButtonItem
        
        self.setupViews()
        self.setupSubview()
        self.view.layoutSubviews()
        
    }
    
    private func fillInKeys() {
        let cMaj = MusicalKey(keyName: "C Major", keyFeel: "Innocently Happy", keyDescription: "Completely pure. Simplicity and naivety. The key of children. Free of burden, full of imagination. Powerful resolve. Earnestness. Can feel religious.", notes: "C D E F G A B")
        let cSharpMin = MusicalKey(keyName: "C# Minor", keyFeel: "Despair, Wailing, Weeping", keyDescription: "A passionate expression of sorrow and deep grief. Full of penance and self-punishment. An intimate conversation with God about recognition of wrongdoing and atonement.", notes: "C# D# E F# G# A B")
        let dbMaj = MusicalKey(keyName: "DB MAJOR", keyFeel: "Grief, Depressive", keyDescription: "Rapture in sadness. A grimacing key of choking back tears. It is capable of a laugh or smile to pacify those around, but the truth is in despair. Fullness of tone, sonority, and euphony.", notes: "D♭, E♭, F, G♭, A♭, B♭ C")
        let dMaj = MusicalKey(keyName: "D MAJOR", keyFeel: "Triumphant, Victorious War-Cries", keyDescription: "Screaming hallelujah's, rejoicing in conquering obstacles. War marches, holiday songs, invitations to join the winning team.", notes: "D, E, F#, G, A, B, C#")
        self.keys.append(cMaj)
        self.keys.append(cSharpMin)
        self.keys.append(dbMaj)
        self.keys.append(dMaj)
    }
    
    // MARK: SETUP UIVIEW
    
    private func setupViews(){
        self.setupMainView()
    }
    
    private func setupMainView(){
        self.mainView.backgroundColor = .white
    }
    
    // MARK: SETUP CONSTRAINTS
    
    private func setupSubview() {
        self.mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.recommendCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.top).offset(topBarHeight)
            $0.left.equalTo(self.mainView.snp.left).offset(10)
            $0.right.equalTo(self.mainView.snp.right).offset(-10)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-self.bottomHeight)
        }
    }
    
    @objc func showUserProfile(){
        ProfileRouting.presentProfileViewController(fromVC: self)
    }
}

extension RecommendViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell", for: indexPath) as? RecommendCollectionViewCell)!
        cell.backgroundColor = .black
        cell.cellDelegate = self
        cell.index = indexPath
        cell.setupCell(key: self.keys[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout,
          sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        return CGSize(width: 200, height: 350)
    }
    
}

extension RecommendViewController : RecommendCollectionViewCellDelegate {    
    
    func onInteractiveClick(index: Int) {
        InteractiveModeRouting.presentInteractiveModeViewController(fromVC: self, track: nil)
    }
    
}
