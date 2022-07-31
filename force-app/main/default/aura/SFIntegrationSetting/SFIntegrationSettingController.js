({
    doInit : function(cmp, event, helper){
        var action = cmp.get("c.getSFIntegrationSetting");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("From server: " + JSON.stringify(response.getReturnValue()));
                cmp.set("v.sfIntegrationSetting", response.getReturnValue());
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " +
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);
    },
    handleChange : function(component, event, helper) {
        // console.log('Checked::>> '+event.getSource().get('v.checked'));
        // console.log('Value::>> '+event.getSource().get('v.value'));
        console.log('ID:>> '+event.getSource().getLocalId());
        
        let sfIntegrationSetting = component.get('v.sfIntegrationSetting');
        let componentID = event.getSource().getLocalId();
        
        
        console.log('dsable::>> '+sfIntegrationSetting.Org_dsable_to_sdinfo1__c);
        console.log('sdinfo::>> '+sfIntegrationSetting.Org_sdinfo1_To_dsable__c);
        console.log('Allow to Both::>> '+sfIntegrationSetting.Allow_To_Both__c);
        console.log('Schedule on Time::>> '+sfIntegrationSetting.Sync_on_Schedule_Time__c);
        
        //console.log('sfIntegrationSetting');
        
        if(componentID && componentID == 'dsableToSdinfo'){
            //helper.setDsableToSdinfo(component, event);
            sfIntegrationSetting.Org_dsable_to_sdinfo1__c = event.getSource().get('v.checked');
            sfIntegrationSetting.Org_sdinfo1_To_dsable__c = false;
            sfIntegrationSetting.Allow_To_Both__c = false;
            sfIntegrationSetting.Sync_on_Schedule_Time__c = false;
        }else if(componentID && componentID == 'sdinfoToDsable'){
            //helper.setSdinfoToDsable(component, event);
            sfIntegrationSetting.Org_dsable_to_sdinfo1__c = false;
            sfIntegrationSetting.Org_sdinfo1_To_dsable__c = event.getSource().get('v.checked');
            sfIntegrationSetting.Allow_To_Both__c = false;
            sfIntegrationSetting.Sync_on_Schedule_Time__c = false;            
        }else if(componentID && componentID == 'bothWay'){
            //helper.setBothWay(component, event);
            sfIntegrationSetting.Org_dsable_to_sdinfo1__c = false;
            sfIntegrationSetting.Org_sdinfo1_To_dsable__c = false;
            sfIntegrationSetting.Allow_To_Both__c = event.getSource().get('v.checked');
            sfIntegrationSetting.Sync_on_Schedule_Time__c = false;
        }else if(componentID && componentID == 'scheduleTime'){
            //helper.setScheduleTime(component, event);
            sfIntegrationSetting.Org_dsable_to_sdinfo1__c = false;
            sfIntegrationSetting.Org_sdinfo1_To_dsable__c = false;
            sfIntegrationSetting.Allow_To_Both__c = false;
            sfIntegrationSetting.Sync_on_Schedule_Time__c = event.getSource().get('v.checked');
        }
        console.log('----------------------------------');
        console.log('dsable::>> '+sfIntegrationSetting.Org_dsable_to_sdinfo1__c);
        console.log('sdinfo::>> '+sfIntegrationSetting.Org_sdinfo1_To_dsable__c);
        console.log('Allow to Both::>> '+sfIntegrationSetting.Allow_To_Both__c);
        console.log('Schedule on Time::>> '+sfIntegrationSetting.Sync_on_Schedule_Time__c);
        component.set('v.sfIntegrationSetting',sfIntegrationSetting);
    },
    
    handleSubmit : function(component, event, helper){
        console.log('HandleSubmit1');
        var sfIntegrationSetting = component.get('v.sfIntegrationSetting');
        console.log('HandleSubmit2');
        if(sfIntegrationSetting.Org_dsable_to_sdinfo1__c || sfIntegrationSetting.Org_sdinfo1_To_dsable__c ||
           sfIntegrationSetting.Allow_To_Both__c || sfIntegrationSetting.Sync_on_Schedule_Time__c){
            console.log('If Condition::');
            //var action = cmp.get("c.getSFIntegrationSetting");
            var action = component.get("c.saveSFIntegrationSetting");
            action.setParams({'integrationDetails' :sfIntegrationSetting});
            console.log('Call Action::');
            action.setCallback(this, function(response) {
                var state = response.getState();
                console.log('state::>>'+state);
                if (state === "SUCCESS") {
                    console.log("SUCCESS From server: " + JSON.stringify(response.getReturnValue()));
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success!',
                        message:'Data tranfer setting updated.',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'success',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                }
                else if (state === "INCOMPLETE") {
                    console.log('INCOMPLETE');
                }else if (state === "ERROR") {
                    console.log('ERROR');
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " +
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
            });
            $A.enqueueAction(action);
            
        }else{
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error',
                message:'Please select altest one option to sync data.',
                duration:' 5000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
        }
    }
})