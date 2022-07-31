trigger DiscountTrigger on Book__c (before insert, before update) {
List<Book__c> books= Trigger.New;
PriceDiscount.applyDIscount(books);

}