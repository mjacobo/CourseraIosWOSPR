//
//  pizzaApp.swift
//  CCAppIOsPizzaMJR
//
//  Created by Mauricio Jacobo Romero on 22/08/2016.
//  Copyright © 2016 MJ. All rights reserved.
//

import Foundation
import UIKit
import WatchKit


enum PizzaTam: Int {
    case NoSel=0, Chica, Mediana, Grande
    
    init(){
        self = .NoSel
    }
}

enum PizzaMasa: Int {
    case NoSel=0, Delgada, Mediana, Gruesa
    
    init(){
        self = .NoSel
    }
}

enum PizzaQueso: Int {
    case NoSel=0, Cheddar, Mozarella, Parmesano, No_Queso
    
    init(){
        self = .NoSel
    }
}

struct PizzaIngredientes {
    var misIngredientes = ["NoSel":false,
                           "Aceituna": false,
                           "Anchoa":false,
                           "Cebolla":false,
                           "Jamon":false,
                           "Pavo":false,
                           "Pepperoni":false,
                           "Pimiento":false,
                           "Piña":false,
                           "Salchicha":false]
    init(){
        self.misIngredientes["NoSel"]=true
    }
    
    mutating func AddMyIngredient(Ingredient: String, Include: Bool) -> Bool
    {
        if (self.misIngredientes[Ingredient] == true){
            self.misIngredientes[Ingredient] = false
            let filter2 = self.misIngredientes.filter { $0.1 == true }
            if (filter2.count == 0) {
                self.misIngredientes["NoSel"]=true
            }
            return true
        } else {
            let filtered = self.misIngredientes.filter { $0.1 == true }
            if(filtered.count < 5) {
                self.misIngredientes["NoSel"]=false
                self.misIngredientes[Ingredient]=Include
                return true
            }else{
                return false
            }
        }
    }

    func printMyIngredients () -> String {
        let filtered = self.misIngredientes.filter { $0.1 == true }
        var ingredients : String? = ""
        
        for (key, _) in filtered {
            ingredients! += (key == "NoSel") ?"  Elija sus ingredientes.  " : " \(key),"
        }
        
        ingredients! = ingredients!.substringToIndex(ingredients!.endIndex.predecessor())
        
        return ingredients!
    }
}


enum PizzaOrderRebanada: Int {
    case NoSel=0, Cuatro=4, Ocho=8, DiezYSeis=16, VeintiCuatro=24
    
    init(){
        self = .NoSel
    }
}

enum PizzaOrderEntrega: Int {
    case NoSel=0, Quince = 15, Media = 30, Hora = 60, Hora_y_Media = 90
    
    init(){
        self = .NoSel
    }
}



class MyOrder {
    var pizzaOrderTam : PizzaTam?   = PizzaTam.init()
    var pizzaOrderMas : PizzaMasa?  = PizzaMasa.init()
    var pizzaOrderQue : PizzaQueso? = PizzaQueso.init()
    var pizzaOrderIng : PizzaIngredientes? = PizzaIngredientes.init()
    var pizzaOrderReb : PizzaOrderRebanada? = PizzaOrderRebanada.init()
    var pizzaOrderEnt : PizzaOrderEntrega? = PizzaOrderEntrega.init()
    
    func setPizzaOrderTam (newVal: PizzaTam){
        pizzaOrderTam = newVal
    }
    
    func setPizzaOrderMas (newVal: PizzaMasa){
        pizzaOrderMas = newVal
    }
    
    func setPizzaOrderQue (newVal: PizzaQueso){
        pizzaOrderQue = newVal
    }
    
    func setPizzaOrderIng (newVal: PizzaIngredientes){
        pizzaOrderIng = newVal
    }
    
    func setPizzaOrderReb (newVal: PizzaOrderRebanada){
        pizzaOrderReb = newVal
    }
    
    func setPizzaOrderEnt (newVal: PizzaOrderEntrega){
        pizzaOrderEnt = newVal
    }
    
    func printMyOrder() -> String {
         var mess = ""
         mess += ((pizzaOrderTam == PizzaTam.NoSel) ? "Tamaño: --  ":"Tamaño: \(pizzaOrderTam!)  --  ")
         mess += ((pizzaOrderMas == PizzaMasa.NoSel) ? "Masa: --  ":"Masa: \(pizzaOrderMas!)  --  ")
         mess += ((pizzaOrderQue == PizzaQueso.NoSel) ? "Queso: --  ":"Queso: \(pizzaOrderQue!)  --  ")
        mess += (pizzaOrderIng!.misIngredientes["NoSel"] == true) ? "Ingredientes:   --  " :"Ingredientes: " + (pizzaOrderIng?.printMyIngredients())! + "  --  "
         mess += ((pizzaOrderReb == PizzaOrderRebanada.NoSel) ? "Rebanadas: --  ":"Rebanadas: \(pizzaOrderReb!.rawValue) --  ")
         mess += ((pizzaOrderEnt == PizzaOrderEntrega.NoSel) ? "Entrega: ##  ":"Entrega: \(pizzaOrderEnt!.rawValue) minutos  ##  ")
        
        return mess
    }
}

