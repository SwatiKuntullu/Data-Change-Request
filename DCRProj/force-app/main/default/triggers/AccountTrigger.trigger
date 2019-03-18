trigger AccountTrigger on Account (before update) {
    if(trigger.isBefore && trigger.isUpdate) {
        //Get all the records from the Custom settings Object
        List<DCR_Fields__c> fieldCS = DCR_Fields__c.getAll().values();
        boolean isDCRCreated = false;
        ID objDCRId;
        
        for(Account newAccRecord : Trigger.new) {
            // Get all the Account records with old values for comparsion
            Account oldAccRecord = Trigger.oldMap.get(newAccRecord.Id);
            //Check for each Account record, if any of the Account field mentioned in 
            //Custom Setting (Account.name or Account type) has changed, Create DCR object and DCR line Object
            for(DCR_Fields__c cs : fieldCS) {
                if (cs.Object_Name__c == 'Account') {
                    
                    if (newAccRecord.get(cs.Field_Name__c) != oldAccRecord.get(cs.Field_Name__c)) {
                        // Create a DCR Object and insert it 
                        if (isDCRCreated == false) {
                        	DCR__c objDCR = new DCR__c();
					 		isDCRCreated = true;
                        	Insert objDCR;
                            objDCRId = objDCR.Id;
                        }
                         // Create a DCR line items Object and assign the new and old valueinsert it 
                        DCR_Line__c objDCRLine = new DCR_Line__c();
                        objDCRLine.Field_Source__c = cs.Object_Name__c;
                        objDCRLine.Field_Name__c = cs.Field_Name__c;
                        objDCRLine.Old_Value__c = (string)oldAccRecord.get(cs.Field_Name__c);
                        objDCRLine.New_Value__c = (string)newAccRecord.get(cs.Field_Name__c);
                        objDCRLine.DCRLineStatus__c = 'Pending'; 
                        objDCRLine.DCR__c = objDCRId;
                        Insert objDCRLine;
                        // Reset the Old values to the fields which need Approval for Change.
                        newAccRecord.put(cs.Field_Name__c, oldAccRecord.get(cs.Field_Name__c));
                    }
                }
            }
        }
    }
}