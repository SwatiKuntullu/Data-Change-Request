public class DCRDataTableApexClass {
    @AuraEnabled
    public static List<DCR_Line__c> getAllDCRLineItems() {
        return [Select Id, Name, Field_Source__c, Field_Name__c, Old_Value__c, New_Value__c, DCRLineStatus__c from DCR_Line__c];
    }
    
    @AuraEnabled
    public static void updateDCR(List<DCR_Line__c> dcrLineItems) {
        for(DCR_Line__c dcrLineItem : dcrLineItems) {
            system.debug('dcrLineItem' + dcrLineItem);
            
            
            if (dcrLineItem.DCRLineStatus__c == 'Approved') {
             	
                // Update	 the Account or Address objects.
                if (dcrLineItem.Field_Source__c == 'Address') {
                    // Get address
                    // Update address
                    // address.put(dcrLineItem.Field_Name__c, dcrLineItem.New_Value__c);
                }
                else if (dcrLineItem.Field_Source__c == 'Account') {
                    
                }       
            }
        }
        
        update dcrLineItems;
    }
}