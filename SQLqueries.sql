

--Queries:
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
(now()-'1week'::  interval) and now();

6.

7. Select count (agent_transactions.atx_id) as "atx volume city summary",
    agents.city, agents.country from transactions.agent transactions
    left join transactions.agents on agent_transactions.agent_id = agents.agent_id
    where
    agent_transactions.when_created > = NOW() - INTERVAL '1 week'
    group by agents.city, agents.country;


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


10. SELECT source_wallet_id,
(Select send_amount_scalar from transactions.transfers where send_amount_scalar = 1000000)
From transactions.transfers
WHERE (send_amount_currency = 'CFA' AND transfers.when_created =NOW() - INTERVAL '1 month';





