({
	doInit : function(component, event, helper) {
		var action = component.get('c.getRecentAccounts');
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid() && response.getReturnValue() != null)
            {
                component.set('v.AccountList', response.getReturnValue());
            }            
        });    
        $A.enqueueAction(action);
	}
})