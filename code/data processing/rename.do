clear all
set more off

cd "I:\Zitrax"
global dta1 "I:\Zitrax\current_assess_transaction"
global dta2 "I:\Zitrax\historic_assessment"
global dta "I:\Zitrax\dta"

*Current Assessment
*01 02 04 05 06 08 09 10 12 
*11 13 15 16 17 18 19 20 21 22 23 24 25 26 27 30 31 32 33 34 35 36 37 38 39 40 41 42 44
foreach n in  45 46 47 48 49 50 51 53 54 56 66{
capture import delimited "$dta1\\`n' (1)\ZAsmt\Main.txt", delimiter("|") clear
ren v1 RowID
ren v2 ImportParcelID
ren v3 FIPS
ren v4 State
ren v5 County
ren v6 ValueCertDate
ren v7 ExtractDate
ren v8 Edition
ren v9 ZVendorStndCode
ren v10 AssessorParcelNumber
ren v11 DupAPN
ren v12 UnformattedAssessorParcelNumber
ren v13 ParcelSequenceNumber
ren v14 AlternateParcelNumber
ren v15 OldParcelNumber
ren v16 ParcelNumberTypeStndCode
ren v17 RecordSourceStndCode
ren v18 RecordTypeStndCode
ren v19 ConfidentialRecordFlag
ren v20 PropertyAddressSourceStndCode
ren v21 PropertyHouseNumber	
ren v22 PropertyHouseNumberExt
ren v23 PropertyStreetPreDirectional
ren v24 PropertyStreetName
ren v25 PropertyStreetSuffix
ren v26 PropertyStreetPostDirectional
ren v27 PropertyFullStreetAddress
ren v28 PropertyCity
ren v29 PropertyState
ren v30 PropertyZip
ren v31 PropertyZip4
ren v32 OriginalPFStreetAddress
ren v33 OriginalPropertyAddressLastline
ren v34 PropertyBuildingNumber
ren v35 PropertyZoningDescription
ren v36 PropertyZoningSourceCode
ren v37 CensusTract
ren v38 TaxIDNumber
ren v39 TaxAmount
ren v40 TaxYear
ren v41 TaxDelinquencyFlag
ren v42 TaxDelinquencyAmount
ren v43 TaxDelinquencyYear
ren v44 TaxRateCodeArea
ren v45 LegalLot
ren v46 LegalLotStndCode
ren v47 LegalOtherLot
ren v48 LegalBlock
ren v49 LegalSubdivisionCode
ren v50 LegalSubdivisionName
ren v51 LegalCondoProjectPUDDevName	
ren v52 LegalBuildingNumber
ren v53 LegalUnit
ren v54 LegalSection
ren v55 LegalPhase
ren v56 LegalTract
ren v57 LegalDistrict
ren v58 LegalMunicipality
ren v59 LegalCity
ren v60 LegalTownship
ren v61 LegalSTRSection
ren v62 LegalSTRTownship
ren v63 LegalSTRRange
ren v64 LegalSTRMeridian
ren v65 LegalSecTwnRngMer
ren v66 LegalRecordersMapReference
ren v67 LegalDescription
ren v68 LegalNeighborhoodSourceCode
ren v69 NoOfBuildings
ren v70 LotSizeAcres
ren v71 LotSizeSquareFeet
ren v72 LotSizeFrontageFeet
ren v73 LotSizeDepthFeet
ren v74 LotSizeIRR
ren v75 LotSiteTopographyStndCode
ren v76 LoadID
ren v77 PropertyAddressMatchcode
ren v78 PropertyAddressUnitDesignator
ren v79 PropertyAddressUnitNumber
ren v80 PropertyAddressCarrierRoute
ren v81 PropertyAddressGeoCodeMatchCode
ren v82 PropertyAddressLatitude	
ren v83 PropertyAddressLongitude
ren v84 PropertyAddressCTractAndBlock
ren v85 PropertyAddressConfidenceScore
ren v86 PropertyAddressCBSACode
ren v87 PropertyAddressCBSADivisionCode
ren v88 PropertyAddressMatchType
ren v89 PropertyAddressDPV
ren v90 PropertyGeocodeQualityCode
ren v91 PropertyAddressQualityCode
ren v92 SubEdition
ren v93 BatchID
ren v94 BKFSPID
ren v95 SourceChkSum


save "$dta\current_assess_`n'.dta",replace
}
*06 12 
foreach n in 01 02 04 05 08 09 10 11 13 15 16 17 18 19 20 21 22 23 24 25 26 27 30 31 32 33 34 35 36 37 38 39 40 41 42 44 45 46 47 48 49 50 51 53 54 56 66{
capture import delimited "$dta1\\`n' (1)\ZAsmt\Value.txt", delimiter("|") clear
ren v1 RowID
ren v2 LandAssessedValue
ren v3 ImprovementAssessedValue
ren v4 TotalAssessedValue
ren v5 AssessmentYear
ren v6 LandMarketValue
ren v7 ImprovementMarketValue
ren v8 TotalMarketValue
ren v9 MarketValueYear
ren v10 LandAppraisalValue
ren v11 ImprovementAppraisalValue
ren v12 TotalAppraisalValue
ren v13 AppraisalValueYear
ren v14 FIPS
ren v15 BatchID


save "$dta\current_assess_value_`n'.dta",replace
}
set more off
*06  12 
foreach n in 01 02 04 05 08 09 10 11 13 15 16 17 18 19 20 21 22 23 24 25 26 27 30 31 32 33 34 35 36 37 38 39 40 41 42 44 45 46 47 48 49 50 51 53 54 56{
capture import delimited "$dta1\\`n' (1)\ZAsmt\SaleData.txt", delimiter("|") clear
ren v1 RowID
ren v2 SaleSeqNum
ren v3 SellerFullName
ren v4 BuyerFullName
ren v5 RecordingDate
ren v6 DocumentDate
ren v7 RecordingDocumentNumber
ren v8 RecordingBookNumber
ren v9 RecordingPageNumber
ren v10 DocumentTypeCountyDescription
ren v11 DocumentTypeStndCode
ren v12 SalesPriceAmount
ren v13 SalesPriceAmountStndCode
ren v14 FIPS
ren v15 BatchID


save "$dta\current_assess_sale_`n'.dta",replace
}

set more off
*06  12 01 02 04 05 08 09 10 11 13 15 16 17 18 19 20 21 22 23 24 25 26 27 30 31 32 33 34 35 36 37 38 39 40 41 42 44 45 46 47 48 49 50 51 53 54 56
foreach n in 09 {
capture import delimited "$dta1\\`n' (1)\ZAsmt\Building.txt", delimiter("|") clear

ren v1 RowID
ren v2 NoOfUnits
ren v3 OccupancyStatusStndCode
ren v4 PropertyCountyLandUseDescription
ren v5 PropertyCountyLandUseCode
ren v6 PropertyLandUseStndCode
ren v7 PropertyStateLandUseDescription
ren v8 PropertyStateLandUseCode
ren v9 BuildingOrImprovementNumber
ren v10 BuildingClassStndCode
ren v11 BuildingQualityStndCode
ren v12 BuildingQualityStndCodeOriginal
ren v13 BuildingConditionStndCode
ren v14 ArchitecturalStyleStndCode
ren v15 YearBuilt
ren v16 EffectiveYearBuilt
ren v17 YearRemodeled
ren v18 NoOfStories
ren v19 TotalRooms
ren v20 TotalBedrooms
ren v21 TotalKitchens
ren v22 FullBath
ren v23 ThreeQuarterBath
ren v24 HalfBath
ren v25 QuarterBath
ren v26 TotalCalculatedBathCount
ren v27 TotalActualBathCount
ren v28 BathSourceStndCode
ren v29 TotalBathPlumbingFixtures
ren v30 RoofCoverStndCode
ren v31 RoofStructureTypeStndCode
ren v32 HeatingTypeorSystemStndCode
ren v33 AirConditioningStndCode
ren v34 FoundationTypeStndCode
ren v35 ElevatorStndCode
ren v36 FireplaceFlag
ren v37 FirePlaceTypeStndCode
ren v38 FireplaceNumber
ren v39 WaterStndCode
ren v40 SewerStndCode
ren v41 MortgageLenderName
ren v42 TimeshareStndCode
ren v43 Comments
ren v44 LoadID
ren v45 StoryTypeStndCode
ren v46 FIPS
ren v47 BatchID


save "$dta\current_assess_building_`n'.dta",replace
}
set more off
*06  12 01 02 04 05 08 09 10 11 13 15 16 17 18 19 20 21 22 23 24 25 26 27 30 31 32 33 34 35 36 37 38 39 40 41 42 44 45 46 47 48 49 50 51 53 54 56
foreach n in 09 {
capture import delimited "$dta1\\`n' (1)\ZAsmt\BuildingAreas.txt", delimiter("|") clear

ren v1 RowID
ren v2 BuildingOrImprovementNumber
ren v3 BuildingAreaSequenceNumber
ren v4 BuildingAreaStndCode
ren v5 BuildingAreaSqFt
ren v6 FIPS
ren v7 BatchID
save "$dta\current_assess_buildingarea_`n'.dta",replace
}

set more off
foreach n in 09 {
capture import delimited "$dta1\\`n' (1)\ZAsmt\LotSiteAppeal.txt", delimiter("|") clear
ren v1 RowID
ren v2 LotSiteAppealStndCode
ren v3 FIPS
ren v4 BatchID
save "$dta\current_assess_lotappeal_`n'.dta",replace
}

set more off
foreach n in 09 {
capture import delimited "$dta1\\`n' (1)\ZAsmt\Pool.txt", delimiter("|") clear
ren v1 RowID
ren v2 BuildingOrImprovementNumber
ren v3 PoolStndCode
ren v4 PoolSize
ren v5 FIPS
ren v6 BatchID
save "$dta\current_assess_pool_`n'.dta",replace
}

set more off
foreach n in 09 {
capture import delimited "$dta1\\`n' (1)\ZAsmt\Garage.txt", delimiter("|") clear

ren v1 RowID
ren v2 BuildingOrImprovementNumber
ren v3 GarageSequenceNumber
ren v4 GarageStndCode
ren v5 GarageAreaSqFt
ren v6 GarageNoOfCars
ren v7 FIPS
ren v8 BatchID
save "$dta\current_assess_garage_`n'.dta",replace
}

set more off
foreach n in 09 {
capture import delimited "$dta1\\`n' (1)\ZAsmt\Value.txt", delimiter("|") clear
keep v1 v2 v3 v4 v5 v6

ren v1 RowID
ren v2 LandAssessedValue
ren v3 ImprovementAssessedValue
ren v4 TotalAssessedValue
ren v5 AssessmentYear
ren v6 LandMarketValue

save "$dta\current_assess_value_`n'.dta",replace
}

set more off
*Transaction
*06 12 01 02 04 05  08 09 10 11 13 15 16 17 18 19 20 21 22 23 24 25 
foreach n in 26 27 30 31 32 33 34 35 36 37 38 39 40 41 42 44 45 46 47 48 49 50 51 53 54 56{
capture import delimited "$dta1\\`n' (1)\ZTrans\Main.txt", delimiter("|") clear

ren v1 TransId
ren v2 FIPS
ren v3 State
ren v4 County
ren v5 DataClassStndCode
ren v6 RecordTypeStndCode
ren v7 RecordingDate
ren v8 RecordingDocumentNumber
ren v9 RecordingBookNumber
ren v10 RecordingPageNumber
ren v11 ReRecordedCorrectionStndCode
ren v12 PriorRecordingDate
ren v13 PriorDocumentDate
ren v14 PriorDocumentNumber
ren v15 PriorBookNumber
ren v16 PriorPageNumber
ren v17 DocumentTypeStndCode
ren v18 DocumentDate
ren v19 SignatureDate
ren v20 EffectiveDate
ren v21 BuyerVestingStndCode
ren v22 BuyerMultiVestingFlag
ren v23 PartialInterestTransferStndCode
ren v24 PartialInterestTransferPercent
ren v25 SalesPriceAmount
ren v26 SalesPriceAmountStndCode
ren v27 CityTransferTax
ren v28 CountyTransferTax
ren v29 StateTransferTax
ren v30 TotalTransferTax
ren v31 IntraFamilyTransferFlag
ren v32 TransferTaxExemptFlag
ren v33 PropertyUseStndCode
ren v34 AssessmentLandUseStndCode
ren v35 OccupancyStatusStndCode
ren v36 LegalStndCode
ren v37 BorrowerVestingStndCode
ren v38 LenderName
ren v39 LenderTypeStndCode
ren v40 LenderIDStndCode
ren v41 LenderDBAName
ren v42 DBALenderTypeStndCode
ren v43 DBALenderIDStndCode
ren v44 LenderMailCareOfName
ren v45 LenderMailHouseNumber
ren v46 LenderMailHouseNumberExt
ren v47 LenderMailStreetPreDirectional
ren v48 LenderMailStreetName
ren v49 LenderMailStreetSuffix
ren v50 LenderMailStreetPostDirectional
ren v51 LenderMailFullStreetAddress
ren v52 LenderMailBuildingName
ren v53 LenderMailBuildingNumber
ren v54 LenderMailUnitDesignator
ren v55 LenderMailUnit
ren v56 LenderMailCity
ren v57 LenderMailState
ren v58 LenderMailZip
ren v59 LenderMailZip4
ren v60 LoanAmount
ren v61 LoanAmountStndCode
ren v62 MaximumLoanAmount
ren v63 LoanTypeStndCode
ren v64 LoanTypeClosedOpenEndStndCode
ren v65 LoanTypeFutureAdvanceFlag
ren v66 LoanTypeProgramStndCode
ren v67 LoanRateTypeStndCode
ren v68 LoanDueDate
ren v69 LoanTermMonths
ren v70 LoanTermYears
ren v71 InitialInterestRate
ren v72 ARMFirstAdjustmentDate
ren v73 ARMFirstAdjustmentMaxRate
ren v74 ARMFirstAdjustmentMinRate
ren v75 ARMIndexStndCode
ren v76 ARMAdjustmentFrequencyStndCode
ren v77 ARMMargin
ren v78 ARMInitialCap
ren v79 ARMPeriodicCap
ren v80 ARMLifetimeCap
ren v81 ARMMaxInterestRate
ren v82 ARMMinInterestRate
ren v83 InterestOnlyFlag
ren v84 InterestOnlyTerm
ren v85 PrepaymentPenaltyFlag
ren v86 PrepaymentPenaltyTerm
ren v87 BiWeeklyPaymentFlag
ren v88 AssumabilityRiderFlag
ren v89 BalloonRiderFlag
ren v90 CondominiumRiderFlag
ren v91 PlannedUnitDevelopmentRiderFlag
ren v92 SecondHomeRiderFlag
ren v93 OneToFourFamilyRiderFlag
ren v94 ConcurrentMtgeDocOrBkPg
ren v95 LoanNumber
ren v96 MERSMINNumber
ren v97 CaseNumber
ren v98 MERSFlag
ren v99 TitleCompanyName
ren v100 TitleCompanyIDStndCode
ren v101 AccommodationRecordingFlag
ren v102 UnpaidBalance
ren v103 InstallmentAmount
ren v104 InstallmentDueDate
ren v105 TotalDelinquentAmount
ren v106 DelinquentAsOfDate
ren v107 CurrentLender
ren v108 CurrentLenderTypeStndCode
ren v109 CurrentLenderIDStndCode
ren v110 TrusteeSaleNumber
ren v111 AttorneyFileNumber
ren v112 AuctionDate
ren v113 AuctionTime
ren v114 AuctionFullStreetAddress
ren v115 AuctionCityName
ren v116 StartingBid
ren v117 KeyedDate
ren v118 KeyerID
ren v119 SubVendorStndCode
ren v120 ImageFileName
ren v121 BuilderFlag
ren v122 MatchStndCode
ren v123 REOStndCode
ren v124 UpdateOwnershipFlag
ren v125 LoadID
ren v126 StatusInd
ren v127 TransactionTypeStndCode
ren v128 BatchID
ren v129 BKFSPID
ren v130 ZVendorStndCode
ren v131 SourceChkSum


save "$dta\transaction_`n'.dta",replace
}
*06 12 01 02 04 05  08 09 10 11 13 15 16 17 18 19 20 21 22 23 24 25 26 27 30 31 32 33 34 35 36 37 38 39 40 41 42 44 45 46 47 48
foreach n in 49 50 51 53 54 56{
capture import delimited "$dta1\\`n' (1)\ZTrans\PropertyInfo.txt", delimiter("|") clear

ren v1 TransId
ren v2 AssessorParcelNumber
ren v3 APNIndicatorStndCode
ren v4 TaxIDNumber
ren v5 TaxIDIndicatorStndCode
ren v6 UnformattedAssessorParcelNumber
ren v7 AlternateParcelNumber
ren v8 HawaiiCondoCPRCode
ren v9 PropertyHouseNumber
ren v10 PropertyHouseNumberExt
ren v11 PropertyStreetPreDirectional
ren v12 PropertyStreetName
ren v13 PropertyStreetSuffix
ren v14 PropertyStreetPostDirectional
ren v15 PropertyBuildingNumber
ren v16 PropertyFullStreetAddress
ren v17 PropertyCity
ren v18 PropertyState
ren v19 PropertyZip
ren v20 PropertyZip4
ren v21 OriginalPFStreetAddress
ren v22 OriginalPropertyAddressLastline
ren v23 PropertyAddressStndCode
ren v24 LegalLot
ren v25 LegalOtherLot
ren v26 LegalLotCode
ren v27 LegalBlock
ren v28 LegalSubdivisionName
ren v29 LegalCondoProjectPUDDevName
ren v30 LegalBuildingNumber
ren v31 LegalUnit
ren v32 LegalSection
ren v33 LegalPhase
ren v34 LegalTract
ren v35 LegalDistrict
ren v36 LegalMunicipality
ren v37 LegalCity
ren v38 LegalTownship
ren v39 LegalSTRSection	
ren v40 LegalSTRTownship
ren v41 LegalSTRRange
ren v42 LegalSTRMeridian
ren v43 LegalSecTwnRngMer
ren v44 LegalRecordersMapReference
ren v45 LegalDescription
ren v46 LegalLotSize
ren v47 PropertySequenceNumber
ren v48 PropertyAddressMatchcode
ren v49 PropertyAddressUnitDesignator
ren v50 PropertyAddressUnitNumber
ren v51 PropertyAddressCarrierRoute
ren v52 PropertyAddressGeoCodeMatchCode
ren v53 PropertyAddressLatitude
ren v54 PropertyAddressLongitude
ren v55 PropertyAddressCTractAndBlock
ren v56 PropertyAddressConfidenceScore
ren v57 PropertyAddressCBSACode
ren v58 PropertyAddressCBSADivisionCode
ren v59 PropertyAddressMatchType
ren v60 PropertyAddressDPV
ren v61 PropertyGeocodeQualityCode
ren v62 PropertyAddressQualityCode
ren v63 FIPS
ren v64 LoadID
ren v65 ImportParcelID
ren v66 BKFSPID
ren v67 AssessmentRecordMatchFlag
ren v68 BatchID


save "$dta\transaction_property_`n'.dta",replace
}
