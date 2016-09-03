//
//  pizzaEntView.swift
//  CursoIOsWOSPR1
//
//  Created by Mauricio Jacobo Romero on 01/09/2016.
//  Copyright © 2016 MJ. All rights reserved.
//

import WatchKit
import Foundation


class pizzaEntView: WKInterfaceController {
    var listaOpciones : [(String, String)] = [
        ("15", "Entrega en:"),
        ("30", "Entrega en:"),
        ("60", "Entrega en:"),
        ("90", "Entrega en:")]
    
    
    var MyEntObj : MyOrder = MyOrder()
    
    @IBOutlet var pizzaSelEntrega: WKInterfaceLabel!
    @IBOutlet var pickerEntrega: WKInterfacePicker!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        let c = context as! MyOrder
        MyEntObj=c
        
        if(c.pizzaOrderEnt != PizzaOrderEntrega.NoSel){
            pizzaSelEntrega.setText("\(c.pizzaOrderEnt!.rawValue) minutos")
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
        
        pickerEntrega.setItems(pickerItems)
        pickerEntrega.setSelectedItemIndex(0)
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func selEntregaOption(value: Int) {
        switch (value) {
        case 0:
            pizzaSelEntrega.setText("15 minutos")
            MyEntObj.pizzaOrderEnt = PizzaOrderEntrega.Quince
        case 1:
            pizzaSelEntrega.setText("30 minutos")
            MyEntObj.pizzaOrderEnt = PizzaOrderEntrega.Media
        case 2:
            pizzaSelEntrega.setText("60 minutos")
            MyEntObj.pizzaOrderEnt = PizzaOrderEntrega.Hora
        case 3:
            pizzaSelEntrega.setText("90 minutos")
            MyEntObj.pizzaOrderEnt = PizzaOrderEntrega.Hora_y_Media
        default: break
        }
    }
}
