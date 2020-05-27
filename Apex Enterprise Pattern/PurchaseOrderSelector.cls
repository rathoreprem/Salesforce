public class PurchaseOrderSelector extends fflib_SObjectSelector 
{
    public Schema.SObjectType getSObjectType()
    {
        return Purchase_order__c.sObjectType;
    }
    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            Purchase_order__c.id,
            Purchase_order__c.OrderDate__c,
            Purchase_order__c.Order_Price__c,
            Purchase_order__c.Order_Status__c
        };
    }
    public List<Purchase_order__c> getAllOrders()
    {
        fflib_QueryFactory query = newQueryFactory();
        return (List<Purchase_order__c>) Database.query( query.toSOQL() );
    }
    public List<Purchase_order__c> getOrders(Integer Offset, String objectName, Integer limits, fflib_QueryFactory.SortOrder type)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.setOffset(Offset);
        query.setLimit(10);
        query.setOrdering(objectName, type);
        return (List<Purchase_order__c>) Database.query( query.toSOQL() );
    }
    public List<Purchase_order__c> getallOrderlist(Integer offset)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.setOffset(Offset);
        query.setLimit(10);
        return (List<Purchase_order__c>) Database.query( query.toSOQL() );
    }
  

    public List<Product2> selectByName(Set<String> names)
    {
        fflib_QueryFactory query = newQueryFactory();
       	query.addOrdering('Name', fflib_QueryFactory.SortOrder.ASCENDING);
       	return (List<Product2>) Database.query( query.toSOQL());
	}
}