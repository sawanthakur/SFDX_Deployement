public class ContactRelationshiprHandler {
    
public void createContactRelationshipByContact(list<Contact> ConLst)
{
ConLst = new list<Contact>();
list<Contact_Relationship__c> ConList= new list<Contact_Relationship__c>();
for(Contact newconts:ConLst)
{
if(newconts.Contact_Relationship__c == true)
{
Contact_Relationship__c CR = new Contact_Relationship__c();
CR.Name = newconts.LastName;
CR.CRName__c = newconts.id;
ConList.add(CR);
}
}
insert ConList;

}
}