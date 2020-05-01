trigger StageOfOpportunity on Opportunity (before update) 
{
    for(Opportunity opp : Trigger.new)
    {
        if(opp.StageName == 'CLOSED WON' || opp.StageName == 'CLOSED LOST')
        {
            Opportunity oldOpp = trigger.oldMap.get(opp.Id);
            if(!(oldOpp.StageName == 'CLOSED WON' || oldOpp.StageName == 'CLOSED LOST'))
            {
                opp.CloseDate = date.today(); 
            }
        }
    }
}