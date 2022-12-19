/*this quarry orders insurance claims by cause and showes the sum of the  paid amount to each claim cause as well as the percentage of 
of the paid amount from the overall paid amount partitioned by gander*/
select cover.ClaimCause,cover.gender,cover.paidamount,100*cover.paidamount/sum(cover.paidamount) over() as [percentage]
from
(
select ClaimCause,[dbo].[Member].gender as gender,sum(claimpaidamount) as paidamount
from[dbo].[MemberClaims]
join [dbo].[Member] on [dbo].[MemberClaims].MemberKey=[dbo].[Member].MemberKey
where claimstatus='paid'
group by ClaimCause,gender
) cover
order by cover.ClaimCause desc