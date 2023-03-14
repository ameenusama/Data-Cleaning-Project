select *
from DatacleaningPractice..NashvilleHousing



select SaleDateConverted, CONVERT (date,SaleDate)
from DatacleaningPractice..NashvilleHousing


alter table NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
Set SaleDateConverted = Convert (date,SaleDate)





select *
from DatacleaningPractice..NashvilleHousing
--where PropertyAddress is null
order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL (a.PropertyAddress, b.PropertyAddress)
From DatacleaningPractice..NashvilleHousing a
join DatacleaningPractice..NashvilleHousing b
 on a.ParcelID = b.ParcelID
 and a.[UniqueID ] <> b.[UniqueID ]
 

 update a
 SET PropertyAddress = ISNULL (a.PropertyAddress, b.PropertyAddress)
 From DatacleaningPractice..NashvilleHousing a
join DatacleaningPractice..NashvilleHousing b
 on a.ParcelID = b.ParcelID
 and a.[UniqueID ] <> b.[UniqueID ]










 select PropertyAddress
from DatacleaningPractice..NashvilleHousing
--where PropertyAddress is null
order by ParcelID



Select
substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address ,
substring(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, Len(PropertyAddress)) as City
from DatacleaningPractice..NashvilleHousing



--This form works as well to show us just the City


Select
substring(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 ,  CHARINDEX(',',PropertyAddress)) as City
from DatacleaningPractice..NashvilleHousing





alter table DatacleaningPractice..NashvilleHousing
Add JustAddress nvarchar(255);

Update DatacleaningPractice..NashvilleHousing
Set JustAddress = substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 



alter table DatacleaningPractice..NashvilleHousing
Add JustCity nvarchar(255);

Update DatacleaningPractice..NashvilleHousing
Set JustCity = substring(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, Len(PropertyAddress))



select *
from DatacleaningPractice..NashvilleHousing






select OwnerAddress
from DatacleaningPractice..NashvilleHousing


-- parsname only works on Periods so we are going to replace the commas in this column to periods to parse them.

Select
parsename(Replace(OwnerAddress, ',', '.') ,3) as OwnerAddressStreet  ,
parsename(Replace(OwnerAddress, ',', '.') ,2) as OwnerAddressCity ,
parsename(Replace(OwnerAddress, ',', '.') ,1) as OwnerAddressState

from DatacleaningPractice..NashvilleHousing







alter table DatacleaningPractice..NashvilleHousing
Add OwnerAddressStreet nvarchar(255);

Update DatacleaningPractice..NashvilleHousing
Set OwnerAddressStreet = parsename(Replace(OwnerAddress, ',', '.') ,3)



alter table DatacleaningPractice..NashvilleHousing
Add OwnerAddressCity nvarchar(255);

Update DatacleaningPractice..NashvilleHousing
Set OwnerAddressCity = parsename(Replace(OwnerAddress, ',', '.') ,2)


alter table DatacleaningPractice..NashvilleHousing
Add OwnerAddressState nvarchar(255);

Update DatacleaningPractice..NashvilleHousing
Set OwnerAddressState = parsename(Replace(OwnerAddress, ',', '.') ,1)



select * 
from DatacleaningPractice..NashvilleHousing



Select Distinct(SoldAsVacant), count(SoldAsVacant)
from DatacleaningPractice..NashvilleHousing
group by SoldAsVacant

-- changing the Y, N to Yes and No

Select SoldAsVacant,
CASE when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
Else SoldAsVacant
End

from DatacleaningPractice..NashvilleHousing



Update DatacleaningPractice..NashvilleHousing
Set SoldAsVacant = CASE when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
Else SoldAsVacant
End



--Removing duplicates


WITH RowNumCTE AS(
select *,
ROW_NUMBER () OVER (partition by ParcelID,
PropertyAddress, SalePrice, SaleDate, LegalReference
Order by  UniqueID 
) row_num

from DatacleaningPractice..NashvilleHousing
)

Delete
from RowNumCTE
where row_num > 1
--order by PropertyAddress




-- now to check if it all deleted



WITH RowNumCTE AS(
select *,
ROW_NUMBER () OVER (partition by ParcelID,
PropertyAddress, SalePrice, SaleDate, LegalReference
Order by  UniqueID 
) row_num

from DatacleaningPractice..NashvilleHousing
)


Select *
from RowNumCTE
where row_num > 1
order by PropertyAddress








Select *
from DatacleaningPractice..NashvilleHousing

alter table DatacleaningPractice..NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress

