public class PriceDiscount{
public static void applyDIscount(List <Book__c> books)
{
 for(Book__c b: books)
  {
      b.Price__c *=0.9;
   }
 }
}