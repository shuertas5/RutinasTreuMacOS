//
//  formato.swift
//  RutinasTreu
//
//  Created by Salvador Huertas on 24/12/23.
//

import Foundation

func form(formato: String, numero: Double, opc: String) -> String {
    var vacio = false
    var forma = ""
    var formap = ""
    var lon = formato.count
    var minimo = false
    var detras = false
    var detraspos = false
    var paren = false
    var relle = false
    var blancos = false
    var carelle: Character = " "
    var americano = false
    var conespacios = true
    var ponersignomas = false
    var recortar = false
    var interno = false
    
    var coma: Character
    var punto: Character
    
    for car in opc {
        
        if car == "m" {
            minimo=true
        }
        if car == "k" {
            conespacios = false
        }
        if car == "B" {
            blancos = true
        }
        if car == "0" || car == "*" {
            relle=true
            carelle = car
        }
        if car == "D" {
            detras = true
        }
        if car == "d" {
            detras = true
            detraspos = true
        }
        if car == "P" {
            paren = true
        }
        if car == "A" {
            americano = true
        }
        if car == "+" {
            ponersignomas = true
        }
        if car == "R" {
            recortar=true
        }
        if car == "i" {
            interno = true
        }
    }
        
    if minimo {
        relle = false
    }
    if !americano{
        coma = ","
        punto = "."
    }
    else {
        coma = "."
        punto = ","
    }
    
    var decimalcoma: Character = ","
            
    var contx=0
    var dec=0
    for i in 1...lon {
        let index = formato.index(formato.startIndex, offsetBy: lon - i)
        if formato[index] == coma {
            dec = contx
            break;
        }
        contx+=1
    }
    
    var negativo = false
    var numerox = numero
    if numero<0.0 {
        numerox = -1 * numero
        negativo = true
    }
    
    var num = round(numerox*pow(10,Double(dec)))
    
    var forma2 = String(Double(num))
    var forma22 = String(forma2)
    for i in 1...forma22.count {
        let index = forma22.index(forma22.startIndex, offsetBy: i-1)
        if (forma22[index]=="-") {
            forma22.replaceSubrange(index...index, with: String(" "))
        }
    }
    
    for i in 1...lon {
        forma.append(" ")
    }
    var loni = forma22.count
    
    var ib = 1
    var blan = false
    
    var i = 1
    while i <= lon {
        if i <= dec {
            if ib < loni {
                let index = forma22.index(forma22.startIndex, offsetBy: loni - ib)
                var car = forma22[index]
                let index2 = forma.index(forma.startIndex, offsetBy: lon - i)
                forma.replaceSubrange(index2...index2, with: String(car))
            }
            else {
                blan = true
                let index2 = forma.index(forma.startIndex, offsetBy: lon - i)
                forma.replaceSubrange(index2...index2, with: String("0"))
            }
        }
        if i == dec {
            i += 1
            let index2 = forma.index(forma.startIndex, offsetBy: lon - i)
            forma.replaceSubrange(index2...index2, with: String(coma))
            if blan == true || ib == loni {
                i += 1
                let index2 = forma.index(forma.startIndex, offsetBy: lon - i)
                forma.replaceSubrange(index2...index2, with: String("0"))
            }
            i += 1
            continue
        }
        if i > dec {
            if i <= loni {
                let index = forma22.index(forma22.startIndex, offsetBy: loni - ib)
                var car = forma22[index]
                let index2 = formato.index(formato.startIndex, offsetBy: lon - i)
                var carx = forma22[index2]
                if carx == punto {
                    let index2 = forma.index(forma.startIndex, offsetBy: lon - i)
                    forma.replaceSubrange(index2...index2, with: String(punto))
                    ib -= 1
                }
                else {
                    let index2 = forma.index(forma.startIndex, offsetBy: lon - i)
                    forma.replaceSubrange(index2...index2, with: String(car))
                }
            }
        }
        i += 1
    }
    
    ib -= 1
    var lleno = false
    if ib > forma22.count {
        lleno = false
    }
    if ib == forma22.count {
        if !negativo {
            if !detras {
                lleno = true
            }
            if paren {
                lleno = true
            }
        }
        else {
            if ponersignomas {
                if !detras {
                    lleno = true
                }
            }
        }
    }
    if ib < forma22.count {
        lleno = true
    }
    
    if lleno {
        for i in 1...lon {
            let index2 = forma.index(forma.startIndex, offsetBy: lon - i)
            forma.replaceSubrange(index2...index2, with: String("*"))
        }
        if detras {
            if !detraspos {
                forma.append(" ")
            }
            else {
                forma.append("+")
            }
        }
    }
    else {
        if num < 0.0001 && num > -0.0001 && blancos {
            for i in 1...lon {
                let index2 = forma.index(forma.startIndex, offsetBy: i - 1)
                forma.replaceSubrange(index2...index2, with: String(" "))
                vacio = true
            }
        }
        else {
            if minimo && dec > 0 {
                var bus = true
                var ii = 0
                for i in dec+1...1 {
                    if !bus {
                        break
                    }
                    let index2 = forma.index(forma.startIndex, offsetBy: lon - ii - 1)
                    var car = forma[index2]
                    if car == "0" || car == "," || car == "." {
                        forma.replaceSubrange(index2...index2, with: String(" "))
                    }
                    else {
                        bus = false
                    }
                }
            }
        }
        
        if negativo {
            if detras {
                if !vacio {
                    forma.append("-")
                }
                else {
                    forma.append(" ")
                }
            }
            else {
                var puesto = false
                for i in 1...lon {
                    if puesto {
                        break
                    }
                    let index2 = forma.index(forma.startIndex, offsetBy: lon - i)
                    var car = forma[index2]
                    if car == " " && i > dec + 1 {
                        if !paren {
                            forma.replaceSubrange(index2...index2, with: "-")
                        }
                        else {
                            forma.replaceSubrange(index2...index2, with: "(")
                        }
                        puesto = true
                    }
                }
                if paren {
                    forma.append(")")
                }
            }
        }
        
        if !negativo && (detras || paren) {
            if !detraspos && !ponersignomas {
                forma.append(" ")
            }
            else if detraspos || ponersignomas {
                if !vacio {
                    forma.append("+")
                }
                else {
                    forma.append(" ")
                }
            }
            else {
                forma.append(" ")
            }
        }
        else if !negativo && ponersignomas && !detras && !paren {
            var puesto = false
            for i in 1...lon {
                if puesto {
                    break
                }
                let index2 = forma.index(forma.startIndex, offsetBy: lon - i)
                var car = forma[index2]
                if car == " " && i > dec + 1 {
                    if ponersignomas {
                        if !vacio {
                            forma.replaceSubrange(index2...index2, with: "+")
                        }
                    }
                    puesto = true
                }
            }
        }
    }
    
    if relle {
        for i in 1...forma.count {
            let index2 = forma.index(forma.startIndex, offsetBy: i - 1)
            var car = forma[index2]
            if car == " " {
                forma.replaceSubrange(index2...index2, with: String(carelle))
            }
            else {
                break
            }
        }
    }
    
    if !conespacios {
        var forma3 = ""
        for i in 1...forma.count {
            let index2 = forma.index(forma.startIndex, offsetBy: i - 1)
            if forma[index2] != " " {
                forma3.append(forma[index2])
            }
        }
    }
    
    var salida = ""
    if forma.count > 0 {
        if recortar && forma.starts(with: "*") && !interno {
            salida = checkanumero(numero: numero,formato: formato,americano: americano,detras: detras)
        }
        else {
            salida = forma
        }
    }
    else {
        salida = forma
    }
    
    if decimalcoma != coma && !americano && !interno {
        formap = salida
        for s in 1...formap.count {
            let index2 = formap.index(formap.startIndex, offsetBy: s - 1)
            var car = formap[index2]
            if car == "," {
                formap.replaceSubrange(index2...index2, with: ".")
            }
            else if car == "." {
                formap.replaceSubrange(index2...index2, with: ",")
            }
        }
        salida = formap
    }
    
    return salida
}

func checkanumero(numero: Double, formato: String, americano: Bool, detras: Bool) -> String {
    
    var textox = ""
    let ampliacion = "############"
    var opc = ""
    
    if americano {
        opc = "i"
    }
    else {
        opc = "Ai"
    }
    
    if detras {
        opc+="D"
    }
    
    textox = form(formato: ampliacion+formato, numero: numero, opc: opc)
    
    var coma: Character = ","
    var punto: Character = "."
    if americano {
        coma = "."
        punto = ","
    }
    
    var longipre = 0
    for i in 1...formato.count {
        let index2 = formato.index(formato.startIndex, offsetBy: i - 1)
        let car = formato[index2]
        if car != punto && car != coma {
            longipre += 1
        }
        if car == coma {
            break
        }
    }
    
    var longipos=0
    var salta = false
    for i in 1...formato.count {
        let index2 = formato.index(formato.startIndex, offsetBy: i - 1)
        let car = formato[index2]
        if car != punto && salta {
            longipos += 1
        }
        if car == coma {
            salta = true
        }
    }
    
    var longi = longipre + longipos + 1
    var poscoma = 0
    for i in 1...textox.count {
        let index2 = textox.index(textox.startIndex, offsetBy: i - 1)
        let car = textox[index2]
        if car == punto {
            poscoma = i - 1
        }
        if car == coma {
            poscoma = i - 1
        }
    }
    if poscoma == 0 {
        poscoma = textox.count
    }
    
    var precoma = 0
    for i in 1...textox.count {
        let index2 = textox.index(textox.startIndex, offsetBy: i - 1)
        let car = textox[index2]
        if car != punto && car != coma {
            precoma += 1
        }
        else if car != coma {
            break
        }
    }
    
    var concoma = false
    for i in 1...textox.count {
        let index2 = textox.index(textox.startIndex, offsetBy: i - 1)
        let car = textox[index2]
        if car == coma || car == punto {
            concoma = true
            break
        }
    }
    
    var conmenos = false
    for i in 1...textox.count {
        let index2 = textox.index(textox.startIndex, offsetBy: i - 1)
        let car = textox[index2]
        if car == "-" {
            conmenos = true
            break
        }
    }

    if precoma > longipre {
        let index1 = textox.index(textox.startIndex, offsetBy: 0)
        let index2 = textox.index(textox.startIndex, offsetBy: precoma - longipre)
        textox.removeSubrange(index1...index2)
        conmenos = false
    }
    
    if longipre == 1 && conmenos {
        let index1 = textox.index(textox.startIndex, offsetBy: 0)
        let index2 = textox.index(textox.startIndex, offsetBy: 1)
        //textox.removeSubrange(index1...index2)
    }
    
    return textox
}

