({
	init : function(component, event, helper) {
        console.log("Init Called which initializes columns");
        component.set('v.columns', [
            { label: 'Id', fieldName: 'Id', type: 'Id', editable: false },
            { label: 'DCR', fieldName: 'DCR_Line_Items.Name', type: 'Auto Number', editable: false }, 
            { label: 'DCR Line Name', fieldName: 'Name', type: 'Auto Number', editable: false }, 
            { label: 'Field Source', fieldName: 'Field_Source__c', type: 'Text', editable: false }, 
            { label: 'Field Name', fieldName: 'Field_Name__c', type: 'Text', editable: false }, 
            { label: 'Old Value', fieldName: 'Old_Value__c', type: 'Text', editable: false }, 
            { label: 'New Value', fieldName: 'New_Value__c', type: 'Text', editable: false }, 
            { label: 'Status', fieldName: 'DCRLineStatus__c', type: 'Text', editable: true } 
        ]);
        
        helper.fetchData(component,event, helper);
     },
     handleSaveEdition: function (component, event, helper) {
        console.log("SaveEdition Called");
        var draftValues = event.getParam('draftValues');
        console.log(draftValues);
        var action = component.get("c.updateDCR");
        action.setParams({"dcrLineItems" : draftValues});
        action.setCallback(this, function(response) {
            var state = response.getState();
            $A.get('e.force:refreshView').fire();
        });
        $A.enqueueAction(action);
     },
})