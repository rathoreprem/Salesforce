public class Account_Search 
{
   private String billingCity='';
   private String billingState='';
   private String billingCountry='';
   private Integer pageSize = 10;
   
   private String getQuery()
   {
       String condition = '';
           if(!String.isEmpty(billingCity)){
               condition += 'BillingCity LIKE \'%'+billingCity+'%\' AND ';
           }
           if(!String.isEmpty(billingState)){
               condition += 'BillingState LIKE \'%'+billingState+'%\' AND ';
           }
           if(!String.isEmpty(billingCountry)){
               condition += 'BillingCountry LIKE \'%'+billingCountry+'%\' AND ';
           }
           condition = condition.removeEnd(' AND ');
           String query = 'SELECT Name, BillingCity, BillingState, BillingCountry FROM Account'+(String.isEmpty(condition)?'':' WHERE ('+condition+')');
        return query;
   }
   
   public ApexPages.StandardSetController setController 
   {
       get 
       {
           if(setController==null)
           {
               setController = new ApexPages.StandardSetController(Database.getQueryLocator(getQuery()));
               setController.setPageSize(pageSize);
           }
           return setController;
       }
       set;
   }
   
   public List<Account> getAccounts()
   {
       return (List<Account>) setController.getRecords();
   }
   
   public void search()
   {
       setController = new ApexPages.StandardSetController(Database.getQueryLocator(getQuery()));
       setController.setPageSize(pageSize);
   }
   
   public String getBillingCity()
   {
       return billingCity;
   }
   
   public void setBillingCity(String billingCity)
   {
       this.billingCity = billingCity;
   }
   
   public String getBillingState()
   {
       return billingState;
   }
   
   public void setBillingState(String billingState)
   {
       this.billingState = billingState;
   }
   
   public String getBillingCountry()
   {
       return billingCountry;
   }
   
   public void setBillingCountry(String billingCountry)
   {
       this.billingCountry = billingCountry;
   }
   
   public Integer getPageSize()
   {
       return pageSize;
   }
   
   public void setPageSize(Integer pageSize)
   {
       this.pageSize= pageSize;
   }
}