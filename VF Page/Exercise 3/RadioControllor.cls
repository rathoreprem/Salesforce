public class RadioControllor 
{
    String billContact = '';
    public PageReference test() 
    {
        return null;
    }
    public List<SelectOption> getItems() 
    {
        String MyParameter = ApexPages.currentPage().getParameters().get('managerId');
        List<Contact> contactList = [Select Id, Name 
                                    From Contact 
                                    Where AccountID =:Id.valueOf(MyParameter)
                                    ];
        List<SelectOption> options = new List<SelectOption>();
        for(Contact contactRecord : contactList)
        {
            options.add(new SelectOption(contactRecord.Id,contactRecord.Name) );
        }
        return options;
    }
    public PageReference Cancil()
    {
        Id opportunityId = Id.valueOf(ApexPages.currentPage().getParameters().get('Id'));
        PageReference pageRef = new PageReference('https://ap17.lightning.force.com/lightning/r/Opportunity/'+opportunityId+'/view');
        return pageRef;
        
    }
    public PageReference Save()
    {
        Id opportunityId = Id.valueOf(ApexPages.currentPage().getParameters().get('Id'));
        Opportunity opportunityRecord = [SELECT Id, Name, BillToContact__c 
                                        FROM Opportunity 
                                        WHERE Id =:opportunityId
                                        ];
        opportunityRecord.BillToContact__c = billContact;
        update opportunityRecord;
        PageReference pageRef = new PageReference('https://ap17.lightning.force.com/lightning/r/Opportunity/'+opportunityId+'/view');
        return pageRef; 
    }
    public PageReference Clear()
    {
        Id opportunityId = Id.valueOf(ApexPages.currentPage().getParameters().get('Id'));
        Opportunity opportunityRecord = [SELECT Id, Name, BillToContact__c 
                                        FROM Opportunity 
                                        WHERE Id =:opportunityId
                                        ];
        opportunityRecord.BillToContact__c = null;
        update opportunityRecord;
        PageReference pageRef = new PageReference('https://ap17.lightning.force.com/lightning/r/Opportunity/'+opportunityId+'/view');
        return pageRef;
        
    }
    public String getbillContact() 
    {
        return billContact;
    }
    public void setbillContact(String billContact) 
    { 
        this.billContact = billContact; 
    }
}