/*this quarry counts the number of custmers  of the insurance compeny by the enterprise the custmers are hired at */
select [dbo].[Member].EnterpriseKey,EnterpriseName,count([dbo].[Member].EnterpriseKey) as [count] 
from[dbo].[Member]
join [dbo].[Enterprise] on [dbo].[Member].EnterpriseKey=[dbo].[Enterprise].EnterpriseKey
group by [dbo].[Member].EnterpriseKey,EnterpriseName
order by [count] desc

/*this quarry Groups the custmers of the insurance compeny by their employee status and shows claimed paid amount to each group in which the
claim type is DEATH.
and the percentage
of the paid claim amount from the totel paid claims from the DEATH claims*/
select mytable.employee_status,mytable.paidbywork,100*mytable.paidbywork/sum(mytable.paidbywork) over() as [percentage]

from
(
SELECT employee_status,sum(claimpaidamount) as paidbywork
FROM[dbo].[Member]
join [dbo].[MemberClaims] on [dbo].[Member].MemberKey=[dbo].[MemberClaims].MemberKey
where ClaimType='DTH' AND claimstatus='paid'
group by employee_status
) as mytable
group by mytable.employee_status,mytable.paidbywork