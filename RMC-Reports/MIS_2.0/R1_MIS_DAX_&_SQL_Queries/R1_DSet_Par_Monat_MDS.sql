
SELECT CAST(LEFT(Name, 4) AS INT) AS Jahr,
       CAST(RIGHT(Name, 2) AS INT) AS MonatNo,
       CASE
           WHEN CAST(RIGHT(mdm.Freigabe_Finanzdaten.Name, 2) AS INT) = 1 THEN 'Januar'
           WHEN CAST(RIGHT(mdm.Freigabe_Finanzdaten.Name, 2) AS INT) = 2 THEN 'Februar'
           WHEN CAST(RIGHT(mdm.Freigabe_Finanzdaten.Name, 2) AS INT) = 3 THEN 'März'
           WHEN CAST(RIGHT(mdm.Freigabe_Finanzdaten.Name, 2) AS INT) = 4 THEN 'April'
           WHEN CAST(RIGHT(mdm.Freigabe_Finanzdaten.Name, 2) AS INT) = 5 THEN 'Mai'
           WHEN CAST(RIGHT(mdm.Freigabe_Finanzdaten.Name, 2) AS INT) = 6 THEN 'Juni'
           WHEN CAST(RIGHT(mdm.Freigabe_Finanzdaten.Name, 2) AS INT) = 7 THEN 'Juli'
           WHEN CAST(RIGHT(mdm.Freigabe_Finanzdaten.Name, 2) AS INT) = 8 THEN 'August'
           WHEN CAST(RIGHT(mdm.Freigabe_Finanzdaten.Name, 2) AS INT) = 9 THEN 'September'
           WHEN CAST(RIGHT(mdm.Freigabe_Finanzdaten.Name, 2) AS INT) = 10 THEN 'Oktober'
           WHEN CAST(RIGHT(mdm.Freigabe_Finanzdaten.Name, 2) AS INT) = 11 THEN 'November'
           WHEN CAST(RIGHT(mdm.Freigabe_Finanzdaten.Name, 2) AS INT) = 12 THEN 'Dezember'
           ELSE Concat('Unbekannte Monatsnummer =>', ' "', CAST(RIGHT(mdm.Freigabe_Finanzdaten.Name, 2) AS INT), '"')
       END AS MonatTxtLong
FROM mdm.Freigabe_Finanzdaten
WHERE (Freigegeben_Name = N'Ja')
--  AND (CAST(LEFT(Name, 4) AS int) = @DS_Par_Jahr)
  AND (CAST(LEFT(Name, 4) AS int) = 2018)
ORDER BY MonatNo DESC