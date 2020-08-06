trigger AccountTrigger on Account (before delete, before insert, before update) {
    for(Opportunity opp :[select id, name, closedate, stagename from Opportunity where accountId IN :Trigger.newMap.keySet() and (StageName='CLOSED WON' or StageName='CLOSED LOST')] ) {
        if(opp.StageName == 'CLOSED WON') {
            System.debug('This is closed won opportunity' + opp.Id);
            
        } else if(opp.StageName == 'CLOSED LOST') {
            System.debug('This is closed lost opportunity' + opp.Id);
        }
    }
    
    
}