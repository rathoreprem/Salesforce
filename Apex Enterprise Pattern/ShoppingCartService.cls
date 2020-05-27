public class ShoppingCartService 
{
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
   	new Schema.SObjectType[] {
      Purchase_order__c.SObjectType,
      PurchaseOrderLineItem__c.SObjectType,
      Product2.SObjectType
   }
);
   public void insertItems(List<PurchaseOrderLineItem__c> items, Purchase_order__c order, List<Product2> products)
   {    
       uow.registerUpsert(products);
       uow.registerNew(order);
       for(PurchaseOrderLineItem__c item : items)
       {
       uow.registerNew(item, PurchaseOrderLineItem__c.Purchaseorder__c, order);
       }
       uow.commitWork();
   }
}