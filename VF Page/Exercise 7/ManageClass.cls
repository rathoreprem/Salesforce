public class ManageClass 
{
   public Id id
   {
       get;set;
   }
   
   public ApexPages.StandardSetController setController
   {
       get
       {
           if(setController==null)
           {
               setController = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id, Name, ClassTeacher__c, DetailedDescription__c, Custom_Status__c, MaxSize__c,Mycount__c,Board__c,Fee__c FROM Class__c]));
           }
           return setController;
       }
       set;
   }
   
   public List<Class__c> getClassList()
   {
       return setController.getRecords();
   }
   
   public void deleteClass()
   {
       delete new Map<Id,Class__c>(getClassList()).get(id);
       id=null;
       setController = null;
   }
   
   public Class__c getClass()
   {
       return new Map<Id,Class__c>(getClassList()).get(id);
   }
   
   public void save()
   {
       update new Map<Id,Class__c>(getClassList()).get(id);
       id=null;
       setController = null;
   }
   
   public void cancel()
   {
       id=null;
   }
}