trigger updateAmountOnAccountFromOpp on Account (before update) {

    if(trigger.IsBefore && trigger.IsUpdate){
       updateAmountOnAccountHandler uAmtHnlr = new updateAmountOnAccountHandler();
       uAmtHnlr.updateAmountFromOppotunities(trigger.new); 
    }
    

}