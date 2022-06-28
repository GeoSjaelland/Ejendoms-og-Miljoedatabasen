SELECT        *
FROM            GS_BORGER2 AS Geoborger INNER JOIN
                         Befolkningsdistrikter AS Distrikt ON Geoborger.Geometri.STWithin(Distrikt.SP_GEOMETRY) = 1

                         /* Det lader til, at tabellen skal have et alias, hvis det skal virke*/