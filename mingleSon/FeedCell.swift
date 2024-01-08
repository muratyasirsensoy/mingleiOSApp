//
//  FeedCell.swift
//  mingleSon
//
//  Created by Murat Yasir Sensoy on 3.01.2024.
//

import UIKit

class FeedCell: UITableViewCell {

 
    
    @IBOutlet weak var anıLabel: UILabel!
    
    @IBOutlet weak var isimLabel: UILabel!
    
    @IBOutlet weak var ozetLabel: UILabel!
    
    @IBOutlet weak var aciklamaLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet var starButtons: [UIButton]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }
    
    
}
