//
//  VC_AuftragNeu_03_Typ_Datum.swift
//  KUKU_V1.0
//
//  Created by Benedikt Kurz on 13.03.19.
//  Copyright © 2019 Benedikt Kurz. All rights reserved.
//

import UIKit

class VC_AuftragNeu_03_Typ_Datum: UIViewController {
    
    
    var auftrag = Auftrag()
    
    @IBOutlet weak var sgAuftragsTyp: UISegmentedControl!
    
    @IBOutlet weak var dpAnlieferung: UIDatePicker!
    @IBOutlet weak var dpAbzug: UIDatePicker!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        auftrag.deliverDate = dpAnlieferung.date
        auftrag.pickupDate = dpAbzug.date
        
    }
    

    @IBAction func sgChangeAuftragsTyp(_ sender: UISegmentedControl) {

        if sgAuftragsTyp.selectedSegmentIndex == 1 {
            dpAnlieferung.isEnabled = true
            dpAbzug.isEnabled = false
        } else if sgAuftragsTyp.selectedSegmentIndex == 0 {
            dpAnlieferung.isEnabled = true
            dpAbzug.isEnabled = true
        }
        
    }
    
    @IBAction func dpChangeAnlieferung(_ sender: UIDatePicker) {
        
        auftrag.deliverDate = dpAnlieferung.date
    }
    
    @IBAction func btnWeiter(_ sender: UIButton) {
        
        
        Auftrag.saveAuftrag(auftrag)
        
        
        
        /*
        // Encodieren im JSON-Format
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        
        
        if let json_auftrag = try? encoder.encode(auftrag) {
        
            print(json_auftrag)
       
            if let json_string_auftrag = String(data: json_auftrag, encoding: .utf8) {
                
                // ToDo -> Hier müssen noch die Daten gespeichert werden
                
                // Eingabe des Dokumenten-Verzeichnises
              
                let documentdir = getDocumentsDirectory()
                let auftrag_file = documentdir.appendingPathComponent("auftrag.json")
                print(auftrag_file.absoluteString)
                do {                   // Schreiben der JSON-Datei in das lokale Dokumenten-Verzeichnis
                    try json_string_auftrag.write(to: auftrag_file, atomically: true, encoding: .utf8) } catch {
                    print(error)
                }
                
                
                print(json_string_auftrag)
            }
        }
 
 */
       
    }
    
    static func saveAuftrag(_ data: Auftrag) {
        
        let fm = FileManager.init()
        let doc_path = docURL(for: "auftrag.json")
        
        // Prüfen ob das Verzeichnis bereits exisitiert
        if fm.fileExists(atPath: (doc_path?.absoluteString)!) {
            do {
            try fm.removeItem(atPath: (doc_path?.absoluteString)!)
            } catch {
                print(error)
            }
        }
       
        
        let enc = JSONEncoder()
        if let url = docURL(for: "auftrag.json")
        {
            do {
                let jsondata = try enc.encode(data)
                try jsondata.write(to: url)
                
            } catch {
                print(error)
            }
        }
        
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    @IBAction func dpChangeAbzug(_ sender: UIDatePicker) {
        
        auftrag.pickupDate = dpAbzug.date
    }
    
    private static func docURL(for filename: String) -> URL? {
        
        //sollte immer genau ein Ergebnis liefern
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        if let docDir = urls.first {
            return docDir.appendingPathComponent(filename)
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is VC_AuftragNeu_ZSM_1 {
            let vc = segue.destination as? VC_AuftragNeu_ZSM_1
            vc?.auftrag = self.auftrag
            
        }  else if segue.destination is PVC_AuftragNeu_ZSM_1 {
            let vc = segue.destination as? VC_AuftragNeu_ZSM_1
            vc?.auftrag = self.auftrag
            
        }
        
    }
    
    


}
