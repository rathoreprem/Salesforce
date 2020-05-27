public class ProductSelector extends fflib_SObjectSelector 
{
    public Schema.SObjectType getSObjectType()
    {
        return Product2.sObjectType;
    }
    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            Product2.Name,
            Product2.ProductCode,
            Product2.Description,
            Product2.Quantity_Available__c,
            Product2.Price_Per_Unit__c
        };
    }
    public List<Product2> getAllProducts()
    {
        fflib_QueryFactory query = newQueryFactory();
        return (List<Product2>) Database.query( query.toSOQL());
    }
    public List<Product2> getProducts(Integer Offset)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.setOffset(Offset);
        query.setLimit(10);
        return (List<Product2>) Database.query( query.toSOQL() );
    }
    public List<Product2> getAllProductsList(Integer Offset, String objectName, Integer limits, fflib_QueryFactory.SortOrder type)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.setOffset(Offset);
        query.setLimit(10);
        query.setOrdering(objectName, type);
        return (List<Product2>) Database.query( query.toSOQL() );
    }
    public List<Product2> getAllProductsSearchByName(String searchProductName)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('name like \'%'+searchProductName+'%\'');
        return (List<Product2>) Database.query( query.toSOQL() );
    }
    public List<Product2> getProductsSearchByName(String searchProductName,Integer Offset)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.setOffset(Offset);
        query.setLimit(10);
        query.setCondition('name like \'%'+searchProductName+'%\'');
        return (List<Product2>) Database.query(query.toSOQL());
    }
    public List<Product2> selectByName(Set<String> names)
    {
        fflib_QueryFactory query = newQueryFactory();
       	query.addOrdering('Name', fflib_QueryFactory.SortOrder.ASCENDING);
       	return (List<Product2>) Database.query( query.toSOQL() );
	}
}