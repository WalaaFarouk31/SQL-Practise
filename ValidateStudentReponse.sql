
--create table student_list
--(
-- roll_number int,
-- student_name nvarchar(50),
-- class int,
-- section nvarchar(2),
-- school_name nvarchar(50)
--)


--create table student_response
--(
--roll_number int,
--question_paper_code int,
--question_number int,
--option_marked nvarchar(1)
--)

--create table correct_answers
--(
--question_paper_code int,
--question_number int,
--correct_option nvarchar(50)
--)


--create table question_paper_code
--(
--paper_code int,
--class int,
--subject nvarchar(10)
--)


---------------------======================== validate the student response======================================--------------------
with cte as
(
select student_response.roll_number,
sum(case when question_paper_code.subject='Math' and student_response.option_marked=correct_answers.correct_option then 1 else 0 end ) as Math_correct,
sum(case when  question_paper_code.subject='Math' and student_response.option_marked='e' then 1 else 0 end) as Math_yet_to_learn,
sum(case when question_paper_code.subject='Math' and student_response.option_marked<>correct_answers.correct_option then 1 else 0 end ) as Math_wrong,

sum(case when question_paper_code.subject='Science' and student_response.option_marked=correct_answers.correct_option then 1 else 0 end ) as Sciense_correct,
sum(case when  question_paper_code.subject='Science' and student_response.option_marked='e' then 1 else 0 end) as Sciense_yet_to_learn,
sum(case when question_paper_code.subject='Science' and student_response.option_marked<>correct_answers.correct_option then 1 else 0 end ) as Sciense_wrong
from  student_response
join correct_answers on student_response.question_paper_code=correct_answers.question_paper_code 
and student_response.question_number=correct_answers.question_number
join question_paper_code on question_paper_code.paper_code=student_response.question_paper_code
group by student_response.roll_number

)
select student_list.*, Math_correct,Math_wrong,Math_yet_to_learn, round((Math_correct*100.0/(Math_correct+Math_wrong+Math_yet_to_learn)),2) as Math_Precentage,
Sciense_correct,Sciense_wrong,Sciense_yet_to_learn, round((Sciense_correct*100.0/(Sciense_correct+Sciense_wrong+Sciense_yet_to_learn)),2) as Sciense_Precentage
from cte
join student_list on student_list.roll_number=cte.roll_number

