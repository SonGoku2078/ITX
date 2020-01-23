use DWH;

SELECT distinct
CAST(LEFT (rmc.FACT_OFFENE_POSTEN_HIST.DueDate,4) as INT) as Jahr
FROM
rmc.FACT_OFFENE_POSTEN_HIST
WHERE
rmc.FACT_OFFENE_POSTEN_HIST.IstFreigegeben = 'Ja'
Order by Jahr Desc
        




--use MDS;

--SELECT distinct
--CAST(LEFT (mdm.Freigabe_Finanzdaten.Name,4) as INT) as Jahr
--FROM
--mdm.Freigabe_Finanzdaten
--WHERE
--mdm.Freigabe_Finanzdaten.Freigegeben_Name = N'Ja'
--Order by Jahr Desc
        