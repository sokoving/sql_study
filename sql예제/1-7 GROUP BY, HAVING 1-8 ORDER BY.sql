-- Áý°èÇÔ¼ö(´ÙÁßÇà ÇÔ¼ö)
-- ¿©·¯ ÇàÀ» ¹­¾î¼­ ÇÔ¼ö¸¦ Àû¿ë

SELECT * FROM tb_sal_his;

-- GRUOUP BY·Î ¼Ò±×·ìÈ­ÇÏÁö ¾ÊÀ¸¸é Áý°è ÇÔ¼ö´Â ÀüÃ¼ÇÔ¼ö¸¦ ±âÁØÀ¸·Î Áý°èÇÑ´Ù
SELECT
    COUNT(pay_amt) "ÃÑ »ç¿ø ¼ö"
    , SUM(pay_amt) "Áö±Ý ÃÑ¾×"
    , AVG(pay_amt) "Æò±Õ Áö±Þ¾×"
FROM tb_sal_his
-- ´ÜÀÏÇà ÇÔ¼ö > tb_sal_hisÀÇ Çà ¼ö(984Çà)¸¸Å­ Ãâ·ÂµÈ´Ù
-- Áý°è ÇÔ¼ö > tb_sal_hisÀÇ ¸ðµç ÇàÀ» ¿¬»êÇØ 1ÇàÀ¸·Î Ãâ·ÂµÈ´Ù
;

-- COUNT(*) : nullÀ» Æ÷ÇÔÇÑ ÀüÃ¼ Çà ¼ö(nullÀ» Æ÷ÇÔÇÏ´Â À¯ÀÏÇÑ Áý°èÇÔ¼ö)
-- COUNT(Ç¥Çö½Ä) : nullÀ» Á¦¿ÜÇÑ Çà ¼ö(¸ðµç Áý°èÇÔ¼ö´Â nullÀ» Á¦¿ÜÇÏ°í °è»êÇÑ´Ù)
SELECT
    COUNT(*) AS "ÃÑ »ç¿ø ¼ö"
    , COUNT(direct_manager_emp_no) "dmen"
    , MIN(birth_de) "ÃÖ¿¬ÀåÀÚ »ýÀÏ"
    , MAX(birth_de) "ÃÖ¿¬¼ÒÀÚ »ýÀÏ"
FROM tb_emp;

SELECT * FROM tb_emp
ORDER BY dept_cd;

-- GROUP BY : ÁöÁ¤µÈ Ä®·³À» ¼Ò±×·ìÈ­ ÇÑ ÈÄ Áý°èÇÔ¼ö Àû¿ë
-- GROUP BY·Î ÁöÁ¤ÇÑ ÄÃ·³°ú Áý°èÇÔ¼ö¸¸ SELECT¿¡¼­ ¾µ ¼ö ÀÖ´Ù (ÁöÁ¤ ÄÃ·³ ¾Æ´Ï¸é Á¶È¸ X)
-- nullÀÎ Çàµµ ±×·ìÈ­ÇÑ´Ù
-- GROUP BY´Â SELECTº¸´Ù ¸ÕÀú ÀÛµ¿ÇÏ±â ¶§¹®¿¡ ¿­ º°ÄªÀ» ¾µ ¼ö ¾ø´Ù

-- ºÎ¼­º°·Î °¡Àå ¾î¸° »ç¶÷ÀÇ »ý³â¿ùÀÏ, ¿¬ÀåÀÚÀÇ »ý³â¿ùÀÌ ºÎ¼­º° ÃÑ »ç¿ø ¼ö¸¦ Á¶È¸
SELECT
--  emp_nm      -- ÀÌ¸§Àº º¼ ¼ö ¾øÀ½
    dept_cd     -- ±×·ìÈ­ÇÑ dept_cd´Â º¼ ¼ö ÀÖÀ½
    , MAX(birth_de) ÃÖ¿¬¼ÒÀÚ
    , MIN(birth_de) ÃÖ¿¬ÀåÀÚ
    , COUNT(emp_no) Á÷¿ø¼ö
FROM tb_emp
GROUP BY dept_cd -- ºÎ¼­ ÄÚµå°¡ °°Àº Çà³¢¸® ¹­¾î¼­ Åë°è ³»±â
ORDER BY dept_cd
;

-- »ç¿øº° ´©Àû ±Þ¿© ¼ö·É¾× Á¶È¸
SELECT 
    emp_no »ç¹ø
    , SUM(pay_amt) ´©Àû¼ö·É¾×
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no
;

-- Áý°èÇÔ¼ö´Â ´ÜÀÏÇà ÇÔ¼öÀÇ ÀÎ¼ö°¡ µÉ ¼ö ÀÖ´Ù
-- Áý°èÇÔ¼ö¸¦ ´Ù½Ã Áý°èÇÔ¼ö·Î ¹­À¸¸é ¾È µÊ(º°µµ Ã³¸®°¡ ÇÊ¿ä)
-- WHERE
-- Á¦ÇÑÇÒ ÇàÀÌ ÀÖ´Ù¸é GROUP BY Àü¿¡ ÇØ¾ß ÇÑ´Ù
-- WHERE¿¡´Â Áý°èÇÔ¼ö »ç¿ë ¸ø ÇÔ
-- FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY

-- 2019³â¿¡ »ç¿øº°·Î 
-- ±Þ¿©¸¦ Á¦ÀÏ ¸¹ÀÌ ¹Þ¾ÒÀ» ¶§, Á¦ÀÏ Àû°Ô ¹Þ¾ÒÀ» ¶§,
-- Æò±ÕÀûÀ¸·Î ¾ó¸¶ ¹Þ¾Ò´ÂÁö, ¿¬ºÀÀÌ ¾ó¸¶ÀÎÁö Á¶È¸
SELECT 
    emp_no »ç¹ø
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') ÃÖ°í¼ö·É¾×
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') ÃÖÀú¼ö·É¾×
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') Æò±Õ¼ö·É¾×
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') ¿¬ºÀ
--  , ROUND(pay_amt, 2)  -- ´ÜÀÏÇà ÇÔ¼ö´Â ¾µ ¼ö ¾ø´Ù
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
ORDER BY emp_no
;


-- HAVING
-- ±×·ìÈ­µÈ °á°ú¿¡¼­ Á¶°ÇÀ» °É¾î Çà ¼ö¸¦ Á¦ÇÑ
-- WHERE µÚ, ORDER BY ¾Õ (GROUP BY ¾Õ, µÚ °¡´É)

-- ºÎ¼­º°·Î °¡Àå ¾î¸° »ç¶÷ÀÇ »ý³â¿ùÀÏ, ¿¬ÀåÀÚÀÇ »ý³â¿ùÀÌ ºÎ¼­º° ÃÑ »ç¿ø ¼ö¸¦ Á¶È¸
-- »ç¿øÀÌ 1¸íÀÎ ºÎ¼­ÀÇ Á¤º¸´Â Á¶È¸ÇÏ°í ½ÍÁö ¾ÊÀ» ¶§
SELECT
    dept_cd
    , MAX(birth_de) ÃÖ¿¬¼ÒÀÚ
    , MIN(birth_de) ÃÖ¿¬ÀåÀÚ
    , COUNT(emp_no) Á÷¿ø¼ö
FROM tb_emp
GROUP BY dept_cd 
HAVING NOT COUNT (emp_no) = 1
ORDER BY dept_cd
;

-- »ç¿øº°·Î ±Þ¿©¸¦ Á¦ÀÏ ¸¹ÀÌ ¹Þ¾ÒÀ» ¶§, Á¦ÀÏ Àû°Ô ¹Þ¾ÒÀ» ¶§, Æò±ÕÀûÀ¸·Î ¾ó¸¶ ¹Þ¾Ò´ÂÁö Á¶È¸
-- Æò±Õ ±Þ¿©°¡ 450¸¸ ¿ø ÀÌ»óÀÇ »ç¶÷¸¸ Á¶È¸
SELECT 
    emp_no »ç¹ø
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') ÃÖ°í¼ö·É¾×
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') ÃÖÀú¼ö·É¾×
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') Æò±Õ¼ö·É¾×
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') ¿¬ºÀ
--  , ROUND(pay_amt, 2)  -- ´ÜÀÏÇà ÇÔ¼ö´Â ¾µ ¼ö ¾ø´Ù
FROM tb_sal_his
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;

-- »ç¿øº°·Î 2019³â ¿ù Æò±Õ ¼ö·É¾×ÀÌ 450¸¸ ¿ø ÀÌ»óÀÎ »ç¶÷ÀÇ
-- »ç¿ø ¹øÈ£¿Í 2019³â ¿¬ºÀ Á¶È¸
SELECT
    emp_no
    , TO_CHAR(ROUND(AVG(pay_amt)), 'L999,999,999') Æò±Õ¼ö·É¾×
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') ¿¬ºÀ
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;


SELECT
    emp_no
    , sex_cd
    , dept_cd
FROM tb_emp
ORDER BY dept_cd
;

-- GROUP BY¿¡ ÄÃ·³À» º¹¼ö·Î ÁÖ¸é ÄÃ·³ÀÌ ¸ðµÎ ÀÏÄ¡ÇÏ´Â Çà³¢¸® ±×·ìÇÑ´Ù
SELECT 
    dept_cd
    , COUNT(*)
FROM tb_emp
GROUP BY dept_cd, sex_cd
ORDER BY dept_cd
;

-- ORDER BY : Á¤·Ä
-- ASC : ¿À¸§Â÷ Á¤·Ä(±âº»°ª) , DESC : ³»¸²Â÷ Á¤·Ä
-- Ç×»ó SELECT ÀýÀÇ ¸Ç ¸¶Áö¸·¿¡ À§Ä¡
-- ±×·ìÈ­ÇÑ ÄÃ·³°ú Áý°èÇÔ¼ö¸¸ Á¤·ÄÇÒ ¼ö ÀÖ´Ù

-- GROUP BY¿¡ ÄÃ·³À» º¹¼ö·Î ÁÖ¸é ÄÃ·³ÀÌ ¸ðµÎ ÀÏÄ¡ÇÏ´Â Çà³¢¸® ±×·ìÇÑ´Ù
SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
--ORDER BY emp_no ASC -- ASC ±âº»°ª, »ý·« °¡´É
ORDER BY emp_no DESC  -- DESC Ç¥±â ÇÊ¼ö
;

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_nm ASC -- ÀÌ¸§À¸·Î Á¤·Ä
--ORDER BY emp_nm DESC  -- À¯´ÏÄÚµå ¼ø¼­ A-Z, °¡-ÆR
;

-- Â÷¼øÀ§ Á¤·ÄÀº ½°Ç¥·Î ±¸ºÐÇØ ¾´´Ù
SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY dept_cd ASC, emp_nm DESC -- dept_cd°¡ °°À¸¸é emp_nm·Î ³»¸²Â÷ Á¤·Ä
;

-- º°ÄªÀ¸·Îµµ Á¤·Ä °¡´É
SELECT 
    emp_no »ç¹ø
    , emp_nm ÀÌ¸§
    , addr ÁÖ¼Ò
FROM tb_emp
ORDER BY ÀÌ¸§ ASC
;

-- ÄÃ·³ ¼ø¼­·Îµµ Á¤·Ä °¡´É
SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY 3 ASC, 2 DESC 
;

-- ¼¯¾î¼­ ½áµµ µÊ
SELECT 
    emp_no »ç¹ø
    , emp_nm ÀÌ¸§
    , dept_cd ÁÖ¼Ò
FROM tb_emp
ORDER BY 1 ASC, emp_nm DESC, ÁÖ¼Ò ASC
;


-- »ç¿øº°·Î 2019³â ¿ù Æò±Õ ¼ö·É¾×ÀÌ 450¸¸ ¿ø ÀÌ»óÀÎ »ç¶÷ÀÇ
-- »ç¿ø ¹øÈ£¿Í 2019³â ¿¬ºÀ Á¶È¸
SELECT
    emp_no
    , TO_CHAR(ROUND(AVG(pay_amt)), 'L999,999,999') Æò±Õ¼ö·É¾×
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') ¿¬ºÀ
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
--ORDER BY SUM(pay_amt) DESC
ORDER BY Æò±Õ¼ö·É¾×
--ORDER BY 3 DESC
;
