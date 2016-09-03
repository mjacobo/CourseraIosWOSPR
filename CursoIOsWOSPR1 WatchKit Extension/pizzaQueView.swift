//
//  pizzaQueView.swift
//  CursoIOsWOSPR1
//
//  Created by Mauricio Jacobo Romero on 01/09/2016.
//  Copyright © 2016 MJ. All rights reserved.
//

import WatchKit
import Foundation


class pizzaQueView: WKInterfaceController {
    var listaOpciones : [(String, String)] = [
        ("Cheddar", "Seleccione su tipo de queso:"),
        ("Mozarella", "Seleccione su tipo de queso:"),
        ("Parmesano", "Seleccione su tipo de queso:"),
        ("No queso", "Seleccione su tipo de queso:")]
    
    @IBOutlet var pickerQueso: WKInterfacePicker!
    @IBOutlet var pizzaSelQueso: WKInterfaceLabel!
    
    var MyQueObj : MyOrder = MyOrder()
    
    

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        let c = context as! MyOrder
        MyQueObj=c
        
        if(c.pizzaOrderQue != PizzaQueso.NoSel){
            pizzaSelQueso.setText("\(c.pizzaOrderMas!)")
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let pickerItems: [WKPickerItem] = listaOpciones.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0.0
            pickerItem.caption = $0.1
            return pickerItem
        }
        
        pickerQueso.setItems(pickerItems)
        pickerQueso.setSelectedItemIndex(0)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func selQuesoOption(value: Int) {
        switch (value) {
        case 0:
            pizzaSelQueso.setText("Cheddar")
            MyQueObj.pizzaOrderQue = PizzaQueso.Cheddar
        case 1:
            pizzaSelQueso.setText("Mozarella")
            MyQueObj.pizzaOrderQue = PizzaQueso.Mozarella
        case 2:
            pizzaSelQueso.setText("Parmesano")
            MyQueObj.pizzaOrderQue = PizzaQueso.Parmesano
        case 3:
            pizzaSelQueso.setText("No queso")
            MyQueObj.pizzaOrderQue = PizzaQueso.No_Queso
        default: break
        }
    }
}
