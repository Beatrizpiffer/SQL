SELECT 
     Email,			
     OrderID,			
     Abertura,			
     Clique,			
     Recebidos
FROM 
  TB_Segmentacoes_Capacitacao_Guilherme_Ribeiro
WHERE 
  Clique >= DATEADD(DAY, -7, GETDATE());
