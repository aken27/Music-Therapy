//
//  SuggestedAudioViewController.swift
//  musicTherapy
//
//  Created by kkerors on 10.01.2021.
//

import Foundation
import UIKit
import SnapKit

class SuggestedAudioViewController : UIViewController {
    
    // MARK: UIVIEW
    
    private let mainView = UIView()
    private let tableView = UITableView()
    
    public var tracks : [Track?] = []
    public var trackType : TrackType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLargeTitle(title: "A selection")
        
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = .white
        self.tableView.separatorStyle = .none
        
        let suggestedTableViewCell = UINib(nibName: "SuggestedTableViewCell",
                                      bundle: nil)
        self.tableView.register(suggestedTableViewCell,
                                    forCellReuseIdentifier: "SuggestedTableViewCell")
        self.setupViews()
        self.setupSubview()
        self.view.layoutSubviews()
        
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
        self.tableView.snp.makeConstraints {
            $0.edges.equalTo(self.mainView.snp.edges)
        }
    }
    
}

extension SuggestedAudioViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedTableViewCell") as? SuggestedTableViewCell {
        cell.selectionStyle = .none
        cell.setupCell(track: tracks[indexPath.row]!)
        cell.cellDelegate = self
        cell.index = indexPath
        return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

extension SuggestedAudioViewController : SuggestedTableViewCellDelegate {
    
    func onPlayerClick(index: Int) {
        PlayerModeRouting.presentPlayerModeViewController(fromVC: self, track: tracks[index])
    }
    
    func onVisualClick(index: Int) {
        VisualModeRouting.presentVisualModeViewController(fromVC: self, track: tracks[index])
    }
    
    func onInteractiveClick(index: Int) {
        InteractiveModeRouting.presentInteractiveModeViewController(fromVC: self, track: tracks[index])
    }
    
}
