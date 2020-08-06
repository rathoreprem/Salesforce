trigger CustomStatus on Class__c (before update,after update) 
{
      if(Trigger.isBefore)
      {
        for(Class__c cls : Trigger.new)
        {
            if(cls.Custom_Status__c == 'Reset')
            {
                cls.MyCount__c = 0;
            }
        }
      }
       else
       {  
            Set<Id> classSet = new Set<Id>();
            for(Class__c cls : Trigger.new)
            {
                if(cls.Custom_Status__c == 'Reset')
                {
                    classSet.add(cls.Id);
                }
            }
            List<student__C> studentList = [SELECT id FROM Student__c WHERE Class__c IN:classSet];
            Delete studentList;
        }	
}