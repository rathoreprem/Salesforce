trigger StageOfOpportunity on Opportunity (before update) 
{
    for(Opportunity opp : Trigger.new)
    {
        Opportunity oldOpp = trigger.oldMap.get(opp.Id);
        if(opp.StageName == 'CLOSED WON' || opp.StageName == 'CLOSED LOST' && !(oldOpp.StageName == 'CLOSED WON' || oldOpp.StageName == 'CLOSED LOST'))
        {
                opp.CloseDate = date.today(); 
        }
        
    }
}