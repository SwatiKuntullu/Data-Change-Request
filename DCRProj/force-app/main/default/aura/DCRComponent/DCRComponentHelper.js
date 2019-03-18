({
    fetchData: function (cmp,event,helper) {
        console.log("fetchData Called");
        var action = cmp.get("c.getAllDCRLineItems");
        action.setCallback(this, function(response) {
            console.log("getAllDCRLineItemsCB" + response);
            var state = response.getState();
            if (state === "SUCCESS") {
                var data = response.getReturnValue();
                cmp.set('v.data',data);
            }
            // error handling when state is "INCOMPLETE" or "ERROR"
        });
        $A.enqueueAction(action);
    }
})