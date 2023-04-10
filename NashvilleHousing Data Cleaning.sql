
--Standardize Date Format

Select *
from NashvilleHousing	

select *
from NashvilleHousing

Select SaleDateConverted, CONVERT(date,SaleDate)
from NashvilleHousing	

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)


------------------------------------------------------------------------------
--Populate property Address Data

Select *
from NashvilleHousing
where PropertyAddress is null
order by ParcelID


SELECT a.parcelID, a.PropertyAddress, b.ParcelID, b.propertyaddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM nashvilleHousing a
JOIN nashvilleHousing b
	on a.parcelID = b.parcelID
	and a. uniqueID <> b.uniqueId



UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM nashvilleHousing a
JOIN nashvilleHousing b
	on a.parcelID = b.parcelID
	and a. uniqueID <> b.uniqueID
where a.PropertyAddress is null



--Breaking Out PropertyAddress into individual columns (Address, City, State)

select PropertyAddress
from NashvilleHousing

Select SUBSTRING(PropertyAddress, 1, CHARINDEX (',', PropertyAddress)-1) as Address
,SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) as City
from NashvilleHousing


ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX (',', PropertyAddress)-1)


ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress))



--Breaking Out OwnerAddress into individual columns (Address, City, State)

select *
from NashvilleHousing


select 
PARSENAME(REPLACE(OwnerAddress, ',','.'), 3) as Address
,PARSENAME(REPLACE(OwnerAddress,',','.'),2) as City
,PARSENAME(REPLACE(OwnerAddress, ',','.'), 1) as State
from NashvilleHousing


ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',','.'), 3)


ALTER TABLE NashvilleHousing
ADD OwnerSplitCity Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE NashvilleHousing
ADD OwnerSplitState Nvarchar(255);

update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)



--Change Y and N to Yes an No in "Sold as Vacant" column

Select Distinct(SoldAsVacant), COUNT(soldasvacant)
from NashvilleHousing
Group by SoldAsVacant
order by 2


SELECT SoldAsVacant,
	CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		 WHEN SoldAsVacant = 'N' THEN 'No'
		 ELSE SoldAsVacant
		 END 
from NashvilleHousing


UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
						WHEN SoldAsVacant = 'N' THEN 'No'
						ELSE SoldAsVacant
						END



--Removing Duplicates

WITH RowNumCTE AS(
select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
				 UniqueID
				 ) Row_num
from NashvilleHousing
)
DELETE
from RowNumCTE
Where Row_num >1



--Deleting Unused Columns

Select * 
from NashvilleHousing


ALTER TABLE NashvilleHousing
DROP COLUMN SaleDate, OwnerAddress, PropertyAddress, TaxDistrict
