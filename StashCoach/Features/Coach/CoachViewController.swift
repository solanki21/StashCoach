//
//  CoachViewController.swift
//  StashCoach
//
//  Created by Kalpesh Solanki on 7/20/18.
//  Copyright © 2018 Kalpesh Solanki. All rights reserved.
//

import UIKit
import SDWebImage

class CoachViewController: UITableViewController {
    var presenter: CoachReactable?
    
    fileprivate var achievementList = [AchievementDisplayModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension

        presenter?.updateView()
        setupNavigationBar()
    }

    func setupNavigationBar() {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.barTintColor = UIColor(red: 105.0/255.0, green: 61.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        navBar.titleTextAttributes =  [NSAttributedStringKey.foregroundColor: UIColor.white]
        navBar.isTranslucent = false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func infoButtonTapped(_ sender: Any) {
        presenter?.infoButtonTapped()
    }
}

extension CoachViewController: CoachViewable {
    func update(title: String, achievementList: [AchievementDisplayModel]) {
        self.achievementList = achievementList
        self.title = title
    }
}

extension CoachViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievementList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row <  achievementList.count,
              let cell = tableView.dequeueReusableCell(withIdentifier: "CoachCell", for: indexPath) as? CoachCell
        else {
            return UITableViewCell()
        }
        
        cell.info = achievementList[indexPath.row]
        return cell
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < achievementList.count else { return }
        let info = achievementList[indexPath.row]
        presenter?.achievementSelected(forId: info.achievementId)
    }
}

class CoachCell: UITableViewCell {
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.layer.cornerRadius = 10
            backgroundImageView.clipsToBounds = true
            backgroundImageView.contentMode = .scaleAspectFill
        }
    }

    @IBOutlet weak var levelBackgroundView: UIView! {
        didSet {
            levelBackgroundView.layer.cornerRadius = levelBackgroundView.frame.width / 2.0
        }
    }
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var progressBarBackgroundView: UIView! {
        didSet {
            progressBarBackgroundView.layer.cornerRadius = 5
            progressBarBackgroundView.clipsToBounds = true
        }
    }

    @IBOutlet weak var progressIndicatorWidthConstraint: NSLayoutConstraint!

    var info: AchievementDisplayModel? {
        didSet {
            guard let info = info,
                  let url = URL(string: info.backgroundImageUrl ?? "")
            else { return }

            // Although UIImage could be loaded from the Interactor. I prefer to reduce complexity whenever possible
            // for certain cases. Loading image through this way is perfectly fine in my opinion.
            backgroundImageView.sd_setImage(with: url)
            contentView.alpha = info.transparency
            levelLabel.text = info.levelText
            leftLabel.text = info.progressBarLeftLabelText
            rightLabel.text = info.progressBarRightLabelText

            progressIndicatorWidthConstraint.constant = info.progressBarRelativeWidth * progressBarBackgroundView.frame.width
        }
    }
}

