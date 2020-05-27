public class ShoppingCart_Controller
{
    public Double total{get;set;}
    public Integer PageNumber{get;set;}
    public String ProductSortOrder{get;set;}
    public String PurchaseSortOrder{get;set;}
    public Integer totalRecord{get;set;}
    public Integer SearchedtotalRecord{get;set;}
    public List<Purchase_order__c> purchaseorders{get;set;}
    public List<Purchase_order__c> purchaseordersbysort{get;set;}
    public Integer limitSize{get;set;}
    public Integer OffSetSize{get;set;}
    public Boolean ShouldSortProduct{get;set;}
    public Boolean ShouldSortPurChase{get;set;}
    public String SortingTypeOfProductList{get;set;}
    public Id removeProductFromCart{get;set;}
    public datetime invoicedate{get;set;}
    public String showerrorMsg{get;set;}
    public fflib_QueryFactory.SortOrder type{get;set;}
    public fflib_QueryFactory.SortOrder typeOfSorting{get;set;}
    public String purchaseSort{get;set;}
    public String productSort{get;set;}
    public String searchProductName{get;set;}
    public string orderByColumn;
    public Boolean isAsscending=true; 
    public Boolean showproducts{get;set;}
    public ApexPages.StandardSetController setController{get;set;}
    public List<InvoiceDetail> listOfInvoiceproduct{get;set;}
    public Boolean showinvoice{get;set;}
    public List<CartDetail> duplicateCart{get;set;}
    public Boolean showcart{get;set;}
    public List<selectProductsToAddCart> AllproductList{get;set;}
    public Integer ResultSize
    {
        get
        {
            PurchaseOrderSelector purchaseSelector = new PurchaseOrderSelector();
            return purchaseSelector.getAllOrders().size();  
        }
        set;
    }
    public Boolean showhistory
    {
        get
        {
            return showhistory;
        }
        set;
    }
    public void AssignToALLProductList()
    {
        for(selectProductsToAddCart selectedProduct:this.productList)
        {
            for(selectProductsToAddCart selectedProducts:this.AllproductList)
            {
                if(selectedProduct.id == selectedProducts.id)
                {
                    selectedProducts.product.Quantity_Available__c = selectedProduct.product.Quantity_Available__c;
                    selectedProducts.shouldaddToCart = selectedProduct.shouldaddToCart;
                    break;
                }
            } 
        } 
    }
    public void fetchFromAllProductList()
    {
        for(selectProductsToAddCart selectedProduct : productList)
        {
            for(selectProductsToAddCart selectedProducts : AllproductList)
            {
                if(selectedProduct.id == selectedProducts.id)
                {
                    selectedProduct.product.Quantity_Available__c = selectedProducts.product.Quantity_Available__c;
                    selectedProduct.shouldaddToCart = selectedProducts.shouldaddToCart;
                    break;
                }
            } 
        }
    }
    public void searchPrductByName()
    {
        OffSetSize = 0;
        searchProduct();
    }
    public void searchProduct()
    {
        ProductSelector productSelector = new ProductSelector();
        this.AssignToALLProductList();
        if(!String.isEmpty(searchProductName))
        {
            productList = new List<selectProductsToAddCart>();
            for(product2 producttoaddinList:productSelector.getProductsSearchByName(searchProductName, (offsetSize * limitSize)))
            {
                productList.add(new selectProductsToAddCart(producttoaddinList));
            }
            totalRecord = productSelector.getAllProductsSearchByName(searchProductName).size();
        }
        else
        {
            productList = new List<selectProductsToAddCart>();
            for(product2 producttoaddinList:productSelector.getProducts(offsetSize*limitSize))
            {
                productList.add(new selectProductsToAddCart(producttoaddinList));
            }
            totalRecord = SearchedtotalRecord;
        }
        if(cartProducts != null)
        {
            for(CartDetail cart : cartProducts)
            {
                for(selectProductsToAddCart selectedProduct:productList)
                {
                    if(selectedProduct.product.id == cart.productOfCart.id)
                    {
                        selectedProduct.product.Quantity_Available__c = selectedProduct.product.Quantity_Available__c - cart.quantity;
                        break;
                    }
                }
            }
        }
        fetchFromAllProductList();
    }
    public void sort()
    {
        if(isAsscending)
        {
            sortPurchaseOrderAscending();
            isAsscending = false;
        }
        else
        {
          sortPurchaseOrderDscending();  
            isAsscending = true;
        }
    }
    public void sortOnProduct()
    {
        if(isAsscending)
        { 
            sortProductListAscending();
            isAsscending = false;
        }
        else
        {
            sortProductListDscending(); 
            isAsscending = true;
        }
    }
    public void sortPurchaseOrderAscending()
    {
        ShouldSortPurchase = true;
        PurchaseSortOrder = 'ASCENDING';
        PageNumber = 0;
        sortPurchase();
    }
    public void sortPurchaseOrderDscending()
    {
        ShouldSortPurchase = true;
        PurchaseSortOrder = 'DESCENDING';
        PageNumber = 0;
        sortPurchase();
    }
    public void sortPurchase()
    {
        String objectName = ApexPages.currentPage().getParameters().get('purchaseSort');
        if(PurchaseSortOrder == 'ASCENDING')
        {
            type = fflib_QueryFactory.SortOrder.ASCENDING;
            PurchaseOrderSelector purchaseSelector = new PurchaseOrderSelector();
            purchaseorders=purchaseSelector.getOrders(PageNumber*limitSize, objectName, limitSize, type); 
        }
        else
        {
            type = fflib_QueryFactory.SortOrder.DESCENDING;
            PurchaseOrderSelector purchaseSelector = new PurchaseOrderSelector();
        	purchaseorders= purchaseSelector.getOrders(PageNumber*limitSize, objectName, limitSize, type);
        }
    }
    public Boolean canGoBack
    {
        get
        {
            Boolean returnAnswer = false;
            if(OffSetSize > 0)
            {
                returnAnswer = true;
            }
            return returnAnswer;
        }
        set;
    }
   	public Boolean canGoNext
    {
        get
        {
            Boolean returnAnswer = false;
            if(OffSetSize<(math.ceil(totalRecord/10)))
            {
                returnAnswer = true;
            }
            return returnAnswer;
        }
        set;
    }
    public void goNext()
    {
        this.AssignToALLProductList();
        OffSetSize++;
        if(!String.isEmpty(searchProductName))
        {
            searchProduct();
        }
        else if(shouldSortProduct == true)
        {
            sortProduct();
        }
        else
        {
            showProductList();
        }
    }
    public void goLast()
    {
        this.AssignToALLProductList();
        OffSetSize = (Integer)(math.ceil(ResultSize/10));
        system.debug(OffSetSize);
        if(!String.isEmpty(searchProductName))
        {
            searchProduct();
        }
        else if(shouldSortProduct == true)
        {
            sortProduct();
        }
        else
        {
            showProductList();
        }
    }
    public void goPrevious()
    {
 		this.AssignToALLProductList(); 
        if(OffSetSize > 0)
        {
			OffSetSize--;
        }
        if(!String.isEmpty(searchProductName))
        {
            searchProduct();
        }
        else if(shouldSortProduct == true)
        {
            sortProduct();
        }
        else
        {
            showProductList();
        }
    }
    public void goFirst()
    {
 		this.AssignToALLProductList(); 
        if(OffSetSize > 0)
        {
			OffSetSize = 0;
        }
        if(!String.isEmpty(searchProductName))
        {
            searchProduct();
        }
        else if(shouldSortProduct == true)
        {
            sortProduct();
        }
        else
        {
            showProductList();
        }
    }
    public Boolean HasPrevious
    {
        get
        {
            Boolean returnAnswer = false;
            if(PageNumber > 0)
            {
                returnAnswer = true;
            }
            return returnAnswer;
        }
        set;
    }
   	public Boolean HasNext
    {
        get
        {
            Boolean returnAnswer = false;
            if(PageNumber < (math.ceil(ResultSize/10)))
            {
                returnAnswer = true;
            }
            return returnAnswer;
        }
        set;
    }
   	public void Next()
    {
  		PageNumber++;
        if(shouldSortPurchase == true)
        {
            sortPurchase();
        }
        else
        {
            String objectName = ApexPages.currentPage().getParameters().get('productSort');
            PurchaseOrderSelector purchaseSelector = new PurchaseOrderSelector();
            purchaseorders = purchaseSelector.getOrders(PageNumber*limitSize, objectName, limitSize, type); 
        }
    }
    public void Last()
    {
  		PageNumber = (Integer)(math.ceil(ResultSize/10));
        if(shouldSortPurchase == true)
        {
            sortPurchase();
        }
        else
        {
            String objectName = ApexPages.currentPage().getParameters().get('productSort');
            PurchaseOrderSelector purchaseSelector=new PurchaseOrderSelector();
            purchaseorders = purchaseSelector.getOrders(PageNumber*limitSize, objectName, limitSize, type); 
        }
    }
    public void Previous()
    {
        if(PageNumber>0)
        {
			PageNumber--;
        }
		if(shouldSortPurchase == true)
        {
            sortPurchase();
        }
        else
        {
            String objectName = ApexPages.currentPage().getParameters().get('productSort');
            PurchaseOrderSelector purchaseSelector = new PurchaseOrderSelector();
            purchaseorders = purchaseSelector.getOrders( PageNumber*limitSize, objectName, limitSize, type ); 
        }         
    }
    public void First()
    {
        if(PageNumber>0)
        {
			PageNumber = 0;
        }
		if(shouldSortPurchase == true)
        {
            sortPurchase();
        }
        else
        {
            String objectName = ApexPages.currentPage().getParameters().get('productSort');
			PurchaseOrderSelector purchaseSelector = new PurchaseOrderSelector();
            purchaseorders = purchaseSelector.getOrders(PageNumber*limitSize, objectName, limitSize, type); 
        }         
    }
    public void sortProductListAscending()
    {
        OffSetSize = 0;
        ShouldSortProduct = true;
        ProductSortOrder = 'ASCENDING';
        sortProduct();
    }
    public void sortProductListDscending()
    {
        OffSetSize = 0;
        ShouldSortProduct = true;
        ProductSortOrder = 'DEASCENDING';
        sortProduct();
    }
    public void sortProduct()
    {
        ProductSelector selectorProduct = new ProductSelector();
        String fieldName = ApexPages.currentPage().getParameters().get('productSort');
        this.AssignToALLProductList();
        if(String.isEmpty(searchProductName))
        {
            totalRecord = SearchedtotalRecord;
            productList = new List<selectProductsToAddCart>(); 
            if(ProductSortOrder == 'ASCENDING')
            {
                typeOfSorting = fflib_QueryFactory.SortOrder.ASCENDING;
                for(product2 producttoaddinList:selectorProduct.getAllProductsList( offsetSize*limitSize, fieldName, limitSize, typeOfSorting ))
                {
                    productList.add(new selectProductsToAddCart(producttoaddinList));
                }
            }
            else
            {
                typeOfSorting = fflib_QueryFactory.SortOrder.DESCENDING;
                for(product2 producttoaddinList:selectorProduct.getAllProductsList( offsetSize * limitSize, fieldName, limitSize, typeOfSorting ))
                {
                    productList.add(new selectProductsToAddCart(producttoaddinList));
                }
            }
        }
        else
        {
            productList = new List<selectProductsToAddCart>();
            if(ProductSortOrder == 'ASCENDING')
            {
                for(product2 producttoaddinList:selectorProduct.getProductsSearchByName(searchProductName, ( offsetSize * limitSize ))) 
                {
                    productList.add(new selectProductsToAddCart(producttoaddinList));
                }
            }
            else
            {
                for(product2 producttoaddinList:selectorProduct.getProductsSearchByName(searchProductName, ( offsetSize * limitSize )))
                {
                    productList.add(new selectProductsToAddCart(producttoaddinList));
                }
            }
        }
        if(cartProducts != null)
        {
            for(CartDetail cart:cartProducts)
            {
                for(selectProductsToAddCart selectedProduct : productList)
                {
                    if(selectedProduct.product.id == cart.productOfCart.id)
                    {
                        selectedProduct.product.Quantity_Available__c = selectedProduct.product.Quantity_Available__c - cart.quantity;
                        break;
                    }
                }
                for(selectProductsToAddCart selectedProduct:AllproductList)
                {
                    if(selectedProduct.product.id == cart.productOfCart.id)
                    {
                        selectedProduct.product.Quantity_Available__c = selectedProduct.product.Quantity_Available__c - cart.quantity;
                        break;
                    }
                }
            }
        }
        fetchFromAllProductList();
    }
    public ShoppingCart_Controller( ApexPages.StandardSetController setController)
 	{
        limitSize = 10;
        offsetSize = 0;
        showhistory = true;
		PageNumber = 0;
        AllproductList = new List<selectProductsToAddCart>();
        ProductSelector productSelector = new ProductSelector();
        for(product2 producttoaddinList : productSelector.getAllProducts())
        {
            AllproductList.add(new selectProductsToAddCart(producttoaddinList));
        }
        totalRecord = AllproductList.size();
        SearchedtotalRecord = totalRecord;
        String objectName = ApexPages.currentPage().getParameters().get('productSort');
        PurchaseOrderSelector purchaseSelector = new PurchaseOrderSelector();
        purchaseorders=purchaseSelector.getallOrderlist( PageNumber * limitSize ); 
    }
    
   
    public List<selectProductsToAddCart> productList
    {
        get
        {
            return productList;
        }
        set;
    }
    public List<CartDetail> cartproducts=new List<CartDetail>();
    public void remove()
    {
        if(removeProductFromCart != null)
        {
            showerrorMsg = '';
            Integer index = 0;
            for(CartDetail cartItem : cartproducts)
            {
                if(cartItem.productOfCart.id == removeProductFromCart)
                {   
                    cartproducts.remove(index);
                    for(selectProductsToAddCart selectedProduct : AllproductList)
               		{
                        if(selectedProduct.product.id == cartItem.productOfCart.id)
                        {
                            selectedProduct.product.Quantity_Available__c = selectedProduct.product.Quantity_Available__c + cartItem.quantity;
                        }
               		}
                    break;
                }
                index++;
            }
            fetchFromAllProductList();
        }
    }
    public List<CartDetail> getcartProducts()
    {
        return cartproducts;
    }
    public void addTocart()
    {
        this.AssignToALLProductList(); 
        showcart = true;
        if(cartproducts.size() == 0)
        {
            for(selectProductsToAddCart selectedproduct : AllproductList)
            {
                if(selectedproduct.shouldaddToCart == true)
                {
                	cartproducts.add(new CartDetail(selectedproduct.product)); 
                	selectedproduct.shouldaddToCart = false;
                	selectedproduct.product.Quantity_Available__c = selectedproduct.product.Quantity_Available__c - 1;
                }
            }
        }
        else
        {
            for(selectProductsToAddCart selectedproduct : AllproductList)
        	{
                if(selectedproduct.shouldaddToCart == true)
                {   
                    Integer flagfinditem = 0;
	                for(CartDetail cart : cartproducts)
                    {
                        if(cart.productOfCart.id == selectedproduct.product.id)
                        {
                            cart.quantity = cart.quantity + 1;
                            flagfinditem = 1;
                            selectedproduct.shouldaddToCart = false;
                            selectedproduct.product.Quantity_Available__c = selectedproduct.product.Quantity_Available__c - 1;
                        }
                    }
                    if(flagfinditem == 0)
                    {                   
                        cartproducts.add(new CartDetail(selectedproduct.product)); 
                        selectedproduct.shouldaddToCart = false;
                        selectedproduct.product.Quantity_Available__c = selectedproduct.product.Quantity_Available__c - 1;
                    }
                }
       		}
        }
 		fetchFromAllProductList();
        duplicateCart = new List<CartDetail>();
        for(CartDetail cart : cartproducts)
        {
            CartDetail c = new CartDetail(cart.productOfCart);
            c.quantity = cart.quantity;
            duplicateCart.add(c);
        }
    }
    public void showProductList()
    {       
        showinvoice = false;
        showProducts = true;
        productList = new List<selectProductsToAddCart>();
        ProductSelector productSelector = new ProductSelector();
        for(product2 producttoaddinList : productSelector.getProducts( offsetSize * limitSize ))
        {
            productList.add(new selectProductsToAddCart(producttoaddinList));
        }
        fetchFromAllProductList();
    }
    public void cancelOrder()
    {
        showhistory = true;
        showproducts = true;
        showcart = true;
        showinvoice = false;
    }
    public void checkout()
    {
       Integer error = 0;
       for(CartDetail detail : cartproducts)
        {
           if( detail.quantity > 0 )
           {
               for(CartDetail dupCart : duplicateCart)
                {
                    if(dupCart.productOfCart.id == detail.productOfCart.id)
                    {
                        if((dupCart.productOfCart.Quantity_Available__c - detail.quantity+dupCart.quantity) < 0 )
                        {
                           error = 1;
                        }
                        else
                        {
                            detail.productOfCart.Quantity_Available__c = dupCart.productOfCart.Quantity_Available__c - detail.quantity + dupCart.quantity;
                        }
                        break;
                    }
                }
            }
            else
            {
                error = 1;
                break;
            }
        }
        if(cartproducts == null || cartproducts.size() == 0)
        {
          error = 1;
        }
        if(error == 1)
        {
            showerrorMsg = 'Please check quantity value and compare from available quantity or check cart is not empty';
        }
        else
        {
            showerrorMsg = '';
            showhistory = false;
            showproducts = false;
            showcart = false;
            showinvoice = true;
            listOfInvoiceproduct = new List<InvoiceDetail>();
            Integer i = 0;
            total = 0;
            for(CartDetail detail : cartproducts)
            {
                listOfInvoiceproduct.add(new InvoiceDetail((detail.productOfCart), detail.quantity));
                total=total+listOfInvoiceproduct[i].totalcost;
                i++;
                for(selectProductsToAddCart selectedProduct : AllproductList)
                {
                    if(selectedProduct.product.id == detail.productOfCart.id)
                    {
                        selectedProduct.product.Quantity_Available__c = detail.productOfCart.Quantity_Available__c;
                    }
                }
            }
           fetchFromAllProductList();
       }
   }
    public void placeOrder()
    {
       ShoppingCartService  serviceofcart = new ShoppingCartService();
       List<product2> listOfproductsToUpdate = new List<product2>();
       for(selectProductsToAddCart selectedProduct:AllproductList)
       {
           listOfproductsToUpdate.add(selectedProduct.product);          
       }    
       if(listOfInvoiceproduct != null)
        {
            Purchase_order__c order = new Purchase_order__c();
            order.Order_Status__c = 'Pending';
            order.Order_Price__c = total;
            order.OrderDate__c = System.today();
            List<PurchaseOrderLineItem__c> listOfFinalOrderProducts = new List<PurchaseOrderLineItem__c>();
            for(InvoiceDetail finalList : listOfInvoiceproduct)
            {
                PurchaseOrderLineItem__c lineItem = new PurchaseOrderLineItem__c();
                lineItem.name = finalList.productOfInvoice.name;
                lineItem.Price_Per_Unit__c = finalList.productOfInvoice.Price_Per_Unit__c;
                lineItem.Quantity__c = finalList.quantity;
                lineItem.Purchaseorder__c = order.id;
                listOfFinalOrderProducts.add(lineItem);
            }
            serviceofcart.insertItems(listOfFinalOrderProducts, order, listOfproductsToUpdate); 
        }
        showhistory = true;
        showproducts = false;
        showcart = false;
        showinvoice = false;
        listOfInvoiceproduct = null;
        productList = null;
        cartproducts = new List<CartDetail>();
        AllproductList = new List<selectProductsToAddCart>();
        ProductSelector productSelector = new ProductSelector();
        for(product2 producttoaddinList:productSelector.getAllProducts())
        {
           AllproductList.add(new selectProductsToAddCart( producttoaddinList ));
        }
        PageNumber = 0;
        String objectName = ApexPages.currentPage().getParameters().get('productSort');
	    type = fflib_QueryFactory.SortOrder.ASCENDING;
        PurchaseOrderSelector purchaseSelector = new PurchaseOrderSelector();
        purchaseorders = purchaseSelector.getallOrderlist( PageNumber * limitSize ); 
    }
    
    public class selectProductsToAddCart
    {
        public product2 product
        {
            get;set;
        }
        public String id
        {
            get;set;
        }
        public Boolean shouldaddToCart
        {
            get;set;
        }
        public selectProductsToAddCart()
        {
            this.shouldaddToCart = false;
        }
        public selectProductsToAddCart(product2 product)
        {
            this();
            this.product = product;
            this.id = product.id;
        }
    }
    public class InvoiceDetail
    {
        public product2 productOfInvoice{get;set;}
        public Double totalCost{get;set;}
        Public Integer quantity{get;set;}
        public InvoiceDetail( product2 productOfInvoice, Integer quantity )
        {
            this.productOfInvoice = productOfInvoice;  
            this.quantity = quantity;
            this.totalCost = quantity * productOfInvoice.Price_Per_Unit__c;
        }
    }
    public class CartDetail
    {
        public product2 productOfCart{get;set;}
        Public Integer quantity{get;set;}
        public CartDetail( product2 productOfCart )
        {
            this.productOfCart = productOfCart;  
            this.quantity = 1;
        }
    }
    public void verifyCart()
    {
       Integer error = 0;
       for( CartDetail detail : cartproducts )
        {
           if( detail.quantity > 0 )
            {
               for( CartDetail dupCart : duplicateCart )
                {
                   if( dupCart.productOfCart.id == detail.productOfCart.id )
                    {
                       if(( dupCart.productOfCart.Quantity_Available__c-detail.quantity + dupCart.quantity ) < 0 )
                        {
                           error = 1;
                        }
                        else
                        {
                           detail.productOfCart.Quantity_Available__c = dupCart.productOfCart.Quantity_Available__c - detail.quantity + dupCart.quantity;
                            dupCart.quantity  =detail.quantity;
                        }
                        break;
                    }
                }
            }
           else
            {
               error = 1;
               break;
            }
        }
       if( cartproducts == null || cartproducts.size() == 0 )
        {
          error = 1;
           
        }
       if( error == 1 )
        {
           showerrorMsg = 'Please check quantity value and compare from available quantity';
        }
       else
        {
            for(CartDetail detail : cartproducts)
            {
               for(selectProductsToAddCart selectedProduct:AllproductList)
                {
                   if(selectedProduct.product.id == detail.productOfCart.id)
                    {
                       selectedProduct.product.Quantity_Available__c = detail.productOfCart.Quantity_Available__c;
                    }
                }
            }
           fetchFromAllProductList();
        }
    }
}