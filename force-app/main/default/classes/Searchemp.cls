public with sharing class Searchemp {

     public String name { get; set;}

    public list<Employee__c> myid { get; set; }

    public boolean searched{get;set;}

    public searchemp() {

    searched=false;

    string namestr=ApexPages.currentPage().getParameters().get('name');
    string namestr1=ApexPages.currentPage().getParameters().get('pincode__c');

    if(null!=namestr) {

    name=namestr;

    //executeSearch();

    }

    }

    public PageReference executeSearch() {

      searched=true;

    System.debug('name' +name);

    string searchstr=('%'+name+'%');
    

    System.debug(searchstr);
    

   // accounts= new List<Account>();

    myid=[select id,Name,Employee_ID__c,pincode__c from Employee__c where name Like:searchstr limit 20];

    System.debug(myid);

        return null;

    }

}