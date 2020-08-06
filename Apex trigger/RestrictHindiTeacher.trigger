trigger RestrictHindiTeacher on Teach__c (before insert, before update) 
{
    final static String message = 'Sorry Hindi teachers can not create the account';
    if(Trigger.IsInsert)
    {
        for(Teach__c teach : Trigger.new)
        {
            If(teach.Subject__c.contains('Hindi'))
            {
                teach.Subject__c.addError(message);
            }
            
        }
    }
}