public with sharing class Searchname {

     public String name { get; set;}

    public list<Technician__c> myid { get; set; }

    public boolean searched{get;set;}

    public searchname() {

    searched=false;

    string namestr=ApexPages.currentPage().getParameters().get('name');

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

    myid=[select id,Name,Technician_ID__c,pincode__c from Technician__c where name Like:searchstr limit 20];

    System.debug(myid);

        return null;

    }

}