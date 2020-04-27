public class OpportunityManager 
{
    public static void updateManagerToAccountInOpp(List<Opportunity> listOpportunity)
    {
       Set<Id> opportunityIdSet = new Set<Id>();
        for(Opportunity opp : listOpportunity)
        {
           if(opp.BillToContact__c != null && opp.Manager__c == null)
           {
               opportunityIdSet.add(opp.id);
           }
       }
     if(opportunityIdSet.size() > 0)
     {
            List<Opportunity> listOpportunityToUpdate = [SELECT BillToContact__r.AccountId,Manager__c FROM Opportunity WHERE id IN : opportunityIdSet];
            for(Opportunity objOpp : listOpportunityToUpdate)
            {
            objOpp.Manager__c = objOpp.BillToContact__r.AccountId;
            }
            update listOpportunityToUpdate;
       }
   }
}