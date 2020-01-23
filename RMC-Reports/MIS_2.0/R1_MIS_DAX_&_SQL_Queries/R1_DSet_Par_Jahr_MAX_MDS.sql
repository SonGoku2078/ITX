SELECT CAST(LEFT(MAX(Name), 4) AS INT) AS Jahr,
       CASE
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 1 THEN 'Januar'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 2 THEN 'Februar'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 3 THEN 'März'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 4 THEN 'April'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 5 THEN 'Mai'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 6 THEN 'Juni'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 7 THEN 'Juli'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 8 THEN 'August'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 9 THEN 'September'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 10 THEN 'Oktober'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 11 THEN 'November'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 12 THEN 'Dezember'
           ELSE Concat('Unbekannte Monatsnummer =>', ' "', CAST(RIGHT(MAX(Name), 2) AS INT), '"')
       END AS Monat,
       CASE
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 1 THEN '1'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 2 THEN '2'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 3 THEN '3'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 4 THEN '4'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 5 THEN '5'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 6 THEN '6'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 7 THEN '7'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 8 THEN '8'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 9 THEN '9'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 10 THEN '10'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 11 THEN '11'
           WHEN CAST(RIGHT(MAX(Name), 2) AS INT) = 12 THEN '12'
           ELSE Concat('Unbekannte Monatsnummer =>', ' "', CAST(RIGHT(MAX(Name), 2) AS INT), '"')
       END AS MonatsNummer
FROM mdm.Freigabe_Finanzdaten
WHERE (Freigegeben_Name = N'Ja')