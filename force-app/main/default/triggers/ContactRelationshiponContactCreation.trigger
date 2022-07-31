trigger ContactRelationshiponContactCreation on Contact (after insert,after update,after delete) {

    Set<Id> conSetId = new Set<Id>();
    List<Contact_Relationship__c> cRLst = new List<Contact_Relationship__c>();
    List<Contact> cnLst = new List<Contact>();

    for(Contact con: trigger.old){
        conSetId.add(con.Id);
    }
    for(Contact con : trigger.new) {
        if(con.Contact_Relationship__c == true){
            Contact_Relationship__c cr = new Contact_Relationship__c();
            cr.Name = con.LastName; 
            cr.CRName__c = con.id;
            cRLst.add(cr);
        } 
       
    }
    insert cRLst;
    

    cRLst = [SELECT Id, Name, CRName__c FROM Contact_Relationship__c where CRName__c  IN :conSetId];    
    for(Contact con : trigger.new) {
    if(con.Contact_Relationship__c == false){
           delete cRLst; 
        } 
    }
}