//
//  NoRecipesView.swift
//  YummyYum
//
//  Created by Ruslan Arhypenko on 2/23/19.
//  Copyright © 2019 Ruslan Arhypenko. All rights reserved.
//

import UIKit

class NoRecipesView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        Bundle.main.loadNibNamed("NoRecipesView", owner: self, options: nil)
        view.frame = self.frame
        addSubview(view)
    }
}
