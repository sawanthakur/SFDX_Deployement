({
	myAction : function(com, event, helper){
        //action
        var action = com.get("c.myMethod");
        
        // set callback
        action.setCallback(this,function(response) {
        // alert('callback called');
        com.set("v.accountList", response.getReturnValue());
    });
       // Enqueue action
       $A.enqueueAction(action);
     }
		
	
})