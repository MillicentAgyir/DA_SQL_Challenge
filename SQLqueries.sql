Wave's Schema:
Assumption: Let's call the schema "transactions"
The transaction schema was used to organize the following tables:
1.Users 
2.Transfers
3.Agents
4.AgentsTransactions
5.Wallets


Queries:
1. SELECT COUNT(u_id)
FROM transactions.users;

2. SELECT COUNT(send_amount_currency)
FROM transactions.transfers 
WHERE send_amount_currency = 'CFA' ;

3.SELECT COUNT (u_id)
FROM transactions.transfers 
WHERE send_amount_currency = 'CFA' ;

4. SELECT COUNT (*) atx_id, DATE_PART('month',when_created) months_in_year_2018 
FROM transactions.agent_transactions
WHERE when_created BETWEEN '2018-01-01' AND '2018-12-31'
GROUP BY 2
ORDER BY 2 ASC;



5.Select sum(case when amount>0 Then amount else 0 END) as withdrawal,
 sum (case when amount<0 then amount else 0 END ) as deposit,
case when ((sum(case when amoount > o THEN amount else 0 END)) >((sum(case when amount<0 then amount else 0 END)))*-1)
then 'withdrawer else 'depositer' END as agent_status, count(*) 
from agent_transactions WHERE when_created between
(now()-'1week'::  interval) and now()


8. Select transfers.kind As transfer_kind,
wallets.ledger_location As country,
Sum(transfers.send_amount_scalar) As volume
From transactions.transfers 
Inner Join transactions.wallets ON transfers.source_wallet_id=wallets.wallet_id
Where (transfers.when_created>(Now()-interval '1 week'))
Group by transactions.wallets.ledger_location,
transfers.kind;


9. Select count(transfers.source_wallet_id) As unique_senders,
   Count (transfer_id) As transaction_count,
  transfers.kind As transfer_kind,
wallets.ledger_location As country,
Sum(transfers.send_amount_scalar) As volume
From transactions.transfers 
Inner Join transactions.wallets ON transfers.source_wallet_id=wallets.wallet_id
Where (transfers.when_created>(Now()-interval '1 week'))
Group by wallets.ledger_location,
transfers.kind;


10. SELECT (source_wallet_id),
(Select (Sum (send_amount_scalar)) as amount_transferred from transactions.transfers )
From transactions.transfers
WHERE (send_amount_currency = 'CFA' AND transfers.when_created > CURRENT_DATE - INTERVAL '1 month')
Group by source_wallet_id;





