trigger StudentCountTrigger on Student__c (after insert,after update) 
{
    List<class__c> listOfClassesToUpdate = new List<class__c>();
    listOfClassesToUpdate = [SELECT Id, MyCount__c, (SELECT Id FROM Students__r) 
                             FROM Class__c 
                             WHERE Id 
                             IN (SELECT Class__c 
                                 FROM Student__c 
                                 WHERE Id 
                                 IN : Trigger.New)];
    for(class__c classToUpdate : listOfClassesToUpdate)  
    {
        classToUpdate.MyCount__c = classToUpdate.Students__r.size();
    }
    update listOfClassesToUpdate;
}