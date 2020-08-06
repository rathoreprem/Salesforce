global class OppOwnermail implements Schedulable {
    global void execute(SchedulableContext ctx) {
        AggregateResult[] groupedResults = [SELECT owner.email email FROM Opportunity WHERE LastModifiedDate <  LAST_N_DAYS:30 GROUP BY owner.email];
        for (AggregateResult ar : groupedResults)  {
            String eml = String.valueOf(ar.get('email'));
            EmailManager.sendMail(eml, 'Trailhead Tutorial', 'Please update the Opportunity');
        }

    }
}