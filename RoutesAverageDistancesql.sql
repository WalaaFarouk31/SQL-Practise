---creating table

CREATE TABLE [dbo].[Cities](
	[Source] [nvarchar](max) NULL,
	[Destination] [nvarchar](max) NULL,
	[Distance] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

INSERT [dbo].[Cities] ([Source], [Destination], [Distance]) VALUES (N'A', N'B', 21)
INSERT [dbo].[Cities] ([Source], [Destination], [Distance]) VALUES (N'B', N'A', 28)
INSERT [dbo].[Cities] ([Source], [Destination], [Distance]) VALUES (N'A', N'B', 19)
INSERT [dbo].[Cities] ([Source], [Destination], [Distance]) VALUES (N'C', N'D', 15)
INSERT [dbo].[Cities] ([Source], [Destination], [Distance]) VALUES (N'C', N'D', 17)
INSERT [dbo].[Cities] ([Source], [Destination], [Distance]) VALUES (N'D', N'C', 16)
INSERT [dbo].[Cities] ([Source], [Destination], [Distance]) VALUES (N'D', N'C', 18)

---------get the average distance of all routes, noting that a,b and b,a  are considered same thing 


---- The idea is to eliminate duplicate routes first
WITH  T1 AS
(
SELECT 
SOURCE,Destination,SUM(DISTANCE) TotalDistance,COUNT(1) NumberOfRouts
FROM Cities
GROUP BY SOURCE,Destination
),
NumberedRouts as
(
SELECT *,ROW_NUMBER()OVER(ORDER BY SOURCE) ID
FROM T1
)
SELECT r1.Source,r1.Destination,
(r1.TotalDistance+r2.TotalDistance)/(r1.NumberOfRouts+r2.NumberOfRouts) as averageDistance
FROM NumberedRouts r1
join NumberedRouts r2
on r1.Source=r2.Destination and r1.Destination=r2.Source and
r1.ID<r2.id;