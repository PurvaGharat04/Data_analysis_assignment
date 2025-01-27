-- Second: Provide SQL queries

-- Closed-ended questions:

-- 1) Top 5 brands by receipts scanned among users 21 and over ?
SELECT TOP 5 p.BRAND, COUNT(t.RECEIPT_ID) AS RECEIPT_COUNT
FROM TRANSACTIONS t
JOIN USERS u ON t.USER_ID = u.ID
JOIN PRODUCTS p ON t.BARCODE = p.BARCODE
WHERE u.AGE >= 21
AND BRAND <> 'BRAND NOT KNOWN'
GROUP BY p.BRAND
ORDER BY RECEIPT_COUNT DESC;

-- 2) What are the top 5 brands by sales among users that have had their account for at least six months?
SELECT TOP 5 p.BRAND, SUM(t.FINAL_SALE) AS TOTAL_SALES
FROM TRANSACTIONS t
JOIN USERS u ON t.USER_ID = u.ID
JOIN PRODUCTS p ON t.BARCODE = p.BARCODE
WHERE u.CREATED_DATE <= DATEADD(MONTH, -6, GETDATE())
AND BRAND <> 'BRAND NOT KNOWN'
GROUP BY p.BRAND
ORDER BY TOTAL_SALES DESC;

-- Open-ended questions: 

-- 2) Which is the leading brand in the Dips & Salsa category? 
-- Assumption: BRAND NOT KNOWN to be excluded from leading brand as it represents the BRANDS which are not clearly specified, so it's high volume of entries cannot be considered relevant as top brand.
SELECT TOP 1 BRAND, COUNT(*) AS PRODUCT_COUNT
FROM PRODUCTS
WHERE CATEGORY_2 IN ('Dips & Salsa')
AND BRAND <> 'BRAND NOT KNOWN'
GROUP BY BRAND
ORDER BY PRODUCT_COUNT DESC;

