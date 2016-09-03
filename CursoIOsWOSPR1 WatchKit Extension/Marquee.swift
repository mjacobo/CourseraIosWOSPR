//
//  Marquee.swift
//  CursoIOsWOSPR1
//
//  Created by Mauricio Jacobo Romero on 31/08/2016.
//  Copyright © 2016 MJ. All rights reserved.
//

import Foundation
import UIKit

public class Marquee{
    public var MyMessage: String = ""
    public var MyMarquee: String = ""
    public var MyMarqueeLenght:Int = 0
    var position: Int = 0
    
    init(lenght: Int)
    {
        if(lenght > 0){
            self.MyMarqueeLenght = lenght
            for _ in 0 ..< MyMarqueeLenght {
                self.MyMarquee.append(Character(" "))
            }
        }
    }
    
    func cleanMyMarquee ()
    {
        MyMarquee = ""
        position = 0
        for _ in 0 ..< MyMarqueeLenght {
            self.MyMarquee.append(Character(" "))
        }
    }
    
    public func setMyMessage(myMessage: String){
        self.MyMessage = myMessage
    }
    
    public func runMyMarquee() -> String {
        if(position >= MyMessage.characters.count){
            position = 0
        }
        MyMarquee.removeAtIndex(MyMarquee.startIndex)
        MyMarquee.append(MyMessage[MyMessage.startIndex.advancedBy(position)])
        position += 1
        return MyMarquee
    }

    func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            if(background != nil){ background!(); }
            
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                if(completion != nil){ completion!(); }
            }
        }
    }
    
}