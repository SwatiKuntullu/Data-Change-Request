trigger AddressTrigger on Address__c (before update) {
    if(trigger.isBefore && trigger.isUpdate) {
        //Get all the records from the Custom settings Object
        List<DCR_Fields__c> fieldCS = DCR_Fields__c.getAll().values();
        boolean isDCRCreated = false;
        ID objDCRId;
        for(Address__c newAddrRecord : Trigger.new) {
            // Get all the Address records with old values for comparsion
            Address__c oldAddrRecord = Trigger.oldMap.get(newAddrRecord.Id);
            //Check for each Address record, if any of the Address field mentioned in 
            //Custom Setting (AddressLine1, AddressLine2, City, State, Zipcode, Zipcode4) has changed, Create DCR object and DCR line Object
            for(DCR_Fields__c cs : fieldCS) {
                if (cs.Object_Name__c == 'Address') {
                    system.debug('newAddrRecord' + newAddrRecord);
                    system.debug('oldAddrRecord' + newAddrRecord);
                    if (newAddrRecord.get(cs.Field_Name__c) != oldAddrRecord.get(cs.Field_Name__c)) {
                        DCR_Line__c objDCRLine = new DCR_Line__c();
                        objDCRLine.Field_Source__c = cs.Object_Name__c;
                        objDCRLine.Field_Name__c = cs.Field_Name__c;
                        objDCRLine.Old_Value__c = (string)oldAddrRecord.get(cs.Field_Name__c);
                        objDCRLine.New_Value__c = (string)newAddrRecord.get(cs.Field_Name__c);
                        objDCRLine.DCRLineStatus__c = 'Pending';
                        if (isDCRCreated == false) {
                        	DCR__c objDCR = new DCR__c(status__c = 'Open');
					 		isDCRCreated = true;
                        	Insert objDCR;
                            objDCRId = objDCR.Id;
                        }
                        
                        objDCRLine.DCR__c = objDCRId;
                        Insert objDCRLine;
                        newAddrRecord.put(cs.Field_Name__c, oldAddrRecord.get(cs.Field_Name__c));
                    }
                }
            }
        }
    }
}