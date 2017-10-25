//
//  JWTabBarController.swift
//  JW_TabBarController
//
//  Created by Jacob Wagstaff on 8/18/17.
//  Copyright © 2017 Jacob Wagstaff. All rights reserved.
//

import UIKit

open class PutItOnMyTabBarController: UITabBarController, CustomTabBarDelegate {

    // MARK: - View
    var customTabBar = CustomTabBar()
    
    public enum Position {
        case bottom
        case top
    }
    
    @IBInspectable var isTop: Bool
        {
        set{
            if newValue {
                self.position = .top
            }else {
                self.position = .bottom
            }
        }
        
        get{
            return self.position == .top
        }
    }
    
    public var position :Position = .bottom
    lazy var constraints: Array<NSLayoutConstraint> = []
    
    
    public init(_ initPosition: Position) {
        self.position = initPosition
        super.init(nibName:nil, bundle:nil)
    }
    
    
    public convenience init() {
        self.init(.bottom)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }
    

    // MARK: - Initial Setup
    func layoutView(){
        view.addAutoLayoutSubview(customTabBar)
        constraints.append(contentsOf: [customTabBar.leftAnchor.constraint(equalTo: view.leftAnchor),
                                        customTabBar.rightAnchor.constraint(equalTo: view.rightAnchor),
                                        customTabBar.heightAnchor.constraint(equalTo: tabBar.heightAnchor)])
        
        switch position {
        case .top:
            if #available(iOS 11.0, *) {
                constraints.append(customTabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
            } else {
                constraints.append(customTabBar.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor))
            }
            break
        default:
            if #available(iOS 11.0, *) {
                constraints.append(customTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
            } else {
                constraints.append(customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor))
            }
            break
            
        }
        NSLayoutConstraint.activate(constraints)
        tabBar.isHidden = true
        
        customTabBar.delegate = self
        customTabBar.setup()
        customTabBar.highlightSelected(index: 0)
    }
    
    func didSelectViewController(_ tabBarView: CustomTabBar, atIndex index: Int) {
        if #available(iOS 10.0, *) {
            let gen = UIImpactFeedbackGenerator(style: .light)
            gen.impactOccurred()
        } else {
            // Do nothing...
        }
        selectedIndex = index
    }
    
    // MARK: Mandatory Functions Child Class must override
    
    
    //Specifies how many tabs there are
    open func numberOfTabs() -> Int{
        fatalError("subclass must implement numberOfTabBars")
    }
    
    //Gives TabBar all of the images it needs for when a tab is highlighted (in order of Tabs)
    open func highLightedImages() -> [UIImage] {
        fatalError("subclass must implement highLightedImages")
    }
    
    //Gives TabBar all of the images it needs for when a tab is not selected (in order of Tabs)
    open func unHighlightedImages() -> [UIImage] {
        fatalError("subclass must implement unHighlightedImages")
    }
    
    // MARK: Optional Overrides
    
    @IBInspectable var iBackgroundColor: UIColor = UIColor.white
    @IBInspectable var iSliderColor: UIColor = UIColor.clear
    @IBInspectable var iSliderHeightMultiplier: CGFloat = 0.1
    @IBInspectable var iSliderWidthMultiplier: CGFloat = 1.0
    @IBInspectable var iAnimationDuration: Double = 0.35
    @IBInspectable var normalTitleColor: UIColor = .white
    @IBInspectable var selectedTitleColor: UIColor = .white
    @IBInspectable var iFontForTitles: UIFont = UIFont.systemFont(ofSize: 10)
    
    
    
    // Gives Background to Tab Bar - Default is white
    open func backgroundColor() -> UIColor{
        return iBackgroundColor
    }
    
    // Optional Slider View that moves to selected Tab - Default is clear
    open func sliderColor() -> UIColor {
        return iSliderColor
    }
    
    // Sets the height of a slider as a percentage of the total tab bar height - Default is 10%
    open func sliderHeightMultiplier() -> CGFloat {
        return iSliderHeightMultiplier
    }
    
    // Sets the sliders width as a percentage of each tab bars width - Default is 100%
    open func sliderWidthMultiplier() -> CGFloat {
        return iSliderWidthMultiplier
    }
    
    // Sets the animation duration for the slider default is 0.35
    open func animationDuration() -> Double {
        return iAnimationDuration
    }
    
    // MARK: Titles Defaults to none
    open func tabBarType() -> TabBarItemType {//Return .label
        return .icon
    }
    
    open func titles() -> [String] {
        return []
    }
    
    open func titleColors() -> (UIColor, UIColor) {
        return (normalTitleColor, selectedTitleColor)
    }
    
    open func fontForTitles() -> UIFont {
        return iFontForTitles
    }

}

//extension PutItOnMyTabBarController: CustomTabBarDelegate{
//
//    func didSelectViewController(_ tabBarView: CustomTabBar, atIndex index: Int) {
//        let gen = UIImpactFeedbackGenerator(style: .light)
//        gen.impactOccurred()
//        selectedIndex = index
//    }
//    
//    // MARK: Mandatory Functions Child Class must override
//    
//    
//    //Specifies how many tabs there are
//    open func numberOfTabs() -> Int{
//        fatalError("subclass must implement numberOfTabBars")
//    }
//    
//    //Gives TabBar all of the images it needs for when a tab is highlighted (in order of Tabs)
//    open func highLightedImages() -> [UIImage] {
//        fatalError("subclass must implement highLightedImages")
//    }
//    
//    //Gives TabBar all of the images it needs for when a tab is not selected (in order of Tabs) 
//    open func unHighlightedImages() -> [UIImage] {
//        fatalError("subclass must implement unHighlightedImages")
//    }
//    
//    // MARK: Optional Overrides 
//    
//    // Gives Background to Tab Bar - Default is white 
//    open func backgroundColor() -> UIColor{
//        return .white
//    }
//    
//    // Optional Slider View that moves to selected Tab - Default is clear
//    open func sliderColor() -> UIColor {
//        return .clear
//    }
//    
//    // Sets the height of a slider as a percentage of the total tab bar height - Default is 10%
//    open func sliderHeightMultiplier() -> CGFloat {
//        return 0.1
//    }
//    
//    // Sets the sliders width as a percentage of each tab bars width - Default is 100%
//    open func sliderWidthMultiplier() -> CGFloat {
//        return 1.0
//    }
//    
//    // Sets the animation duration for the slider default is 0.35
//    open func animationDuration() -> Double {
//        return 0.35 
//    }
//    
//    // MARK: Titles Defaults to none
//    open func tabBarType() -> TabBarItemType {//Return .label
//        return .icon
//    }
//    
//    open func titles() -> [String] {
//        return []
//    }
//    
//    open func titleColors() -> (UIColor, UIColor) {
//        return (.white, .white)
//    }
//    
//    open func fontForTitles() -> UIFont {
//        return UIFont()
//    }
//    
//}
