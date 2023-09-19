---PRACTICING DATA CLearnING WITH SQL

---Create data in sql 
Select *
From Learn.dbo.Nashville_Housing


---Standardize data format
Select SaleDateConverted2, CONVERT(Date, SaleDate) ---first select SaleDate, after the next 3 steps, change to select SaleDateConverted.
From Learn.dbo.Nashville_Housing

Update Nashville_Housing 
Set SaleDate = CONVERT(Date, SaleDate) 

Alter Table Nashville_Housing
Add SaleDateConverted2 Date;

Update Nashville_Housing
Set SaleDateConverted2 = CONVERT(Date, SaleDate) 


---Populate Property Address data

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From Learn.dbo.Nashville_Housing a
Join Learn.dbo.Nashville_Housing b
	on a.ParcelID = b.ParcelID
	And a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is Null

Update a      ---using the alias 'a' instead of 'Learn.dbo.Nashville_Housing'
Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From Learn.dbo.Nashville_Housing a
Join Learn.dbo.Nashville_Housing b
	on a.ParcelID = b.ParcelID
	And a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is Null

---Breaking out PropertyAddress into different coloumns. ie address, city, state USING SUBSTRING
Select PropertyAddress
From Learn.dbo.Nashville_Housing

Select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) As Address 
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) As Address
From Learn.dbo.Nashville_Housing

Alter Table Nashville_Housing
Add PropertySplitAddress Nvarchar(255);

Update Nashville_Housing
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 


Alter Table Nashville_Housing
Add PropertySplitCity Nvarchar(255);

Update Nashville_Housing
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


---Check if data was updated successfully
Select *
From Learn.dbo.Nashville_Housing


---Breaking out OwnerAddress into different coloumns. ie address, city, state USING PARSENAME
Select OwnerAddress
From Learn.dbo.Nashville_Housing

Select 
PARSENAME(OwnerAddress,1)
From Learn.dbo.Nashville_Housing
---Parsename only works with period not commas. so we replace the commas with periods and try again
Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
From Learn.dbo.Nashville_Housing

---now update after parsing
Alter Table Nashville_Housing
Add OnwerSplitAddress Nvarchar(255);

Update Nashville_Housing
Set OnwerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) 

Alter Table Nashville_Housing
Add OnwerSplitCity Nvarchar(255);

Update Nashville_Housing
Set OnwerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

Alter Table Nashville_Housing
Add OnwerSplitState Nvarchar(255);

Update Nashville_Housing
Set OnwerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

---Check if data was updated successfully
Select *
From Learn.dbo.Nashville_Housing


--- Change Y/N to Yes/No in SoldAsVacant
Select Distinct (SoldAsVacant), Count(SoldAsVacant)
From Learn.dbo.Nashville_Housing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
, Case When SoldAsVacant = 'Y' Then 'Yes'
	   When SoldAsVacant = 'N' Then 'No'
	   Else SoldAsVacant
	   End
From Learn.dbo.Nashville_Housing

Update Nashville_Housing
Set SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes'
	   When SoldAsVacant = 'N' Then 'No'
	   Else SoldAsVacant
	   End

---Check if data was updated successfully
Select *
From Learn.dbo.Nashville_Housing

---Check if data was updated successfully
Select Distinct(SoldAsVacant)
From Learn.dbo.Nashville_Housing


---Remove Duplicates
With RowNumCTE As(
Select *,
	Row_Number() Over(
	Partition By ParcelId,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 Order By
					UniqueId) row_num

From Learn.dbo.Nashville_Housing
)

Select * ---here
From RowNumCTE  ---To execute this temp_table(CTE), select everything from 'With' to this point and execute. The result is all duplicates entries with row_num 1,2 etc
Where row_num > 1
Order by PropertyAddress ---only duplicate entries shown

Delete ---to delete all duplicates. to execute, mute 'here and the next four lines' and replace with delete
From RowNumCTE  
Where row_num > 1

---after delete, mute 'delete and its 3 lines' and unmute select to run the code

---Remove duplicate coloumns
Select *
From Learn.dbo.Nashville_Housing

Alter Table Learn.dbo.Nashville_Housing
Drop Column PropertyAddress, OwnerAddress, TaxDistrict, SaleDateConverted -- run only Alter and Drop together to delete coloum

Alter Table Learn.dbo.Nashville_Housing
Drop Column SaleDate



Select *
From Learn.dbo.Nashville_Housing ---to see final result




-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
---Extra practice
--- Importing Data using OPENROWSET and BULK INSERT	

--  More advanced and looks cooler, but have to configure server appropriately to do correctly
--  Wanted to provide this in case you wanted to try it


--sp_configure 'show advanced options', 1;
--RECONFIGURE;
--GO
--sp_configure 'Ad Hoc Distributed Queries', 1;
--RECONFIGURE;
--GO


--USE PortfolioProject 

--GO 

--EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1 

--GO 

--EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1 

--GO 


---- Using BULK INSERT

--USE PortfolioProject;
--GO
--BULK INSERT nashvilleHousing FROM 'C:\Temp\SQL Server Management Studio\Nashville Housing Data for Data CLearning Project.csv'
--   WITH (
--      FIELDTERMINATOR = ',',
--      ROWTERMINATOR = '\n'
--);
--GO


---- Using OPENROWSET
--USE PortfolioProject;
--GO
--SELECT * INTO nashvilleHousing
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
--    'Excel 12.0; Database=C:\Users\alexf\OneDrive\Documents\SQL Server Management Studio\Nashville Housing Data for Data CLearning Project.csv', [Sheet1$]);
--GO