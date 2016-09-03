//
//  pizzaRebView.swift
//  CursoIOsWOSPR1
//
//  Created by Mauricio Jacobo Romero on 01/09/2016.
//  Copyright © 2016 MJ. All rights reserved.
//

import WatchKit
import Foundation


class pizzaRebView: WKInterfaceController {
    var listaOpciones : [(String, String)] = [
        ("4", "Número de rebanadas:"),
        ("8", "Número de rebanadas:"),
        ("16", "Número de rebanadas:"),
        ("24", "Número de rebanadas:")]
    
    @IBOutlet var pizzaSelRebanadas: WKInterfaceLabel!
    @IBOutlet var pickerRebanadas: WKInterfacePicker!
    
    
    var MyRebObj : MyOrder = MyOrder()
    

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        let c = context as! MyOrder
        MyRebObj=c
        
        if(c.pizzaOrderReb != PizzaOrderRebanada.NoSel){
            pizzaSelRebanadas.setText("\(c.pizzaOrderMas!) rebanadas")
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
        
        pickerRebanadas.setItems(pickerItems)
        pickerRebanadas.setSelectedItemIndex(0)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func selRebanadasOption(value: Int) {
        switch (value) {
        case 0:
            pizzaSelRebanadas.setText("4 rebanadas")
            MyRebObj.pizzaOrderReb = PizzaOrderRebanada.Cuatro
        case 1:
            pizzaSelRebanadas.setText("8 rebanadas")
            MyRebObj.pizzaOrderReb = PizzaOrderRebanada.Ocho
        case 2:
            pizzaSelRebanadas.setText("16 rebanadas")
            MyRebObj.pizzaOrderReb = PizzaOrderRebanada.DiezYSeis
        case 3:
            pizzaSelRebanadas.setText("24 rebanadas")
            MyRebObj.pizzaOrderReb = PizzaOrderRebanada.VeintiCuatro
        default: break
        }
    }
    

}
