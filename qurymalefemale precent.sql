
select cover.ClaimCause,cover.gender,cover.paidamount,100*cover.paidamount/sum(cover.paidamount) over() as prc
from
(
select ClaimCause,[dbo].[Member].gender as gender,sum(claimpaidamount) as paidamount
from[dbo].[MemberClaims]
join [dbo].[Member] on [dbo].[MemberClaims].MemberKey=[dbo].[Member].MemberKey
where claimstatus='paid'
group by ClaimCause,gender
) cover
order by cover.ClaimCause desc