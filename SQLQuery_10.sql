SELECT TOP (1000) [order_id]
      ,[customer_id]
      ,[order_status]
      ,[order_date]
      ,[required_date]
      ,[shipped_date]
      ,[store_id]
      ,[staff_id]
  FROM [Bikestores].[sales].[orders]


SELECT TOP (1000) [customer_id]
      ,[first_name]
      ,[last_name]
      ,[phone]
      ,[email]
      ,[street]
      ,[city]
      ,[state]
      ,[zip_code]
  FROM [Bikestores].[sales].[customers]


  Select *, state
  FROM [Bikestores].[sales].[orders], [Bikestores].[sales].[customers]

SELECT TOP (1000) [category_id]
      ,[category_name]
  FROM [Bikestores].[production].[categories]

  SELECT TOP (1000) [product_id]
      ,[product_name]
      ,[brand_id]
      ,[category_id]
      ,[model_year]
      ,[list_price]
  FROM [Bikestores].[production].[products]

  SELECT TOP (1000) [store_id]
      ,[product_id]
      ,[quantity]
  FROM [Bikestores].[production].[stocks]


--Select Data being used.

            --Proudct Items with Shipping Dates by Category with Location.

      Select top (7600000) order_date, required_date, shipped_date, state, category_name, ((product_name)), list_price
    From [Bikestores].[sales].[orders], [Bikestores].[sales].[customers], [Bikestores].[production].[categories], [Bikestores].[production].[products]

        --Products without Shipping Information
     Select top (7600000) state, category_name, ((product_name)), list_price
    From [Bikestores].[sales].[customers], [Bikestores].[production].[categories], [Bikestores].[production].[products]

        --Sale Order List Prices with Discounts.
    Select list_price, discount, (list_price*discount) as Discount_Price
    From [Bikestores].[sales].[order_items]

    --Max Discount Price
    Select list_price, discount, MAX((list_price*discount)) as Discount_Price
    From [Bikestores].[sales].[order_items]
    Group by list_price, discount
    order by Discount_Price desc


--NewPrice
Select  (list_price-(list_price*discount)) as NewPrice
From [Bikestores].[sales].[order_items]
order by NewPrice desc

--Min New Price
Select  MIN((list_price-(list_price*discount))) as MinNewPrice
From [Bikestores].[sales].[order_items]


--Max New Price
Select  MAX(list_price-(list_price*discount)) as HighestPrices
From [Bikestores].[sales].[order_items]

    --Products New Price by Store ID
    Select  (list_price-(list_price*discount)) as NewPrice, store_id
    From [Bikestores].[sales].[order_items], [Bikestores].[sales].[orders]
    Group by store_id, list_price, discount

            --Total Sum of Prices by City and State    
        Select SUM(list_price) as Total_Price, list_price, city, state
        From [Bikestores].[sales].[order_items], [Bikestores].[sales].[customers]
        Group by list_price, city, state
                   
            --Total Prices of Items by City/State/Category
        Select SUM(cast(list_price as int)) as Total_Price, city, state, category_name
        From [Bikestores].[sales].[order_items], [Bikestores].[sales].[customers], [Bikestores].[production].[categories]
        Group by city, state, category_name

        --Join to Look at Price and Discount quantity
        Select prod.product_id, prod.list_price, ord.discount, ord.quantity
        From [Bikestores].[production].[products] prod
        Join [Bikestores].[sales].[order_items] ord
            On prod.list_price = ord.list_price
            and prod.product_id = ord.product_id