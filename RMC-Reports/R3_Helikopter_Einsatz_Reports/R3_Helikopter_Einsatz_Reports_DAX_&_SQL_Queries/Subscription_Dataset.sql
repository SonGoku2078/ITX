-- Main-Select: 
-- Der Text für "Subject" wird noch um all die Grund Infos aus dem Sub-Select rumgebaut (DatumsFelder)
--
Select 
	*
	,CONCAT('@ReportName : ', x.Jahr)
	+ '-'
	+ x.Monat
	+ ' für '
	+ x.Basis 
	+ ' ist verfügbar ("@ExecutionTime")' 			
						as 'Subject'	
From(

-- SubSelect: 
-- Grund Infos aufbereiten inkl. DatumsFelder, welche zur weiteren Verarbeitung noch benötigt werden in Main-Select für "Subject"
--
	SELECT 
		   a.Name			as Empfänger
		  ,a.Basis_Name		as Basis
		  ,b.Basistyp		as Basistyp
		  ,CASE
				WHEN Month(GETDATE()) = 1 /* Wenn Januar					*/
				THEN  Year(GETDATE()) - 1 /* dann nimm das Vorjahr			*/		
				ELSE  Year(GETDATE())	  /* ansonnsten das aktuelle Jahr	*/
		   END				as Jahr
		  ,FORMAT(DateAdd(month, -1,getdate()),'MMMM') as Monat
	  FROM 
		[MDS].[mdm].[Berichtsempfaenger_Monatsreport] a
	  Inner join 
		[MDS].[mdm].[Basis] b	on a.Basis_Name = b.Name
) as x