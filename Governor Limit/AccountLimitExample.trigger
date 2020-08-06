trigger AccountLimitExample on Account (before insert) {
    System.debug('Total Number of SOQL Queries allowed in this apex code context' + Limits.getLimitQueries());
    System.debug('Total Number of records that can be queried in this Apex code context: ' + Limits.getLimitDMLRows());
    System.debug('Total Number of DML statements allowed in this Apex code context: ' + Limits.getLimitDMLStatements());
    System.debug('Total Number of CPU usage time (in ms) allowed in this Apex code context: ' + Limits.getLimitCpuTime()); 
    
    List<Opportunity> opptys = [select id, description, name, accountid, closedate, stagename from Opportunity where accountId IN:Trigger.newMap.keySet()];
    
    System.debug('1. Number of Queries used in this Apex code so far: ' + Limits.getQueries());
    System.debug('2. Number of rows queried in this Apex code so far: ' + Limits.getDMLRows());
    System.debug('3. Number of DML statements used so far: ' + Limits.getDMLStatements());
    System.debug('4. Amount of CPU time (in ms) used so far: ' + Limits.getCpuTime());
    
    if(opptys.size() > Limits.getLimitDmlRows()) {
        
    } else {
        System.debug('Continue processing. Not going to hit DML governor limits');
        System.debug('Going to update ' + opptys.size() + ' opportunities and governor limits will allow ' + limits.getLimitDMLStatements() );  
        for(Account acc : Trigger.New) {
            System.debug('Number of DML statements used so far: ' + Limits.getDmlStatements());
            for(Opportunity opp : opptys) {
                if(opp.AccountId == acc.Id) {
                    opp.Description = 'testing';
                }
            }
        }
        update opptys;
        System.debug('Final number of DML statements used so far: ' + limits.getDmlStatements());
        System.debug('Final heap size: ' + Limits.getHeapSize());
    }  
}