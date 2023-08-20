SELECT *
FROM member a, cart b, prod c
WHERE a.mem_id = b.cart_member(+)
AND b.cart_prod = c.prod_id(+)
order by 6 desc;

/*À§¿¡²¨ ANSI OUTER JOIN*/
SELECT *
FROM member a
LEFT OUTER JOIN cart b
ON(a.mem_id = b.cart_member)
LEFT OUTER JOIN prod c
ON(b.cart_prod = c.prod_id);

CREATE TABLE exp_goods_asia (
       country VARCHAR2(10),
       seq     NUMBER,
       goods   VARCHAR2(80));

INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 1, '¿øÀ¯Á¦¿Ü ¼®À¯·ù');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 2, 'ÀÚµ¿Â÷');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 3, 'ÀüÀÚÁýÀûÈ¸·Î');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 4, '¼±¹Ú');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 5,  'LCD');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 6,  'ÀÚµ¿Â÷ºÎÇ°');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 7,  'ÈÞ´ëÀüÈ­');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 8,  'È¯½ÄÅºÈ­¼ö¼Ò');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 9,  '¹«¼±¼Û½Å±â µð½ºÇÃ·¹ÀÌ ºÎ¼ÓÇ°');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 10,  'Ã¶ ¶Ç´Â ºñÇÕ±Ý°­');

INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 1, 'ÀÚµ¿Â÷');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 2, 'ÀÚµ¿Â÷ºÎÇ°');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 3, 'ÀüÀÚÁýÀûÈ¸·Î');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 4, '¼±¹Ú');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 5, '¹ÝµµÃ¼¿þÀÌÆÛ');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 6, 'È­¹°Â÷');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 7, '¿øÀ¯Á¦¿Ü ¼®À¯·ù');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 8, '°Ç¼³±â°è');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 9, '´ÙÀÌ¿Àµå, Æ®·£Áö½ºÅÍ');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 10, '±â°è·ù');

COMMIT;

SELECT goods
FROM exp_goods_asia
where country = 'ÇÑ±¹'
union  --ÇÕ ÁýÇÕ(ÇÕÃÄÁö¸é¼­ Áßº¹À» Á¦°ÅÇÔ)
SELECT goods
FROM exp_goods_asia
where country = 'ÀÏº»';

SELECT seq, goods
FROM exp_goods_asia
where country = 'ÇÑ±¹'
union  --ÇÕ ÁýÇÕ(ÇÕÃÄÁö¸é¼­ Áßº¹À» Á¦°ÅÇÔ)
SELECT seq, goods
FROM exp_goods_asia
where country = 'ÀÏº»'
union  --ÇàÀ»  ÀÌ·¸°Ô ±×³É ºÙÀÏ¼öµµÀÖÀ½
select 10, 'ÄÄÇ»ÅÍ'
FROM dual;

SELECT goods
FROM exp_goods_asia
where country = 'ÇÑ±¹'
union ALL  --ÀüÃ¼¸¦ ´Ù ´õÇØÁÜ(Áßº¹ Á¦°Å´Â¾ÈµÊ)
SELECT goods
FROM exp_goods_asia
where country = 'ÀÏº»';

SELECT goods
FROM exp_goods_asia
where country = 'ÇÑ±¹'
INTERSECT  --±³ÁýÇÔ(°øÅëµÈ ¾Öµé¸¸ ³ªÅ¸³¿)
SELECT goods
FROM exp_goods_asia
where country = 'ÀÏº»';

SELECT goods
FROM exp_goods_asia
where country = 'ÇÑ±¹'
except --Â÷ÁýÇÕ(À§¿¡²¨¿¡¼­ ¾Æ·¡²¨ »­)
SELECT goods
FROM exp_goods_asia
where country = 'ÀÏº»';

-- ÇÕÁýÇÕ ¿¹½Ã
-- oracle ÁýÇÕÀº Ãâ·Â ÄÃ·³ÀÇ ¼ö¿Í Å¸ÀÔÀÌ °°¾Æ¾ßÇÔ.
-- Á¤·ÉÀº ¸¶Áö¸· select¹®¿¡¸¸ »ç¿ë
SELECT To_CHAR(department_id) as ºÎ¼­
      , COUNT(*) ºÎ¼­º°Á÷¿ø¼ö
FROM employees
GROUP BY department_id
UNION
SELECT 'ÀüÃ¼'
    ,COUNT(*) AS ÀüÃ¼Á÷¿ø¼ö
    FROM employees;
 
-- EXISTS·Î Á¸ÀçÇÏ´ÂÁö ¾ÊÇÏ´ÂÁö ¾Ë ¼ö ÀÖ°Ô ÇÑ´Ù. 
-- ¼¼¹Ì Á¶ÀÎÀÌ¶ó°íµµ ÇÔ.
-- job_history Å×ÀÌºí¿¡ Á¸ÀçÇÏ´Â ºÎ¼­Ãâ·Â
SELECT a.department_id
 , a.department_name
 FROM departments a
 WHERE EXISTS (SELECT * --select´Â ÀÇ¹Ì¾øÀ½ whereÀÇ ³»¿ë¿¡ ÇØ´çµÇ´Â µ¥ÀÌÅÍ°¡ Á¸ÀçÇÏ´ÂÁö¸¸ Ã¼Å©
                FROM job_history b
                WHERE a.department_id = b.department_id);

-- job_history Å×ÀÌºí¿¡ Á¸ÀçÇÏ´Â ¾Ê´Â ºÎ¼­ Ãâ·Â
SELECT a.department_id
 , a.department_name
 FROM departments a
 WHERE  NOT EXISTS (SELECT * --select´Â ÀÇ¹Ì¾øÀ½ whereÀÇ ³»¿ë¿¡ ÇØ´çµÇ´Â µ¥ÀÌÅÍ°¡ Á¸ÀçÇÏ´ÂÁö¸¸ Ã¼Å©
                FROM job_history b
                WHERE a.department_id = b.department_id);
                
-- ¼ö°­³»¿ªÀÌ ¾ø´Â ÇÐ»ýÁ¶È¸
SELECT *
FROM ÇÐ»ý a
WHERE NOT EXISTS (SELECT *
                    FROM ¼ö°­³»¿ª b
                    WHERE b.ÇÐ¹ø = a.ÇÐ¹ø);

/* Á¤±Ô Ç¥Çö½Ä '°Ë»ö', 'Ä¡È¯' ÇÏ´Â °úÁ¤À» °£ÆíÇÏ°Ô Ã³¸® ÇÒ ¼ö ÀÖµµ·Ï ÇÏ´Â¼ö´Ü.
    oracleÀº 10gºÎÅÍ »ç¿ë
    (JAVA, python, JS ´Ù Á¤±ÔÇ¥Çö½Ä »ç¿ë°¡´É) Á¶±Ý¾¿ ´Ù¸§
    .(dot) or []Àº ¸ðµÎ ¹®ÀÚ 1±ÛÀÚ¸¦ ÀÇ¹ÌÇÔ
    ^ <-- ½ÃÀÛÀ» ÀÇ¹ÌÇÔ ^[0-9] <-- ¼ýÀÚ·Î ½ÃÀÛÇÏ´Â ^q <-q·Î ½ÃÀÛÇÏ´Â
    [^0-9] <-- ´ë°ýÈ£ ¾ÈÀÇ ^ <-- notÀ» ÀÇ¹ÌÇÔ
*/
--REGEXP_LIKE : Á¤±Ô½Ä ÆÐÅÏÀ» °Ë»ö
SELECT *
FROM member
WHERE  REGEXP_LIKE(mem_comtel, '^..-');

--¿µ¹®ÀÚ 3¹ø ÃâÇö ÈÄ @ÆÐÅÏ(abc@gmail.com)
SELECT *
FROM member
WHERE  REGEXP_LIKE(mem_mail ,'^[a-zA-Z]{3}@');

/* ¹Ýº¹½ÃÄö½º
 * : 0°³ÀÌ»ó
 + : 1°³ÀÌ»ó
 ? : 0,1°³
 {n} : n¹ø
 {n,} : n¹ø ÀÌ»ó
 {n,m} : n¹øÀÌ»ó m¹øÀÌÇÏ
 */
 SELECT *
FROM member
WHERE  REGEXP_LIKE(mem_mail ,'^[a-zA-Z]{3,5}@');

-- mem_add2 ¹®ÀÚ¶ç¾î¾²±â¹®ÀÚ ÆÐÅÏÀÇ µ¥ÀÌÅÍ¸¦ Ãâ·ÂÇÏ½Ã¿À
SELECT mem_name
    , mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2,'. .'); --¾î´À ¹®ÀÚµç 

SELECT mem_name
    , mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2,'[°¡-ÆR] [0-9]'); --ÇÑ±Û

SELECT mem_name
    , mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2,'[°¡-ÆR]$'); --ÇÑ±Û ³¡³ª´Â $ -> q$ -> q·Î³¡³ª´Â

--ÇÑ±Û¸¸ ÀÖ´Â ÁÖ¼Ò°Ë»ö
SELECT mem_name
    , mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2,'^[°¡-ÆR]+$');

--ÇÑ±ÛÀÌ ¾ø´Â ÁÖ¼Ò°Ë»ö
SELECT mem_name
    , mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2,'^[^°¡-ÆR]+$');

-- | <--¶Ç´Â
-- () <-- ÆÐÅÏ±×·ì
-- J·Î½ÃÀÛÇÏ¸ç, ¼¼¹øÂ° ¹®ÀÚ°¡ M¶Ç´Â NÀÎ Á÷¿øÀÌ¸§ Á¶È¸
SELECT emp_name
FROM employees
WHERE REGEXP_LIKE(emp_name, '^J.(n|m)');

--REGEXP_SUBSTR Á¤±ÔÇ¥Çö½Ä ÆÐÅÏÀ» ÀÏÄ¡ÇÏ´Â ¹®ÀÚ¿­ ¹ÝÈ¯
-- ÀÌ¸ÞÀÏ @¸¦ ±âÁØÀ¸·Î ¾Õ°ú µÚ¸¦ Ãâ·ÂÇÏ½Ã¿À
                                --ÆÐÅÏ, ½ÃÀÛÀ§Ä¡, ¸ÅÄª¼ø¹ø
SELECT REGEXP_SUBSTR(mem_mail, '[^@]+',1,1) as mem_id
    , REGEXP_SUBSTR(mem_mail, '[^@]+',1,2) as mem_domain
FROM member;
--¿¹½Ã
SELECT REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 1) AS a
    , REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 2) AS b
    ,REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 3) AS c
from dual;
SELECT REGEXP_SUBSTR('pang su hi 1234','[0-9]') --default 1,1
    ,REGEXP_SUBSTR('pang su hi 1234','[^0-9]')
    ,REGEXP_SUBSTR('pang su hi 1234','[^0-9]+')
FROM dual;

--¶ç¾î¾²±â¸¦ ±âÁØÀ¸·Î 2¹øÂ° ÃâÇöÇÏ´Â ÁÖ¼Ò¸¦ Ãâ·ÂÇÏ½Ã¿À
--ÇÑ±Û ±âÁØÀ¸·Î 2¹øÀç ÃâÇöÇÏ´Â ÁÖ¼Ò¸¦ Ãâ·ÂÇÏ½Ã¿À
select REGEXP_SUBSTR(mem_add1,'[^ ]+',1,2) AS Áß°£
    ,REGEXP_SUBSTR(mem_add1,'[°¡-Èþ]+',1,2) AS Áß°£2
from member;

--  8~ 14 »çÀÌ ÅØ½ºÆ® ¸¸Á·ÇÏ´Â µ¥ÀÌÅÍ Ãâ·Â
SELECT*
FROM(
    SELECT 'abcd1234' as id FROM dual
    UNION
    SELECT 'Abcd123456' as id FROM dual
    UNION
    SELECT 'A1234' as id FROM dual
    UNION
    SELECT 'A123456789cdefg' as id FROM dual
)
where REGEXP_LIKE(id,'^[a-zA-Z0-9]{8,14}$');

