//
//  ValidatedTextView.swift
//  Pods
//
//  Created by Shoaib Abdul on 09/09/2016.
//
//

import UIKit

@objc public protocol ValidatedTextViewDelegate {
    optional func validatedTextViewInvalidSignDidTap(validatedTextField:ValidatedTextView, sender:UIButton);
} //P.E.

public class ValidatedTextView: BaseUITextView {

    @IBInspectable var validateEmpty:Bool = false;
    
    @IBInspectable var validateRegex:String?;
    
    @IBInspectable var minChar:Int?;
    @IBInspectable var maxChar:Int?;
    
    @IBInspectable var invalidSign:UIImage? = nil {
        didSet {
            invalidSignBtn.setImage(invalidSign, forState: UIControlState.Normal);
        }
    } //P.E.
    
    private var _validityMsg:String?
    @IBInspectable public var validityMsg:String {
        get {
            return _validityMsg ?? "Invalid";
        }
        
        set {
            _validityMsg = SyncedText.text(forKey: newValue);
        }
        
    } //P.E.
    
    private lazy var invalidSignBtn:CustomUIButton =  {
        let cBtn:CustomUIButton = CustomUIButton(type: UIButtonType.Custom);
        cBtn.hidden = true;
        cBtn.frame = CGRect(x: self.frame.size.width - self.frame.size.height, y: 0, width: self.frame.size.height, height: self.frame.size.height);
        cBtn.contentMode = UIViewContentMode.Right;
        cBtn.containtOffSet = GISTUtility.convertPointToRatio(CGPoint(x: 10, y: 0));
        
        cBtn.addTarget(self, action: #selector(invalidSignBtnHandler(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        
        self.addSubview(cBtn);
        return cBtn;
    } ();
    
    private var _isEmpty:Bool = false;
    
    private var _isValid:Bool = false;
    public var isValid:Bool {
        get {
            let cValid:Bool = (_isValid && (!validateEmpty || !_isEmpty));
            
            self.invalidSignBtn.hidden = cValid;
            
            return cValid;
        }
    } //F.E.
    
    private func validateText() {
        _isEmpty = self.isEmpty();
        
        _isValid =
            ((minChar == nil) || self.isValidForMinChar(minChar!)) &&
            ((maxChar == nil) || self.isValidForMaxChar(maxChar!)) &&
            ((validateRegex == nil) || self.isValidForRegex(validateRegex!));
        
        self.invalidSignBtn.hidden = (_isValid || _isEmpty);
    } //F.E.
    
    public func isEmpty()->Bool {
        guard (self.text != nil) else {
            return true;
        }
        
        return (self.text! == "");
    } //F.E.
    
    private func isValidForMinChar(noOfChar:Int) -> Bool {
        guard (self.text != nil) else {
            return false;
        }
        
        return (self.text!.utf16.count >= noOfChar);
    } //F.E.
    
    private func isValidForMaxChar(noOfChar:Int) -> Bool {
        guard (self.text != nil) else {
            return false;
        }
        
        return (self.text!.utf16.count <= noOfChar);
    } //F.E.
    
    private func isValidForRegex(regex:String)->Bool {
        guard (self.text != nil) else {
            return false;
        }
        
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluateWithObject(self.text!);
    } //F.E.
    
    public override func layoutSubviews() {
        super.layoutSubviews();
        //--
        self.invalidSignBtn.frame = CGRect(x: self.frame.size.width - self.frame.size.height, y: 0, width: self.frame.size.height, height: self.frame.size.height);
    } //F.E.
    
    func invalidSignBtnHandler(sender:UIButton) {
        (self.delegate as? ValidatedTextViewDelegate)?.validatedTextViewInvalidSignDidTap?(self, sender: sender)
    } //F.E.
    
    override func textDidChangeObserver(notification:NSNotification) {
        super.textDidChangeObserver(notification);
        //--
        self.validateText();
    } //F.E.
} //CLS END