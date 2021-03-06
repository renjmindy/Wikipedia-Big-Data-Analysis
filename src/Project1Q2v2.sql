CREATE DATABASE project1q2_db;

SHOW DATABASES;

USE project1q2_db;

CREATE EXTERNAL TABLE IF NOT EXISTS P1Q2T1 (
	prev STRING,
	curr STRING,
	tlnk STRING,
	clnk INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY '\t'
	LOCATION '/user/cjen/project1q2t1';
	
LOAD DATA INPATH '/user/cjen/project1q2/wikiclick.tsv' INTO TABLE P1Q2T1;

SELECT * FROM P1Q2T1;

-- DROP TABLE P1Q2T1; --
-- 
--
--

CREATE TABLE P1Q2T2 (
	prev STRING,
	curr STRING,
	tlnk STRING,
	clnk INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY '\t';

DESCRIBE P1Q2T2;
	
LOAD DATA LOCAL INPATH '/home/cjen/wikiclick_2012/clickstream-enwiki-2020-12.tsv' INTO TABLE P1Q2T2;

SELECT * FROM P1Q2T2;

--
--
--

INSERT OVERWRITE DIRECTORY '/user/hive/p1q2t2_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT prev, 
	   SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) AS CLICK_TOTAL,	
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) / SUM(clnk) * 1.0, 4) AS CLICK_PERCENT, 
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1 ELSE 0 END) / COUNT(*) * 1.0, 4) AS LINK_PERCENT
FROM P1Q2T2
GROUP BY prev 
ORDER BY CLICK_PERCENT DESC, LINK_PERCENT DESC, CLICK_TOTAL DESC
LIMIT 6000;

--
--
--

INSERT OVERWRITE DIRECTORY '/user/hive/p1q2t2_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT prev, 
	   SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) AS CLICK_TOTAL,	
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) / SUM(clnk) * 1.0, 4) AS CLICK_PERCENT, 
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1 ELSE 0 END) / COUNT(*) * 1.0, 4) AS LINK_PERCENT
FROM P1Q2T2
GROUP BY prev 
ORDER BY CLICK_TOTAL DESC, CLICK_PERCENT DESC, LINK_PERCENT DESC
LIMIT 6000;

--
--
--

INSERT OVERWRITE DIRECTORY '/user/hive/p1q2t2_3'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT prev,
	   SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) AS CLICK_TOTAL,	
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) / SUM(clnk) * 1.0, 4) AS CLICK_PERCENT, 
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1 ELSE 0 END) / COUNT(*) * 1.0, 4) AS LINK_PERCENT
FROM P1Q2T2
GROUP BY prev 
LIMIT 60000;

--
--
--

INSERT OVERWRITE DIRECTORY '/user/hive/p1q2t2_4'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT curr, 
	   SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) AS CLICK_TOTAL,	
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) / SUM(clnk) * 1.0, 4) AS CLICK_PERCENT, 
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1 ELSE 0 END) / COUNT(*) * 1.0, 4) AS LINK_PERCENT
FROM P1Q2T2 
GROUP BY curr
ORDER BY CLICK_PERCENT DESC, LINK_PERCENT DESC, CLICK_TOTAL DESC
LIMIT 6000;

--
--
--

INSERT OVERWRITE DIRECTORY '/user/hive/p1q2t2_5'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT curr, 
	   SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) AS CLICK_TOTAL,	
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) / SUM(clnk) * 1.0, 4) AS CLICK_PERCENT, 
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1 ELSE 0 END) / COUNT(*) * 1.0, 4) AS LINK_PERCENT
FROM P1Q2T2
GROUP BY curr 
ORDER BY CLICK_TOTAL DESC, CLICK_PERCENT DESC, LINK_PERCENT DESC
LIMIT 6000;

--
--
--

INSERT OVERWRITE DIRECTORY '/user/hive/p1q2t2_6'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT curr,
	   SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) AS CLICK_TOTAL,	
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) / SUM(clnk) * 1.0, 4) AS CLICK_PERCENT, 
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1 ELSE 0 END) / COUNT(*) * 1.0, 4) AS LINK_PERCENT
FROM P1Q2T2
GROUP BY curr 
LIMIT 60000;

--
--
--

INSERT OVERWRITE DIRECTORY '/user/hive/p1q2t2_7'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT prev, curr,
	   SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) AS CLICK_TOTAL,	
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) / SUM(clnk) * 1.0, 4) AS CLICK_PERCENT, 
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1 ELSE 0 END) / COUNT(*) * 1.0, 4) AS LINK_PERCENT
FROM P1Q2T2 
GROUP BY prev, curr
ORDER BY CLICK_PERCENT DESC, LINK_PERCENT DESC, CLICK_TOTAL DESC
LIMIT 6000;

--
--
--

INSERT OVERWRITE DIRECTORY '/user/hive/p1q2t2_8'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT prev, curr, 
	   SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) AS CLICK_TOTAL,	
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) / SUM(clnk) * 1.0, 4) AS CLICK_PERCENT, 
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1 ELSE 0 END) / COUNT(*) * 1.0, 4) AS LINK_PERCENT
FROM P1Q2T2
GROUP BY prev, curr 
ORDER BY CLICK_TOTAL DESC, CLICK_PERCENT DESC, LINK_PERCENT DESC
LIMIT 6000;

--
--
--

INSERT OVERWRITE DIRECTORY '/user/hive/p1q2t2_9'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT prev, curr,
	   SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) AS CLICK_TOTAL,	
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1*clnk ELSE 0 END) / SUM(clnk) * 1.0, 4) AS CLICK_PERCENT, 
	   ROUND(SUM(CASE WHEN tlnk = 'link' THEN 1 ELSE 0 END) / COUNT(*) * 1.0, 4) AS LINK_PERCENT
FROM P1Q2T2
GROUP BY prev, curr 
LIMIT 60000;

--
--
--
