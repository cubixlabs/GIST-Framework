//
//  BaseCollectionViewCell.swift
//  GISTFramework
//
//  Created by Shoaib Abdul on 14/06/2016.
//  Copyright © 2016 Social Cubix. All rights reserved.
//

import UIKit

/// BaseUICollectionViewCell is a subclass of UICollectionViewCell and implements BaseView. This class should be used for the collection view cells throughout the project.
open class BaseUICollectionViewCell: UICollectionViewCell, BaseView {
    
    //MARK: - Properties
    
    private var _data:Any?
    
    /// Holds data of the Collection View Cell.
    open var data:Any? {
        get {
            return _data;
        }
        
        set {
            _data = newValue;
        }
    } //P.E.
    
    //MARK: - Overridden Methods
    
    /// Overridden method to setup/ initialize components.
    override open func awakeFromNib() {
        super.awakeFromNib()
    } //F.E.
    
    /// Recursive update of layout and content from Sync Engine.
    override func updateSyncedData() {
        super.updateSyncedData();
        //--
        self.contentView.updateSyncedData();
    } //F.E.
    
    //MARK: - Methods
    
    /// This method should be called in cellForRowAt:indexPath. it also must be overriden in all sub classes of BaseUICollectionViewCell to update the collection view cell's content.
    ///
    /// - Parameter data: Cell Data
    open func updateData(_ data:Any?) {
        _data = data;
        //--
        self.updateSyncedData();
    } //F.E.
    
    /// Updates layout and contents from SyncEngine. this is a protocol method BaseView that is called when the view is refreshed.
    func updateView() {
        //DOING NOTHING FOR NOW
    } //F.E.
    
    
} //CLS END
