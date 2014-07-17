SELECT    *
FROM      GS_BBREnhed
WHERE     (UDVadresseID NOT IN
          (SELECT UDVadresseID
           FROM GS_BORGER)) 
          AND (NOT (Boligtype IS NULL)) 
ORDER BY  Adresse, Boligtypekode