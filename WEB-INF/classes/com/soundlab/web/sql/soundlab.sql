create table ALBUM(
    ALBUM_SEQ INT PRIMARY KEY,
    ALBUM_TITLE VARCHAR(50),
    INTRO VARCHAR(2000),
    AGENCY_NAME VARCHAR(20),
    RELEASE_DATE VARCHAR(20),
    ALBUM_TYPE VARCHAR(20),
    ARTIST_NAME VARCHAR(20),
    ALBUM_GENRE VARCHAR(20)
);
create table MUSIC_GENRE(
    GENRE_SEQ INT PRIMARY KEY,
    GENRE VARCHAR(20) 
);
create table ARTIST(
    ARTIST_SEQ INT PRIMARY KEY,
    ARTIST_NAME VARCHAR(20),
    SEX VARCHAR(10),
    BIRTH VARCHAR(20),
    DEBUT VARCHAR(20),
    NATION VARCHAR(20),
    GROUP_NAME VARCHAR(20),
    INTRO1 VARCHAR(500),
    INTRO2 VARCHAR(2000)
);
create table IMG(
    IMG_SEQ INT AUTO_INCREMENT PRIMARY KEY,
    IMG_NAME VARCHAR(20) ,
    EXT VARCHAR(10),
    SEQ INT
);
create table MV(
    MV_SEQ INT PRIMARY KEY,
    MV_TITLE VARCHAR(80),
    MUSIC_SEQ INT,
    RELEASE_DATE VARCHAR(20),
    YTB VARCHAR(100)
);
create table MUSIC(
    MUSIC_SEQ INT PRIMARY KEY,
    MUSIC_TITLE VARCHAR(50),
    ALBUM_SEQ INT,
    ARTIST_SEQ INT,
    GENRE_SEQ INT,
    RELEASE_DATE VARCHAR(20),
    MUSIC_ADDR VARCHAR(100)
);
create table PLAYLIST(
    PL_SEQ INT PRIMARY KEY,
    MEMBER_ID VARCHAR(20), 
    MUSIC_SEQ INT,
    PL_TITLE VARCHAR(20),
    REGI_DATE TIMESTAMP DEFAULT now()
);
create table VIEW_RECORD(
    VIEW_SEQ INT AUTO_INCREMENT PRIMARY KEY,
    MEMBER_ID VARCHAR(20) NOT NULL,
    SEQ_GROUP INT,
    SG_ELEMENT VARCHAR(10),
    VIEW_DATE TIMESTAMP DEFAULT now()
);
create table MEMBER(
    MEMBER_ID VARCHAR(20) PRIMARY KEY,
    PASS VARCHAR(20),
    NAME VARCHAR(20),
    BIRTH VARCHAR(20),
    PHONE VARCHAR(20),
    NICK VARCHAR(20),
    SEX VARCHAR(20),
    E_MAIL VARCHAR(30),
    JOIN_DATE TIMESTAMP DEFAULT now()
);
create table UPDOWN(
    UD_SEQ INT AUTO_INCREMENT PRIMARY KEY,
    MEMBER_ID VARCHAR(20),
    SEQ_GROUP INT,
    SG_ELEMENT VARCHAR(10),
    TYPES VARCHAR(10)
);
create table KAKAO(
    MEMBER_ID VARCHAR(20) PRIMARY KEY,
    KAKAO_ID VARCHAR(20),
    KAKAO_PASS VARCHAR(60)
);
create table ARTICLE(
    ARTICLE_SEQ INT PRIMARY KEY,
    MEMBER_ID VARCHAR(20),
    BOARD_SEQ INT,
    TITLE VARCHAR(50),
    CONTENTS VARCHAR(50),
    HASH VARCHAR(50),
    REGI_DATE TIMESTAMP DEFAULT now()
);
create table BOARD(
    BOARD_SEQ INT AUTO_INCREMENT PRIMARY KEY,
    BOARD_NAME VARCHAR(20)
);
CREATE TABLE HASHTAG(
	HASHTAG_SEQ INT AUTO_INCREMENT PRIMARY KEY,
	HASH VARCHAR(20)
);
create table COMMENT(
    COMMENT_SEQ INT AUTO_INCREMENT PRIMARY KEY,
    MEMBER_ID VARCHAR(20),
    SEQ_GROUP INT,
    MSG VARCHAR(300),
    REGI_DATE TIMESTAMP DEFAULT now()
);
CREATE TABLE LOGIN_RECORD(
	LR_SEQ INT AUTO_INCREMENT PRIMARY KEY,
	MEMBER_ID VARCHAR(20),
	SEX VARCHAR(20),
	LOGIN_DATE TIMESTAMP DEFAULT now()
);
ALTER TABLE MV ADD CONSTRAINT MV_FK_MUSIC_SEQ FOREIGN KEY (MUSIC_SEQ) REFERENCES MUSIC(MUSIC_SEQ) ON DELETE CASCADE;
ALTER TABLE MUSIC ADD CONSTRAINT MUSIC_FK_ALBUM_SEQ FOREIGN KEY (ALBUM_SEQ) REFERENCES ALBUM(ALBUM_SEQ) ON DELETE CASCADE;
ALTER TABLE MUSIC ADD CONSTRAINT MUSIC_FK_ARTIST_SEQ FOREIGN KEY (ARTIST_SEQ) REFERENCES ARTIST(ARTIST_SEQ) ON DELETE CASCADE;
ALTER TABLE MUSIC ADD CONSTRAINT MUSIC_FK_GENRE_SEQ FOREIGN KEY (GENRE_SEQ) REFERENCES MUSIC_GENRE(GENRE_SEQ) ON DELETE CASCADE;
ALTER TABLE PLAYLIST ADD CONSTRAINT PLAYLIST_FK_MEMBER_ID FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE;
ALTER TABLE PLAYLIST ADD CONSTRAINT PLAYLIST_FK_MUSIC_SEQ FOREIGN KEY (MUSIC_SEQ) REFERENCES MUSIC(MUSIC_SEQ) ON DELETE CASCADE;
ALTER TABLE VIEW_RECORD ADD CONSTRAINT VIEW_RECORD_FK_MEMBER_ID FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE;
ALTER TABLE UPDOWN ADD CONSTRAINT UPDOWN_FK_MEMBER_ID FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE;
ALTER TABLE KAKAO ADD CONSTRAINT KAKAO_FK_MEMBER_ID FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID);
ALTER TABLE ARTICLE ADD CONSTRAINT ARTICLE_FK_MEMBER_ID FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE;
ALTER TABLE ARTICLE ADD CONSTRAINT ARTICLE_FK_BOARD_SEQ FOREIGN KEY (BOARD_SEQ) REFERENCES BOARD(BOARD_SEQ) ON DELETE CASCADE;
ALTER TABLE LOGIN_RECORD ADD CONSTRAINT LOGIN_RECORD_FK_MEMBER_ID FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE;
CREATE VIEW NR_NEW_USER AS
  SELECT DATE(JOIN_DATE) DATE, COUNT(MEMBER_ID) NEW_USER
    FROM MEMBER
GROUP BY DATE(JOIN_DATE);
CREATE VIEW NR_DAY_STR AS
  SELECT DATE(VIEW_DATE) DATE, COUNT(MEMBER_ID) STRM
    FROM VIEW_RECORD
   WHERE SG_ELEMENT = "MUSIC"
GROUP BY DATE(VIEW_DATE);
CREATE VIEW NR_VISITER AS
SELECT M.DATE, M.M_SUM_VISIT, F.F_SUM_VISIT
  FROM (  SELECT DATE(LOGIN_DATE) DATE, SEX MALE, COUNT(LR_SEQ) M_SUM_VISIT
            FROM LOGIN_RECORD
           WHERE SEX LIKE '남'
        GROUP BY DATE(LOGIN_DATE), SEX) M
       LEFT JOIN
       (  SELECT DATE(LOGIN_DATE) DATE, SEX FEMALE, COUNT(LR_SEQ) F_SUM_VISIT
            FROM LOGIN_RECORD
           WHERE SEX LIKE '여'
        GROUP BY DATE(LOGIN_DATE), SEX) F
          ON M.DATE = F.DATE;
CREATE VIEW NR_ART1 AS
  SELECT V.SEQ_GROUP 곡번호,
         MU.MUSIC_TITLE 곡명,
         YEAR(CURDATE()) - YEAR(M.BIRTH) + 1 나이,
         M.SEX 성별,
         COUNT(V.SEQ_GROUP) 스트리밍수
    FROM MUSIC MU,
         VIEW_RECORD V
         JOIN MEMBER M ON V.MEMBER_ID = M.MEMBER_ID
   WHERE     SG_ELEMENT LIKE 'music'
         AND V.SEQ_GROUP = MU.MUSIC_SEQ
         AND M.MEMBER_ID NOT LIKE 'shin'
GROUP BY V.SEQ_GROUP, M.MEMBER_ID, M.SEX
ORDER BY SEQ_GROUP, 나이, 성별;
CREATE VIEW NR_ART2 AS 
  SELECT UD.SEQ_GROUP 곡번호,
         YEAR(CURDATE()) - YEAR(M.BIRTH) + 1 나이,
         M.SEX 성별,
         COUNT(CASE WHEN UD.TYPES LIKE 'U' THEN 1 END) 좋아요수,
         COUNT(CASE WHEN UD.TYPES LIKE 'D' THEN 1 END) 싫어요수
    FROM UPDOWN UD JOIN MEMBER M ON UD.MEMBER_ID = M.MEMBER_ID
   WHERE SG_ELEMENT LIKE 'MUSIC' AND M.MEMBER_ID NOT LIKE 'shin'
GROUP BY UD.SEQ_GROUP, M.MEMBER_ID, M.SEX
ORDER BY SEQ_GROUP, 나이, 성별;
CREATE VIEW NR_ART AS
SELECT A1.곡번호 SONG_SEQ,
       A1.나이 AGE,
       A1.성별 SEX,
       A1.스트리밍수 STR,
       A2.좋아요수 GOOD,
       A2.싫어요수 BAD
  FROM NR_ART1 A1
       LEFT JOIN NR_ART2 A2
          ON     A1.곡번호 = A2.곡번호
             AND A1.나이 = A2.나이
             AND A1.성별 = A2.성별;
CREATE OR REPLACE VIEW NR_ARTIST_STATS AS
  SELECT A.ARTIST_SEQ,
         A.ARTIST_NAME,
         M.ALBUM_SEQ,
         ALBUM_TITLE,
         SONG_SEQ,
         MUSIC_TITLE,
         SUM(STR) SUM_STR,
         SUM(GOOD) SUM_GOOD,
         SUM(BAD) SUM_BAD
    FROM NR_ART N,
         ALBUM B,
         MUSIC M,
         ARTIST A
   WHERE     N.SONG_SEQ = M.MUSIC_SEQ
         AND M.ARTIST_SEQ = A.ARTIST_SEQ
         AND M.ALBUM_SEQ = B.ALBUM_SEQ
GROUP BY SONG_SEQ;
CREATE VIEW NR_PREF AS
  SELECT UD.SEQ_GROUP ART_SEQ,
         A.ARTIST_NAME,
         YEAR(CURDATE()) - YEAR(M.BIRTH) + 1 AGE,
         M.SEX SEX,
         COUNT(CASE WHEN UD.TYPES LIKE 'U' THEN 1 END) GOOD
    FROM ARTIST A,
         UPDOWN UD
         JOIN MEMBER M ON UD.MEMBER_ID LIKE M.MEMBER_ID
   WHERE SG_ELEMENT LIKE 'ARTIST' AND UD.SEQ_GROUP = A.ARTIST_SEQ
GROUP BY UD.SEQ_GROUP, M.MEMBER_ID, M.SEX
ORDER BY UD.SEQ_GROUP, AGE, SEX;
CREATE VIEW NR_GENRE AS
SELECT T.GENRE_SEQ,
       G.GENRE GENRE_NAME,
       AGE,
       SEX,
       GOOD
  FROM (  SELECT UD.SEQ_GROUP GENRE_SEQ,
                 YEAR(CURDATE()) - YEAR(M.BIRTH) + 1 AGE,
                 M.SEX SEX,
                 COUNT(CASE WHEN UD.TYPES LIKE 'U' THEN 1 END) GOOD
            FROM UPDOWN UD JOIN MEMBER M ON UD.MEMBER_ID = M.MEMBER_ID
           WHERE     SG_ELEMENT LIKE 'GENRE'
                 AND UD.SEQ_GROUP IN (SELECT GENRE_SEQ FROM MUSIC_GENRE)
        GROUP BY UD.SEQ_GROUP, M.MEMBER_ID, M.SEX
        ORDER BY UD.SEQ_GROUP, AGE, SEX) T,
       MUSIC_GENRE G
 WHERE T.GENRE_SEQ = G.GENRE_SEQ;
CREATE VIEW NR_AGE_GENRE AS
  SELECT GENRE_SEQ,
         GENRE_NAME,
         CASE
            WHEN AGE >= 10 AND AGE < 20 THEN '10대'
            WHEN AGE >= 20 AND AGE < 30 THEN '20대'
            WHEN AGE >= 30 AND AGE < 40 THEN '30대'
            WHEN AGE >= 40 AND AGE < 50 THEN '40대'
            ELSE '50대 이상'
         END AS AGE_GROUP,
         SUM(GOOD) SUM_GOOD
    FROM NR_GENRE
GROUP BY GENRE_SEQ,
         CASE
            WHEN AGE >= 10 AND AGE < 20 THEN '10대'
            WHEN AGE >= 20 AND AGE < 30 THEN '20대'
            WHEN AGE >= 30 AND AGE < 40 THEN '30대'
            WHEN AGE >= 40 AND AGE < 50 THEN '40대'
            ELSE '50대 이상'
         END
ORDER BY AGE_GROUP;
CREATE VIEW NR_AGE_ARTIST AS
  SELECT ART_SEQ,
         ARTIST_NAME,
         CASE
            WHEN AGE >= 10 AND AGE < 20 THEN '10대'
            WHEN AGE >= 20 AND AGE < 30 THEN '20대'
            WHEN AGE >= 30 AND AGE < 40 THEN '30대'
            WHEN AGE >= 40 AND AGE < 50 THEN '40대'
            ELSE '50대 이상'
         END AS AGE_GROUP,
         SUM(GOOD) SUM_GOOD
    FROM NR_PREF
   WHERE ARTIST_NAME IN ("레드벨벳", "방탄소년단", "트와이스")
GROUP BY ART_SEQ,
         CASE
            WHEN AGE >= 10 AND AGE < 20 THEN '10대'
            WHEN AGE >= 20 AND AGE < 30 THEN '20대'
            WHEN AGE >= 30 AND AGE < 40 THEN '30대'
            WHEN AGE >= 40 AND AGE < 50 THEN '40대'
            ELSE '50대 이상'
         END
ORDER BY AGE_GROUP, ART_SEQ;
CREATE VIEW NR_SEX_GENRE AS
  SELECT GENRE_NAME,
         CASE WHEN SEX = "남" THEN "M" WHEN SEX = "여" THEN "F" END AS MF,
         SUM(GOOD) SUM_GOOD
    FROM NR_GENRE
GROUP BY GENRE_NAME,
         CASE WHEN SEX = "남" THEN "M" WHEN SEX = "여" THEN "F" END
ORDER BY GENRE_NAME, MF DESC;
CREATE VIEW NR_SEX_ARTIST AS
  SELECT ARTIST_NAME,
         CASE WHEN SEX = "남" THEN "M" WHEN SEX = "여" THEN "F" END AS MF,
         SUM(GOOD) SUM_GOOD
    FROM NR_PREF
   WHERE ARTIST_NAME IN ("레드벨벳", "방탄소년단", "트와이스")
GROUP BY ARTIST_NAME,
         CASE WHEN SEX = "남" THEN "M" WHEN SEX = "여" THEN "F" END
ORDER BY ARTIST_NAME;
CREATE VIEW NR_ARTI_AGE AS
    SELECT ARTIST_NAME ,
        CASE
            WHEN AGE >= 10 AND AGE < 20 THEN '10대'
            WHEN AGE >= 20 AND AGE < 30 THEN '20대'
            WHEN AGE >= 30 AND AGE < 40 THEN '30대'
            WHEN AGE >= 40 AND AGE < 50 THEN '40대'
         END AS AGE_GROUP,
           SUM(CASE WHEN SEX LIKE "남" THEN GOOD END) M,
           SUM(CASE WHEN SEX LIKE "여" THEN GOOD END) F
FROM NR_PREF
GROUP BY ARTIST_NAME,AGE_GROUP,
         CASE
            WHEN AGE >= 10 AND AGE < 20 THEN '10대'
            WHEN AGE >= 20 AND AGE < 30 THEN '20대'
            WHEN AGE >= 30 AND AGE < 40 THEN '30대'
            WHEN AGE >= 40 AND AGE < 50 THEN '40대'
         END
;
CREATE VIEW  NR_ARTIST_MF AS
SELECT ARTIST_NAME, 
    SUM(CASE WHEN SEX like '남' then GOOD end) M,  
    SUM(CASE WHEN SEX like '여' then GOOD end) F
FROM NR_PREF
group by artist_name, sex
;
CREATE VIEW NR_HASH AS
SELECT SEQ_GROUP HASH_SEQ,HASH,DATE(VIEW_DATE) DAY,COUNT(VIEW_DATE) COUNT_VIEW
FROM VIEW_RECORD V
LEFT JOIN HASHTAG H
ON V.SEQ_GROUP = H.HASHTAG_SEQ
WHERE SG_ELEMENT LIKE "HASH"
GROUP BY SEQ_GROUP
;
CREATE OR REPLACE VIEW SJ_EMPTY_ROW AS
  SELECT 1 NUM
  UNION ALL SELECT 2
    UNION ALL SELECT 3
    UNION ALL SELECT 4
    UNION ALL SELECT 5
    UNION ALL SELECT 6
    UNION ALL SELECT 7
    UNION ALL SELECT 8
    UNION ALL SELECT 9
    UNION ALL SELECT 10
    UNION ALL SELECT 11;
CREATE OR REPLACE VIEW SJ_EMPTY_SIX AS
  SELECT 1 NUM
  UNION ALL SELECT 2
    UNION ALL SELECT 3
    UNION ALL SELECT 4
    UNION ALL SELECT 5
    UNION ALL SELECT 6;
CREATE OR REPLACE VIEW SJ_DJ_VIEW
AS
SELECT 
  M.ARTICLE_SEQ,
  I.IMG_NAME,
  I.EXT,
  M.MEMBER_ID,
  M.TITLE,
  M.REGI_DATE,
  MU.MUSIC_SEQ,
  MU.MUSIC_TITLE,
  AR.ARTIST_NAME,
  MU.GENRE_SEQ,
  AL.ALBUM_TITLE,
  HT.HASHTAG,
  HT.HASH
FROM
  (SELECT
  A.*,
  SUBSTRING_INDEX(SUBSTRING_INDEX(A.CONTENTS, ',', N.NUM), ',', -1) AS MUSIC_SEQ
  FROM
    SJ_EMPTY_ROW N
  JOIN ARTICLE A
    ON CHAR_LENGTH(A.CONTENTS) - CHAR_LENGTH(REPLACE(A.CONTENTS,',',''))>= N.NUM-1
  ) M JOIN MUSIC MU
  ON M.MUSIC_SEQ LIKE MU.MUSIC_SEQ
  LEFT JOIN ALBUM AL
  ON MU.ALBUM_SEQ LIKE AL.ALBUM_SEQ
  LEFT JOIN ARTIST AR
  ON MU.ARTIST_SEQ LIKE AR.ARTIST_SEQ
  LEFT JOIN (SELECT 
  M.ARTICLE_SEQ,
  M.HASH,
  GROUP_CONCAT(H.HASH) AS HASHTAG
  FROM (SELECT A.*,
               SUBSTRING_INDEX(SUBSTRING_INDEX(A.HASH, ',', N.NUM), ',', -1) AS HASH_SEQ
          FROM SJ_EMPTY_ROW N
               JOIN ARTICLE A
                  ON CHAR_LENGTH(A.HASH) - CHAR_LENGTH(REPLACE(A.HASH, ',', '')) >= N.NUM - 1
    ) M
       JOIN HASHTAG H
       ON M.HASH_SEQ LIKE H.HASHTAG_SEQ
  GROUP BY M.ARTICLE_SEQ)HT
  ON M.ARTICLE_SEQ LIKE HT.ARTICLE_SEQ
  LEFT JOIN IMG I
    ON I.SEQ LIKE M.ARTICLE_SEQ
  ORDER BY ARTICLE_SEQ ASC, MUSIC_SEQ ASC
  ; 
CREATE OR REPLACE VIEW SJ_GENREV AS
SELECT
ROW_NUMBER() OVER(ORDER BY A.MEMBER_ID, A.LIKE_CNT DESC) AS RANKING,
A.*
FROM
(SELECT
*,
COUNT(*) AS LIKE_CNT
FROM
UPDOWN U
LEFT JOIN MUSIC_GENRE MG
ON U.SEQ_GROUP LIKE MG.GENRE_SEQ
WHERE U.SG_ELEMENT LIKE 'genre'
GROUP BY U.MEMBER_ID, U.SEQ_GROUP)A
WHERE A.MEMBER_ID LIKE 'sound'
ORDER BY RANKING;
CREATE OR REPLACE VIEW SJ_FORYOU_V AS
SELECT
A.NUM A_NUM,
A.RANKING MS_RANK_A,
A.MUSIC_SEQ MS_SEQ_A,
A.MUSIC_TITLE MS_TITLE_A,
IFNULL(A.GENRE, (SELECT
B.GENRE
FROM
(SELECT
ROW_NUMBER() OVER(ORDER BY A.MEMBER_ID, A.LIKE_CNT DESC) AS RANKING,
A.*
FROM
(SELECT
*,
COUNT(*) AS LIKE_CNT
FROM
UPDOWN U
LEFT JOIN MUSIC_GENRE MG
ON U.SEQ_GROUP LIKE MG.GENRE_SEQ
WHERE U.SG_ELEMENT LIKE 'genre'
GROUP BY U.MEMBER_ID, U.SEQ_GROUP)A
WHERE A.MEMBER_ID LIKE 'sound'
ORDER BY RANKING)B
WHERE RANKING LIKE 1)) AS MS_GENRE_A,
IFNULL(A.GENRE_SEQ, (SELECT
B.GENRE_SEQ
FROM
(SELECT
ROW_NUMBER() OVER(ORDER BY A.MEMBER_ID, A.LIKE_CNT DESC) AS RANKING,
A.*
FROM
(SELECT
*,
COUNT(*) AS LIKE_CNT
FROM
UPDOWN U
LEFT JOIN MUSIC_GENRE MG
ON U.SEQ_GROUP LIKE MG.GENRE_SEQ
WHERE U.SG_ELEMENT LIKE 'genre'
GROUP BY U.MEMBER_ID, U.SEQ_GROUP)A
WHERE A.MEMBER_ID LIKE 'sound'
ORDER BY RANKING)B
WHERE RANKING LIKE 1)) AS MS_GENRE_SEQ_A,
A.ARTIST_SEQ MS_ARTIST_A,
A.ARTIST_NAME MS_ARTIST_NAME_A,
A.ALBUM_SEQ MS_ALBUM_A,
A.ALBUM_TITLE MS_ALBUM_TITLE_A,
B.NUM B_NUM,
B.RANKING MS_RANK_B,
B.MUSIC_SEQ MS_SEQ_B,
B.MUSIC_TITLE MS_TITLE_B,
IFNULL(B.GENRE, (SELECT
B.GENRE
FROM
(SELECT
ROW_NUMBER() OVER(ORDER BY A.MEMBER_ID, A.LIKE_CNT DESC) AS RANKING,
A.*
FROM
(SELECT
*,
COUNT(*) AS LIKE_CNT
FROM
UPDOWN U
LEFT JOIN MUSIC_GENRE MG
ON U.SEQ_GROUP LIKE MG.GENRE_SEQ
WHERE U.SG_ELEMENT LIKE 'genre'
GROUP BY U.MEMBER_ID, U.SEQ_GROUP)A
WHERE A.MEMBER_ID LIKE 'sound'
ORDER BY RANKING)B
WHERE RANKING LIKE 2)) AS MS_GENRE_B,
IFNULL(B.GENRE_SEQ, (SELECT
B.GENRE_SEQ
FROM
(SELECT
ROW_NUMBER() OVER(ORDER BY A.MEMBER_ID, A.LIKE_CNT DESC) AS RANKING,
A.*
FROM
(SELECT
*,
COUNT(*) AS LIKE_CNT
FROM
UPDOWN U
LEFT JOIN MUSIC_GENRE MG
ON U.SEQ_GROUP LIKE MG.GENRE_SEQ
WHERE U.SG_ELEMENT LIKE 'genre'
GROUP BY U.MEMBER_ID, U.SEQ_GROUP)A
WHERE A.MEMBER_ID LIKE 'sound'
ORDER BY RANKING)B
WHERE RANKING LIKE 2)) AS MS_GENRE_SEQ_B,
B.ARTIST_SEQ MS_ARTIST_B,
B.ARTIST_NAME MS_ARTIST_NAME_B,
B.ALBUM_SEQ MS_ALBUM_B,
B.ALBUM_TITLE MS_ALBUM_TITLE_B,
C.NUM AL_NUM,
C.RANKING AL_RANK,
C.ARTIST_SEQ AL_ARTIST,
C.ARTIST_NAME AL_ARTIST_NAME,
C.ALBUM_SEQ AL_SEQ,
C.ALBUM_TITLE AL_TITLE,
C.IMG_NAME AL_IMG_NAME,
C.EXT AL_IMG_EXT,
D.RANKING AT_RANK,
D.ARTIST_SEQ AT_ARTIST_SEQ,
D.ARTIST_NAME AT_ARTIST_NAME,
IFNULL(D.IMG_NAME,'vanilla') AT_IMG_NAME,
IFNULL(D.EXT,'jpg') AT_IMG_EXT
FROM
(SELECT
*
FROM
(SELECT
ROW_NUMBER() OVER(ORDER BY MS_VCNT DESC) AS RANKING,
MS.MUSIC_SEQ,
MS.MUSIC_TITLE,
VR_MS.VIEW_CNT MS_VCNT,
MS.GENRE_SEQ,
GR.GENRE,
MS.ARTIST_SEQ,
AB.ARTIST_NAME,
MS.ALBUM_SEQ,
AB.ALBUM_TITLE,
UD_MS.SG_ELEMENT MS_LIKE,
UD_MS.TYPES MS_UD,
UD_AT.SG_ELEMENT AT_LIKE,
UD_AT.TYPES AT_UD
FROM
MUSIC MS
JOIN ALBUM AB
ON MS.ALBUM_SEQ = AB.ALBUM_SEQ
JOIN MUSIC_GENRE GR
ON MS.GENRE_SEQ LIKE GR.GENRE_SEQ
LEFT JOIN (SELECT *,COUNT(*) AS VIEW_CNT FROM VIEW_RECORD WHERE VIEW_DATE <= CURDATE() GROUP BY SEQ_GROUP) VR_MS
ON MS.MUSIC_SEQ LIKE VR_MS.SEQ_GROUP
LEFT JOIN (SELECT * FROM UPDOWN WHERE MEMBER_ID LIKE 'sound') UD_MS
ON MS.MUSIC_SEQ LIKE UD_MS.SEQ_GROUP
LEFT JOIN (SELECT * FROM UPDOWN WHERE MEMBER_ID LIKE 'sound') UD_AT
ON MS.ARTIST_SEQ LIKE UD_AT.SEQ_GROUP
WHERE MS.GENRE_SEQ IN (SELECT
B.GENRE_SEQ
FROM
(SELECT
ROW_NUMBER() OVER(ORDER BY A.MEMBER_ID, A.LIKE_CNT DESC) AS RANKING,
A.*
FROM
(SELECT
*,
COUNT(*) AS LIKE_CNT
FROM
UPDOWN U
LEFT JOIN MUSIC_GENRE MG
ON U.SEQ_GROUP LIKE MG.GENRE_SEQ
WHERE U.SG_ELEMENT LIKE 'genre'
GROUP BY U.MEMBER_ID, U.SEQ_GROUP)A
WHERE A.MEMBER_ID LIKE 'sound'
ORDER BY RANKING)B
WHERE RANKING LIKE 1)
  AND UD_MS.SG_ELEMENT IS NULL
  AND (UD_AT.TYPES NOT LIKE 'd' OR UD_AT.TYPES IS NULL)
GROUP BY MS.MUSIC_SEQ
ORDER BY VR_MS.VIEW_CNT DESC)C
RIGHT JOIN SJ_EMPTY_SIX SS
ON C.RANKING LIKE SS.NUM
WHERE SS.NUM <= 5
OR C.RANKING <= 5
)A,
(SELECT
*
FROM
(SELECT
ROW_NUMBER() OVER(ORDER BY MS_VCNT DESC) AS RANKING,
MS.MUSIC_SEQ,
MS.MUSIC_TITLE,
VR_MS.VIEW_CNT MS_VCNT,
MS.GENRE_SEQ,
GR.GENRE,
MS.ARTIST_SEQ,
AB.ARTIST_NAME,
MS.ALBUM_SEQ,
AB.ALBUM_TITLE,
UD_MS.SG_ELEMENT MS_LIKE,
UD_MS.TYPES MS_UD,
UD_AT.SG_ELEMENT AT_LIKE,
UD_AT.TYPES AT_UD
FROM
MUSIC MS
JOIN ALBUM AB
ON MS.ALBUM_SEQ = AB.ALBUM_SEQ
JOIN MUSIC_GENRE GR
ON MS.GENRE_SEQ LIKE GR.GENRE_SEQ
LEFT JOIN (SELECT *,COUNT(*) AS VIEW_CNT FROM VIEW_RECORD WHERE VIEW_DATE <= CURDATE() GROUP BY SEQ_GROUP) VR_MS
ON MS.MUSIC_SEQ LIKE VR_MS.SEQ_GROUP
LEFT JOIN (SELECT * FROM UPDOWN WHERE MEMBER_ID LIKE 'sound') UD_MS
ON MS.MUSIC_SEQ LIKE UD_MS.SEQ_GROUP
LEFT JOIN (SELECT * FROM UPDOWN WHERE MEMBER_ID LIKE 'sound') UD_AT
ON MS.ARTIST_SEQ LIKE UD_AT.SEQ_GROUP
WHERE MS.GENRE_SEQ IN (SELECT
B.GENRE_SEQ
FROM
(SELECT
ROW_NUMBER() OVER(ORDER BY A.MEMBER_ID, A.LIKE_CNT DESC) AS RANKING,
A.*
FROM
(SELECT
*,
COUNT(*) AS LIKE_CNT
FROM
UPDOWN U
LEFT JOIN MUSIC_GENRE MG
ON U.SEQ_GROUP LIKE MG.GENRE_SEQ
WHERE U.SG_ELEMENT LIKE 'genre'
GROUP BY U.MEMBER_ID, U.SEQ_GROUP)A
WHERE A.MEMBER_ID LIKE 'sound'
ORDER BY RANKING)B
WHERE RANKING LIKE 2)
  AND UD_MS.SG_ELEMENT IS NULL
  AND (UD_AT.TYPES NOT LIKE 'd' OR UD_AT.TYPES IS NULL)
GROUP BY MS.MUSIC_SEQ
ORDER BY VR_MS.VIEW_CNT DESC)C
RIGHT JOIN SJ_EMPTY_SIX SS
ON C.RANKING LIKE SS.NUM
WHERE SS.NUM <= 5
OR C.RANKING <= 5
)B,
(SELECT
*
FROM
(SELECT
ROW_NUMBER() OVER(ORDER BY AB_VCNT DESC) AS RANKING,
MS.ARTIST_SEQ,
AB.ARTIST_NAME,
MS.ALBUM_SEQ,
AB.ALBUM_TITLE,
VR_AB.VIEW_CNT AB_VCNT,
AB.ALBUM_GENRE,
UD_AT.SG_ELEMENT AT_LIKE,
UD_AT.TYPES AT_UD,
I.IMG_NAME,
I.EXT
FROM
MUSIC MS
JOIN ALBUM AB
ON MS.ALBUM_SEQ = AB.ALBUM_SEQ
LEFT JOIN (SELECT 
MSC.ALBUM_SEQ, 
COUNT(*) AS VIEW_CNT 
FROM VIEW_RECORD VRD 
JOIN MUSIC MSC 
ON VRD.SEQ_GROUP 
LIKE MSC.MUSIC_SEQ  
WHERE VIEW_DATE <= CURDATE() 
GROUP BY MSC.ALBUM_SEQ) VR_AB
ON MS.ALBUM_SEQ LIKE VR_AB.ALBUM_SEQ
LEFT JOIN (SELECT * FROM UPDOWN WHERE MEMBER_ID LIKE 'sound') UD_AT
ON MS.ARTIST_SEQ LIKE UD_AT.SEQ_GROUP
LEFT JOIN IMG I
ON MS.ALBUM_SEQ LIKE I.SEQ
WHERE (UD_AT.TYPES NOT LIKE 'd'
OR UD_AT.TYPES IS NULL)
AND (AB.ALBUM_GENRE LIKE (SELECT
CONCAT('%',GENRE,'%')
FROM
SJ_GENREV
WHERE RANKING LIKE 1)
OR AB.ALBUM_GENRE LIKE (SELECT
CONCAT('%',GENRE,'%')
FROM
SJ_GENREV
WHERE RANKING LIKE 2))
GROUP BY AB.ALBUM_SEQ
ORDER BY VR_AB.VIEW_CNT DESC)A
RIGHT JOIN SJ_EMPTY_SIX SS
ON A.RANKING LIKE SS.NUM
WHERE A.RANKING <= 5
OR SS.NUM <= 5)C,
(SELECT
* 
FROM
(SELECT
ROW_NUMBER() OVER(ORDER BY VIEW_CNT DESC) AS RANKING,
M.ARTIST_SEQ,
AT.ARTIST_NAME,
COUNT(*) AS VIEW_CNT,
I.IMG_NAME,
I.EXT
FROM VIEW_RECORD VR
JOIN MUSIC M
ON VR.SEQ_GROUP LIKE M.MUSIC_SEQ
JOIN ARTIST AT
ON M.ARTIST_SEQ = AT.ARTIST_SEQ
LEFT JOIN (SELECT * FROM UPDOWN WHERE MEMBER_ID LIKE 'sound') UD
ON AT.ARTIST_SEQ LIKE UD.SEQ_GROUP
LEFT JOIN IMG I
ON I.SEQ LIKE M.ARTIST_SEQ
WHERE VR.MEMBER_ID LIKE 'sound'
AND UD.UD_SEQ IS NULL
AND VR.VIEW_DATE <= CURDATE()
GROUP BY AT.ARTIST_SEQ
ORDER BY VIEW_CNT DESC)A
WHERE A.RANKING <= 5)D
WHERE A.NUM LIKE B.NUM
AND A.NUM LIKE C.NUM
AND A.NUM LIKE D.RANKING;
CREATE OR REPLACE VIEW JT_VIEW_PLAYER AS
SELECT
    M.MUSIC_SEQ,
    M.MUSIC_TITLE,
    M.MUSIC_ADDR,
    A.ARTIST_NAME,
    M.ALBUM_SEQ,
    A.ALBUM_TITLE
FROM MUSIC AS M
     JOIN ALBUM AS A
     ON M.ALBUM_SEQ = A.ALBUM_SEQ;
INSERT INTO HASHTAG(HASH) VALUES('신나는'),('차분한'),('어쿠스틱'),('트로피칼'),('부드러운'),('드라이브'),('휴식'),('편집숍/카페'),('헬스'),('클럽'),('스트레스'),('이별'),('사랑/고백'),('새벽감성'),('위로');
INSERT INTO BOARD(BOARD_NAME) VALUES('DJ');
INSERT INTO BOARD(BOARD_NAME) VALUES('COMMENT');
INSERT INTO MEMBER(
	MEMBER_ID, PASS, NAME, BIRTH, PHONE, NICK, SEX, E_MAIL
)
VALUES(
	'shin', '1111', '신승호', '920807', '01033650158', '사운드랩', '남', 'kanu0158@naver.com'
);
INSERT INTO MEMBER(
	MEMBER_ID, PASS, NAME, BIRTH, PHONE, NICK, SEX, E_MAIL
)
VALUES(
	'sound', 'sound', '사운드', '920807', '01012341234', '사운드랩', '남', 'soundlab@naver.com'
);
INSERT INTO MEMBER(
	MEMBER_ID, PASS, NAME, BIRTH, PHONE, NICK, SEX, E_MAIL
)
VALUES(
	'admin', 'admin', '관리자', '181013', '01012345678', '관리자', '남', 'admin@soundlab.com'
);
INSERT INTO MUSIC_GENRE(
	GENRE_SEQ, GENRE
)
VALUES(
	1, '발라드'
);
INSERT INTO MUSIC_GENRE(
	GENRE_SEQ, GENRE
)
VALUES(
	2, '힙합'
);
INSERT INTO MUSIC_GENRE(
	GENRE_SEQ, GENRE
)
VALUES(
	3, '댄스'
);
INSERT INTO MUSIC_GENRE(
	GENRE_SEQ, GENRE
)
VALUES(
	4, '트로트'
);
INSERT INTO MUSIC_GENRE(
	GENRE_SEQ, GENRE
)
VALUES(
	5, '일렉트로닉'
);
INSERT INTO MUSIC_GENRE(
	GENRE_SEQ, GENRE
)
VALUES(
	6, '알앤비소울'
);
INSERT INTO MUSIC_GENRE(
	GENRE_SEQ, GENRE
)
VALUES(
	32, '포크'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	7, '선미', '여', '920502', '2013.08.01', '대한민국', '솔로'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	8, '빈지노', '남', '870912', '2012.07.26', '대한민국', '솔로'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	9, '아이유', '여', '930516', '2008.09.11', '대한민국', '솔로'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	10, '임창정', '남', '731130', '1995.04.08', '대한민국', '솔로'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	11, '방탄소년단', '남', '130612', '2013.06.12', '대한민국', '그룹'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	12, '에이핑크', '여', '110419', '2011.04.19', '대한민국', '그룹'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	13, '로꼬', '남', '891225', '2012.09.30', '대한민국', '솔로'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	14, '바이브', '남', '020201', '2002.02.01', '대한민국', '그룹'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	15, '아이콘', '남', '150915', '2015.09.15', '대한민국', '그룹'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	16, '로이킴', '남', '930703', '2012.11.27', '대한민국', '솔로'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	17, '폴킴', '남', '880211', '2014.01.21', '대한민국', '솔로'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	18, '블랙핑크', '여', '160808', '2016.08.08', '대한민국', '그룹'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	19, '트와이스', '여', '151020', '2015.10.20', '대한민국', '그룹'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	20, '레드벨벳', '여', '140804', '2014.08.04', '대한민국', '그룹'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	21, '10cm', '남', '830301', '2010.04.01', '대한민국', '솔로'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	22, '볼빨간사춘기', '여', '160422', '2016.04.22', '대한민국', '그룹'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	23, '마마무', '여', '140601', '2014.06.01', '대한민국', '그룹'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	24, '박원', '남', '100526', '2010.05.26', '대한민국', '솔로'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	25, '윤종신', '남', '691015', '1990.05.01', '대한민국', '솔로'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	26, '벤', '여', '910730', '2012.09.01', '대한민국', '솔로'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	27, '멜로망스', '남', '150310', '2015.03.10', '대한민국', '그룹'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	28, '먼데이키즈', '남', '051103', '2005.11.03', '대한민국', '그룹'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	29, 
	'WARNING', 
'고혹적이며 때로는 파격적으로 음악과 무대를 해석해내며 가장 주목받는 독보적인 여성 솔로 아티스트로 확고한 위치에 오른 선미가 미니앨범 ‘WARNING(워닝)’을 발표한다. 선미의 미니앨범 ‘WARNING(워닝)’은 지난 해 8월 발표한 스페셜 에디션 ‘가시나(GASHINA)’와‘가시나’의 프리퀄(prequel)로서 올해 1월에 발표한 ‘주인공(HEROINE)’을 잇는 3부작 프로젝트의 마무리이자 그 완성인 앨범으로, 이로써 3부작 프로젝트는 ‘WARNING’, 즉 ‘경고’ 가 전체 테마였음을 알려주는 앨범이다. 또한 미니 앨범 ‘WARNING(워닝)’은 선미가 모든 트랙의 크레딧에 이름을 올리게 된 첫 앨범으로도 의미가 깊다. 16세의 나이로 그룹 ‘원더걸스’로 데뷔하여 10여년간 솔로 활동을 병행해 오면서 작사는 물론 작곡, 편곡 등 음악 작업에 참여하며 자신의 음악적 재능을 꾸준히 선보여온 선미는 이번 미니앨범 ‘WARNING(워닝)’의 전곡 작사 및 주요 수록곡의 작곡, 편곡 작업을 함께 하며 그녀가 가진 음악을 펼쳐냈다.
선미의 미니 앨범 ‘WARNING(워닝)’의 타이틀곡은 ‘사이렌(Siren)’으로, 선미가 작사하고, 작곡가Frants(프란츠)와 함께 공동 작곡했다. 이 곡은 3년 전에 선미와 Frants(프란츠)가 의기투합하여 만들었던 곡으로 당시 준비 중이었던 원더걸스의 앨범의 타이틀곡 후보로도 거론되었던 비하인드 스토리가 알려지며 정식 발표 전부터 화제를 모았다. 2018년의 ‘사이렌(Siren)’은 선미의 미니 앨범 ‘WARNING(워닝)’의 타이틀곡으로 낙점된 후, 곡 컨셉을 발전시켜 새롭게 재탄생되었다.',
'㈜메이크어스엔터테인먼트', '20180904', 'EP', '선미', '댄스'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	30, 
	'24:26', 
'Beenzino의 클래식 [2 4 : 2 6] 5주년 기념 리마스터 재발매!
2012년 여름에 발매되었던 Beenzino의 첫 솔로 앨범 [2 4 : 2 6]
[2 4 : 2 6]는 발매 직후 폭발적인 호응을 이끌어내며 Beenzino의 대표작으로 자리매김하였다.
[2 4 : 2 6]는 힙합 앨범으로써는 유례없는 성공을 거둠과 동시에 Beenzino를 세상에 널리 알린 작품이 되었으며, 5년이 지난 지금도 이 앨범의 영향력은 현재 진행형이다.
심지어 이 앨범의 CD 역시 그 인기가 식지 않아 지금까지도 번번이 품절 사태에 이르렀으니 한국 힙합 역사상 가장 사랑받는 앨범이 되었다고 해도 과언이 아닐 것이다. 이러한 [2 4 : 2 6]가 발매 5주년을 맞이하여 "5th Anniversary Remaster Edition"으로 돌아온다.
이번 리마스터 에디션은 세계적인 마스터링 엔지니어 Vlado Meller의 리마스터링을 거쳐 보다 향상된 사운드로 재탄생하였으며, 음반의 구성과 형태는 초판과 거의 동일하게 유지하여 원작의 감흥을 그대로 전한다.',
'ILLIONAIRE RECORDS', '20170711', 'EP', '빈지노', '힙합'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	31, 
	'삐삐', 
'아이유 디지털 싱글 [삐삐]
"모두들 안녕. 내 걱정은 마세요. 난 언제나 잘해 나갈 테니까"
올 해로 꼭 데뷔 10주년을 맞이한 아이유가 디지털 싱글 삐삐를 발표한다.
아이유의 10주년을 기념해 10월 10일 발표된 디지털 싱글 삐삐는, 아이유가 데뷔 이후 처음으로 도전하는 Alternative R&B 스타일의 곡으로, 관계에 있어 무례하게 선을 넘는 사람들에게 던지는 유쾌하고 간결한 경고의 메시지를 담고 있다. 타인을 자신만의 기준으로 통제하거나 규정짓지 않는, 동등하고 독립적인 개개인 간의 건강한 유대관계가 어느 때보다 중요시 되는 요즘, 지금을 사는 모든 현대인들의 이야기가 될 수 있는 곡이다.
클래식한 정통 발라드곡 미아를 통해 열여섯의 어린 나이로 데뷔한 아이유는, 지난 10년 간 장르의 경계를 뛰어넘는 음악적 역량과 한계를 모르는 다채로운 매력으로, 현 가요계에 유일무이한 뮤지션이자 아티스트로서 놀라운 성장을 거듭해왔다.
10년이라는 시간의 무게처럼 깊이 있는 싱어송라이터 겸 프로듀서로도 점차 진화하고 있는 아이유가, 직접 프로듀싱과 작사에 참여한 이번 싱글 삐삐는, 여전히 보여줄 것이 무궁무진한 그녀의 팔레트처럼 대중들로 하여금 아이유의 또 다른 10년을 기대케 해준다.',
'카카오엠', '20181010', '싱글', '아이유', '알앤비소울'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	33, 
	'꽃갈피 둘', 
'시간이 흘러도 바래지 않는, 소박하고 아름다운 추억의 흔적
아이유 두 번째 리메이크 앨범 [꽃갈피 둘]
오래된 서재에서 먼지를 털어내고 꺼내든 책 한 권. 한 장씩 책장을 넘기다 책갈피처럼 끼워진 빛바랜 네 잎 클로버나 꽃잎들을 발견할 때가 있다. 오래전 누군가가 마음을 담아 선물했을 소박하고 아름다운 흔적. 또 그 페이지마다 밑줄이 그어져있는 기억할 만한 글귀들. 이러한 꽃갈피는 요즘은 점점 잊혀 가고 있는 예전 아날로그 세대의 감성과 낭만을 보여주는 청년 문화의 상징 중 하나일지도 모른다.
아이유의 두 번째 리메이크 앨범인 [꽃갈피 둘]은 지난 2014년 첫 선을 보여 대중과 평단의 뜨거운 호평을 이끌어낸 리메이크 음반 [꽃갈피]의 연장선에 놓인 작품으로, 원곡에 담긴 아날로그 감성과 아이유 특유의 서정성이 마주한 스페셜 미니음반이다. 지난 [꽃갈피] 앨범과 마찬가지로 아이유 본인이 평소 아껴왔던 꽃갈피 같은 이전 세대의 음악들을 직접 선곡하였으며, 정재일, 고태영, 홍소진, 강이채, 적재, 임현제(혁오), 김성모, 정성하 등 폭넓은 세대와 장르의 뮤지션들과 협업하여, 원곡 고유의 정서 위에 아이유의 색채를 덧입히는 작업에 어느 때보다 섬세한 노력을 기울였다.
세대를 관통하는 추억의 노래들을 아이유의 순수한 음색으로 재해석해낸 [꽃갈피 둘]은, 시간이 흘러도 바래지 않는, 소박하고 아름다운 순간들을 되살려, 다시금 세대와 세대를 잇고 그 속에 진한 공감과 울림을 선사하며, 꽃갈피로써 추억의 선물, 그 자체가 되길 소망한다.',
'㈜페이브엔터테인먼트', '20170922', 'EP', '아이유', '발라드,댄스,포크'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	34, 
	'하루도 그대를 사랑하지 않은 적이 없었다', 
'14th Album [하루도 그대를 사랑하지 않은 적이 없었다]
믿고 듣는 가수, 만능 엔터테이너, 명품발라더, 가을 감성발라드 등 대한민국을 대표하는 국민가수 임창정, 9월 19일 14번쨰 정규앨범 [하루도 그대를 사랑하지 않은 적이 없었다] 발매!!
또 다시 사랑, 내가 저지른 사랑 등 연달아 히트치며 각종 음원 사이트 및 음악프로그램 1위를 차지하며 발표하는 곡마다 오랫동안 사랑 받아온 임창정이 작년 두 번째 미니앨범[그 사람을 아나요] 이후 2018 올 가을 약 1년 만에 정규 14집 하루도 그대를 사랑하지 않은 적이 없었다로 컴백한다.
임창정의 정규 14집의 타이틀 곡 "하루도 그대를 사랑하지 않은 적이 없었다"는 임창정 특유의 음색과 호소력 짙은 감성을 느낄 수 있는 임창정식 감성 발라드에 R&B, POP 장르들을 결합한 새로운 색깔의 발라드곡으로 그 동안 앨범 작업을 함께 해오며 히트곡을 탄생시킨 작곡가 멧돼지와 작곡가 신형섭이 의기투합해 만든 뉴 임창정표 발라드곡이 탄생했다.
또한 대한민국을 대표하는 세션 이태윤, 길은경, 정수완, 융스트링 팀이 참여 곡의 최고의 완성도를 높였으며 쓸쓸한 느낌의 어쿠스틱 기타가 곡의 전반부를 이끌어 가며 곡의 후반부에 나오는 아이리쉬 오케스트라의 연주와 임창정의 보컬이 완벽한 하모니를 통해 감성을 더욱 더 극대화 시킨 곡이다.
이 밖에도 이야기하듯 노래하는 전반부와 갈수록 애절함을 더해가는 곡의 전개로 임창정만이 소화할 수 있는 감성과 가창력 느낄 수 있는 노래방, 헤어지는 여자 헤어지는 연인들의 심정을 임창정의 감성으로 풀이한 나눠갖지 말아요, 피아노 하나와 임창정의 보컬이 빛을 발하는 곡 이젠그러려고 다양한 드라마OST의 히트 곡을 탄생시킨 프로듀싱&퍼블리싱팀 케이던스와 작업한 곡 지금이라 부르던 그때, 임창정이 처음 시도하는 R&B 발라드곡 그 사람 보사노바(BOSSANOVA)리듬에 잊지 못한 사랑에 대한 그리움을 서정적인 기타연주가 매력적인 예쁘더라, 임창정의 최고 히트곡 소주한잔을 만든 작곡가 이동원과 함께한 친구10년 사랑1년, 대한민국 R&B 디바 알리에게 선물했던 또 생각이 나서를 임창정이 직접 부른 지나고도 같은 오늘 임창정의 정규앨범에 한 곡 씩은 꼭 들어간다는 댄스 곡 그냥 냅둬, 히트곡을2018년 버전으로 새롭게 편곡한 또 다시 사랑(2018), 나란놈이란(2018)까지 임창정의 음악을 오랫동안 기다린 팬들에게 올 가을 가장 큰 음악 선물이 될 것이다.',
'엔에이취이엠쥐', '20180919', '정규', '임창정', '발라드,댄스'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	35, 
	'주인공', 
'주인공 (Heroine)
독보적인 여성 솔로 아티스트로서 확고하게 자리매김하고 있는 선미가 2018년 첫 싱글 타이틀 주인공(Heroine)을 발표한다. 
선미의 주인공은 지난 해 선미 신드롬을 일으켰던 3년 만의 솔로 컴백곡 가시나(Gashina) 이후 5개월 만에 발표하는 싱글 타이틀로, 가시나의 프리퀄(prequel)이다. "왜 예쁜 날 두고 가시나"라는 독백과 함께 안타까운 이별을 받아들여야만 했던 가시나의 앞선 이야기인 주인공의 메인 테마는 얼음 속에 갇힌 꽃이다. 이미 한쪽으로 기울어버린 사랑하는 이와의 관계 속에서 상처받으면서도 이해하고자 애쓰며 얼어붙어 가는 여자의 위태로운 모습을 선미 특유의 감성으로 섬세하게 그려냈다. 
선미와 더 블랙 레이블(The Black Label)의 협업으로 완성된 주인공은 레트로 풍의 신스와 베이스가 가미된 웅장한 비트 위에 세련되면서도 중독성 있는 멜로디와 이전에 볼 수 없었던 선미의 다채로운 컬러의 보컬이 더해져 독보적인 여성 솔로 아티스트로서의 선미를 한번 더 입증시키는 곡이다. 주인공은 더 블랙 레이블의 프로듀서 테디(TEDDY)와 24가 작사, 작곡, 편곡을 공동 작업했으며, 선미 또한 작사에 참여해 가시나로 이어지는 감정선을 가사에 녹여냈다.
완벽한 곡 구성과 뛰어난 퀄리티의 주인공은 고혹적인 아름다움과 압도적인 퍼포먼스를 선사하는 여성 솔로 아티스트 선미의 독보적인 위상을 재확인시켜주는 2018년 첫 신호탄이 될 것이다.',
'㈜메이크어스엔터테인먼트', '20180118', '싱글', '선미', '댄스'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	36, 
	'가시나', 
'예쁜 날 두고 가시나
새로운 음악을 선보일 때마다 고혹적인 동시에 파격적인 컨셉을 선보여 온 선미가 3년 만에 새로운 곡 "가시나"를 발표 했다. 이번 곡은 막강한 프로듀서들이 포진해있는 더 블랙 레이블(The Black Label)과 공동 작업을 통해 야심차게 준비한 음악으로 동양적인 분위기의 신스 사운드가 주된 테마인 곡으로 감각적인 베이스 라인에 세련된 멜로디 라인이 더해져 선미의 절제된 섹시미를 완성시킨다. 지금까지 숨겨왔던 선미의 다채로운 보컬은 솔로 아티스트로서 한층 더 성숙해진 그녀의 역량을 보여주었다.
호기심을 유발하는 곡의 제목 "가시나"는 세 가지 의미를 내포한 중의적인 표현으로, 이는 꽃에 돋아 난 가시처럼 가시 난 내 모습이 더 깊숙이 파고들 거야, 안타까운 이별 앞의 쓸쓸한 되뇌임인 왜 예쁜 날 두고 가시나 등의 가사로 유려하게 음악에 녹아 들고 있다. 또한, 순 우리말 가시나에 아름다운 꽃의 무리라는 뜻이 숨겨져 있다는 지점에 이르면, 아티스트로서 선미의 깊고 예민한 감성을 마주할 수 있다.
선미와 더 블랙 레이블(The Black Label)의 협업으로 완성된 "가시나"는 더 블랙 레이블(The Black Label)이 프로듀싱했으며, 선미가 이들과 함께 작사에 참여해 음악에 대한 몰입도를 더욱 높였다.
이번 발매하는 스페셜 에디션 [가시나]는 무한한 잠재력과 예민한 감수성을 가진 선미의 여성 솔로 아티스트로서의 존재감을 본격적인 보여줄 수 있는 시작이 될 것이다.',
'㈜메이크어스엔터테인먼트', '20170822', '싱글', '선미', '댄스'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	37, 
	'LOVE YOURSELF 結  Answer', 
'LOVE YOURSELF 結  Answer 발매 
방탄소년단은 리패키지 앨범 LOVE YOURSELF 結  Answer을 발매하고, 2년 반 동안 이어진 LOVE YOURSELF 시리즈의 대미를 장식한다.
2016년 3월부터 시작된 방탄소년단의 LOVE YOURSELF 시리즈는 앨범의 주요 수록 곡들이 하나의 주제로 연결되어, 나 자신을 사랑하는 것이 진정한 사랑이라는 메시지를 전해왔다.  
또한, 데뷔 초부터 음악적 완성도를 위해 충분한 곡들을 매 앨범에 담아 온 방탄소년단은 이번 앨범이 리패키지 앨범 임에도 불구하고 7곡의 신곡을 포함했다. 
이번 LOVE YOURSELF 結  Answer 앨범은 치밀한 기획 아래 LOVE YOURSELF 시리즈의 정수를 담은 콘셉트 앨범이다. CD A에 수록된 16곡들은 음악, 스토리, 가사 등이 유기적으로 연결되어, 만남과 사랑으로부터 자아를 찾아가는 감정의 흐름을 따른다.
이번 앨범에서는 서사와 세계관을 강조해온 방탄소년단의 아티스트적 면모 뿐 아니라, 잘 구성된 소설을 읽는 것 같은 높은 앨범 완성도를 느낄 수 있다. 
모든 것의 결론, 비밀이 드러나다.
방탄소년단의 LOVE YOURSELF 시리즈는 기승전결(起承轉結)의 구조로 하나의 주제 의식을 관통한다. 짜임새 있는 스토리, 영상, 앨범 트랙, 디자인 등 LOVE YOURSELF의 서사를 따라온 팬들에게 모든 비밀이 풀리는 열쇠 역할을 한다.
LOVE YOURSELF 起  Wonder 영상과 承  Her 앨범이 사랑의 설렘과 두근거림을 표현했다면, 轉  Tear 앨범은 이별을 마주한 소년들의 아픔을 담았다. 이번 발표되는 結  Answer에서는 수많은 모습의 자아 속에서 나를 찾는 유일한 해답은 결국 나 자신에게 있다는 내용을 담았다. 
멤버 진이 부른 컴백 트레일러 Epiphany는 정국의 Euphoria, 지민의 Serendipity, 뷔의 Singularity로 이어져 온 서사의 흐름을 이어 받으며, LOVE YOURSELF 시리즈의 진짜 주제를 명확하게 드러낸다.
특히, L-O-V-E-Y-O-U-R-S-E-L-F 버전의 앨범 커버를 모두 합쳤을 때 나타나는 디자인과 슬리브 꽃 그림은 만남에서 자아를 찾는 과정까지 감정의 흐름을 보여준다.',
'빅히트엔터테인먼트', '20180824', '정규', '방탄소년단', '힙합'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	38, 
	'ONE & SIX', 
'Apink 7th Mini Album [ONE & SIX] 발매!
여섯 명의 다양한 매력을 보여주는 앨범 [ONE & SIX]
데뷔 후 처음으로 변화를 선보이는 에이핑크의 1도 없어
지난여름, FIVE로 대중들에게 위로와 사랑을 전하며 많은 사랑을 받았던 대한민국 대표 걸그룹 에이핑크(Apink)가 1년 만에 미니 7집 [ONE & SIX]로 컴백한다. 긴 공백기 끝에 선보일 이번 앨범은 에이핑크의 새로운 모습을 보여주기 위해 과감히 [Pink]의 타이틀을 버렸으며, 데뷔 후 처음으로 변화를 시도했다.
[ONE & SIX]는 한 앨범 안에 여섯 멤버의 각자 다양한 모습들과 매력을 보여주겠다는 포부가 담겨 있기도 하면서, 어느새 하나가 되어있는 팬들(ONE)과 여섯 명의 에이핑크(SIX)가 함께 한 7주년(ONE+SIX)이라는 깊은 의미도 함께 나타낸다.
이번 앨범 타이틀곡 1도 없어는 내가 설렐 수 있게 이후 에이핑크와 한 번 더 호흡을 맞추게 된 블랙아이드필승과 전군의 곡으로, 트로피컬 느낌의 하우스 비트가 어우러진 신나는 마이너 팝 댄스곡이다. 한 남자를 사랑했을 당시의 느낌과 감정이 이젠 남아 있지 않은, 마음이 떠나버린 여자의 심정을 가사로 표현하였으며, 에이핑크가 기존에 FIVE, NoNoNo, Mr. Chu 등의 노래로 행복과 따뜻함을 전했다면, 이번 타이틀곡 1도 없어는 사랑이 끝난 여자의 아픔을 노래하면서, 확실히 한층 성숙한 멤버들의 모습을 볼 수 있다.
타이틀곡 외에도 새롭게 시작하는 사랑에 대한 설렘을 담아낸 A L R I G H T, 독특하고 중독성 강한 훅이 인상적인 셔플 리듬의 댄스곡 Don’t be silly, 서정적이면서도 세련된 사운드가 돋보이는 발라드곡  별 그리고.. 힘들고 지쳐있을 때 수 마디 말보다 너라는 존재 자체가 위로가 된다는 내용의 팝 댄스곡 말보다 너, 여름이 느껴지는 시원한 분위기의 신나는 댄스곡  I Like That Kiss까지 총 6곡이 수록되어 있다.',
'플랜에이 엔터테인먼트', '20180702', 'EP', '에이핑크', '발라드,댄스'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	39, 
	'시간이 들겠지', 
'로꼬 (LOCO) [시간이 들겠지]
방송 및 각종 협업 프로젝트를 섭렵하고 있는 로꼬가 한 달 만에 신보를 들고 왔다. 시간이 들겠지는 본인의 현재 심정을 솔직하게 잘 드러낸 곡이며 Colde가 피쳐링을 참여하여 로꼬의 감성을 한껏 끌어 올렸다. 로꼬는 다양한 음악 스타일과 개성이 뚜렷한 프로듀서 및 아티스트와의 협업으로 자신의 음악적 스펙트럼을 넓고 굳게 다져나가고 있다.
시간이 지나면 괜찮아질 거라는 것은 알고 있지만, 지금 현재 상황이 너무나도 힘들다는 것을 누구라도 알아줬으면 하는 마음을 항상 갖고 있다.
시간은 빨리 지나가지만 우리들의 감정은 제자리에 서 있다. 하지만, 정말 시간이 모든 걸 해결해줄까?
It Takes Time',
'AOMG', '20181008', '싱글', '로꼬', '힙합'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	40, 
	'가을 타나 봐', 
'바이브[VIBE] 싱글 가을 타나 봐
이유 없이 허전하고, 필요 없이 외로워지는 가을..
공허한 가을이 찾아오면 생각나는 사람에 대한 그리움..
유난히 뜨거웠던 여름을 지나 찬 바람이 불기 시작하는 가을이 되면
자연스럽게 떠오르는 명품 보컬 그룹 바이브 (VIBE)가 가을의 공허함을 채워줄
새로운 노래 가을 타나 봐를 공개했다.
유난히 긴 호흡으로 1년여의 긴 시간을 들여 작업 중인 바이브(VIBE)의 정규 8집
발표에 앞서 공개한 가을 느낌 물씬 풍기는 가을 타나 봐는 가을바람처럼 무던하게
흘러가는 현악기의 선율 위에 툭툭 던져내듯 써내려 간 인상적인 가사는 외로움을
더욱 극대화하여 그려내고 있으며 몇 해의 시간이 거듭 흘러도 가을만 오면 공허해지는
우리들의 마음을 담아 그려내고 있다.
바이브(VIBE)의 멤버이자 프로듀서 류재현의 손에서 탄생한 가을 타나 봐는
꽤 오랜만에 선보이는 신곡이니만큼 더욱 신중을 기해 오랜 시간 동안 작업한 곡이다.
자이언티 "양화대교", "No make up", 빅뱅의 "Last dance"등을 작곡, 연주한
재즈피아니스트 전용준이 함께 편곡, 연주에 참여해 브리티시 팝 계열의
깊이 있는 사운드를 들려주고 있으며, 그 위로 리드보컬 윤민수의 프리한 보이스가
더해져 곡의 그루브를 더해주고 있다.가을 타나 봐는
"계절은 돌고 돌아 돌아오는데 사랑은 돌고 돌아 떠나버리고
 추억을 돌고 돌아 멈춰 서있는 다시 그 계절이 왔나 봐
 그리운가 봐 가을 타나 봐"
가을의 공허함을 잔잔히 채워줄 음악으로 돌아온 바이브(VIBE)의 가을 타나 봐가
가을만 되면 생각나는 사람에 대한 그리움, 그리고 가을이 찾아오면 생각나는 노래가
되기를 바래본다.',
'메이저나인', '20180918', '싱글', '바이브', '발라드'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	41, 
	'NEW KIDS : THE FINAL', 
'iKON 2nd EP ALBUM [NEW KIDS : THE FINAL]
2018년 그 어느 해 보다 활발한 활동을 펼친 아이콘이 새로운 앨범 [NEW KIDS : THE FINAL]을 통해 한 해 세 번째 컴백이라는 보기 드문 행보를 걷는다.
이번 앨범의 타이틀곡 [이별길]은 올해 초 대중의 큰 사랑을 받은 [사랑을 했다]와 막판까지 타이틀로 경쟁했던 곡이다. 가을의 계절감과 너무도 잘 어울려 1년 가까이 공개 시기를 기다려온 곡으로, 이별에 대한 서정적인 아름다운 가사와 멜로디가 압권인 곡이다. 또한 프로듀서 B.I의 발전을어느 곡보다도 뚜렷하게 느낄 수 있는 곡이기도 하다. 느린 미디엄 템포의 곡이지만 완성도 있는멋진 퍼포먼스로 대중의 눈과 귀를 모두 사로잡을 예정이다. 올가을 아이콘만의 완성도 있는 가을감성 저격을 기대해보자.',
'(주)YG엔터테인먼트', '20181001', 'EP', '아이콘', '발라드,댄스'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	42, 
	'그때 헤어지면 돼', 
'로이킴 2018년 첫 곡 [그때 헤어지면 돼]
어느덧 6년 차의 뮤지션이 된 로이킴의 새 해가 시작되었다.
데뷔 이래, 한국과 미국에서 음악과 학업 무엇 하나 소홀하지 않으며, 천천히 또 빠르게 흘러간 그의 시간은 지난 해, 스물 다섯 가장 아름다운 개화기를 보내고 또 한 해를 맞았다.
로이킴이 2018년 처음으로 내놓는 곡의 제목은 "그때 헤어지면 돼".
제목과는 다르게 헤어지는 그 때 조차 내가 정하겠다는, 결국엔 헤어질 수 없는 우리의 사이를 이야기하는 다소 이기적이기도 한 남자의 애절한 마음을 표현한 이 곡은, 로이킴이 직접 작사 작곡한 팝 발라드 곡이다.
나얼의 "같은 시간 속의 너", "기억의 빈자리" 를 비롯해, 브라운아이드소울, 윤종신, 성시경 등 국내 최고의 보컬리스트들과 함께 작업한 작곡가 강화성이 편곡을 맡았으며, 기타리스트 홍준호, 베이시스트 최훈의 연주를 더해 완성했다.
특히 보컬리스트 조규찬이 코러스에 참여해 곡 전체를 따뜻하고 풍성하게 만들었으며, 최고의 세션들의 Instrumental 에 조규찬의 코러스까지 포함한 버전을 연주곡 트랙으로 특별히 수록했다.',
'StoneMusic', '20180212', '싱글', '로이킴', '발라드'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE,INTRO
)
VALUES(
 43,'키스 먼저 할까요?','SM Entertainment','2018.03.20','OST','폴킴','발라드','SBS 월화드라마 키스 먼저 할까요? OST의 세 번째 주자로 감성 보컬리스트 폴킴이 출격한다.
키스 먼저 할까요? OST Part.3로 선보이는 폴킴의 "모든 날, 모든 순간 (Every day, Every Moment)"은 잔잔한 분위기의 어쿠스틱 팝 발라드 곡으로, 미녀 공심이 OST 예뻐보여, W OST 그대와 나, 저글러스 OST  코스
믹 걸 (Cosmic Girl)  등 다수의 드라마 OST에 참여한 실력파 작곡팀  어깨깡패 (CLEF CREW) 가 작사, 작곡, 편곡을 맡았으며,  폴킴 의 부드러운 음색이 더해져 귀를 매료시킨다.
또한 이번 곡은 가사에 고단하고 불안한 하루 속에서도 항상 함께 하자는 진심 어린 고백을 담고 있는 만큼, 앞으로 겪게 될 시련을 극복해 나가는 안순진(김선아 분)과 손무한(감우성 분)의 굳은 믿음과 사랑을 잘
표현해 드라마의 몰입도를 한층 높일 것으로 보인다.
한편, SBS 월화드라마  키스 먼저 할까요? 는 성숙한 어른들의  의외로  서툰 사랑을 그린 리얼 멜로 드라마로, 매주 월, 화요일 밤 10시 방송된다.'
);
 

INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	44, 
	'SQUARE UP', 
'@ BLACKPINK ABOUT
[SQUARE ONE], [SQUARE TWO]와  마지막처럼 으로 증명한 그들만의 다채로운 매력으로 대중들을 매료시킨 YG 대표 걸그룹 블랙핑크가 대망의 첫 미니 앨범 [SQUARE UP]과 함께 화려한 모습으로 돌아왔다. 블랙핑크의 또 다른 새로운 음악적 도전과 더욱더 성숙하고 강해진  BLACK  &  PINK 의 이중적인 매력으로 대중들에게 강렬하게  각인  시킬 예정이다.
@  SQUARE UP  ALBUM 소개글
앨범 장르 : 힙합/댄스
2016년 8월 8일 데뷔한 블랙핑크는 [SQUARE ONE], [SQUARE TWO] 시리즈와  마지막처럼 까지 차별화된 독특한 사운드와 다양한 매력으로 기록적인 성적을 내며 큰 주목을 받은 YG 대표 걸그룹 블랙핑크가 2018년 대망의 첫 미니 앨범 [SQUARE UP]으로 화려하게 돌아왔다.
 SQUARE UP 은 블랙핑크가 데뷔부터 진행해온  SQUARE  시리즈로, 데뷔앨범  SQUARE ONE , 두 번째 앨범  SQUARE TWO 의 연장선에 있다.  붙어보자 ,  싸워보자 라는 의미의 이번 앨범 명 [SQUARE UP]은 블랙핑크의 한층 더 성숙하고 강해진 음악과 컨셉으로  당당하게 맞서자 라는 메시지를 담았다.
타이틀 곡  뚜두뚜두(DDU-DU DDU-DU) 는 강력한 트랩 비트 위에 가미된 동양적인 퍼커션 리듬과 독창적인 휘슬 리드 사운드로 블랙핑크만의 독특한 색깔을 강조한다. 호소력 있는 벌스 파트와 프리드랍에서의 훅라인, 그리고 2절에서의 랩은 블랙핑크의 보컬에 탄성을 자아내기 충분하다. 곡이 전개될수록 넓게 펼쳐지는 스펙트럼과 고조되는 드랍으로 무장된  뚜두뚜두 의 파괴력은 마치 탱크를 연상시키기도 한다.
직설적인 가사와 함께 트랙에서 느껴지는 에너지로 흉내 낼 수 없는 블랙핑크만의 새로운 카리스마를 제시하는  뚜두뚜두 의 작사에는 가요계를 선도하는 프로듀서 TEDDY, 작곡에는 TEDDY, 24, R.Tee, Bekuh Boom가 참여해 팬들의 기대감을 높이고 있다.
데뷔 후 처음 선보이는 미니 앨범은, 이들의 이름  BLACKPINK 처럼 이중성을 메인 컨셉으로 [BLACK & PINK] 총 2가지 버전으로 출시될 예정이다.',
'SM Entertainment', '20180615', 'EP', '블랙핑크', '발라드,댄스,알앤비소울,힙합'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	45, 
	'Summer Nights', 
'트와이스, 7월 9일 두 번째 스페셜 앨범  Summer Nights  및 타이틀곡  Dance The Night Away  발표!
- 타이틀곡  Dance The Night Away , 트와이스의 첫 서머송! 특별한 행복 에너지 선사
-  트와이스 X 휘성  조합으로 9연속 히트 정조준! 2018 서머걸들의 매력 파티!
- 스페셜 2집  Summer Nights , 신곡 3곡 포함 총 9트랙 수록! 모모-사나-미나 작사한  Shot thru the heart  눈길
트와이스가 7월 9일 두 번째 스페셜 앨범  Summer Nights  및 타이틀곡  Dance The Night Away 를 발표한다.
 눈으로 한 번, 귀로 한 번 감동을 주는  그룹 트와이스가 2018년 여름을 화려하게 장식할  서머걸 로 돌아온다.
트와이스 첫 서머송  Dance The Night Away 는 매 순간 특별한 행복을 품고 살아가는 아홉 멤버들의 청춘을 표현한 업템포 팝곡이다. 사운드, 퍼포먼스 등 다방면에 트와이스만의 아름답고 밝은 에너지를 담아내며 한여름 무더위를 싹 가시게 할 만큼 시원하고 청량한 분위기를 풍기는 것이 특징. 매 여름휴가 시즌이면 떠올릴만한  스테디셀러 서머송  탄생을 기대케 한다.
특히  Dance The Night Away 의 작사를 휘성이 담당한 것으로 밝혀져 더욱 화제다. 휘성은 그동안 윤하의 비밀번호 486 , 티아라의  너 때문에 미쳐 , 에일리의  Heaven  등 빅히트곡들의 작사가로 명성을 떨쳤다.  Dance The Night Away 로  트와이스 X 휘성  조합이 성사된 가운데 휘성 특유의 감각적인 노랫말과 트와이스의 상큼, 발랄한 에너지가 만나 2018년 여름 장악을 예고하고 있다.
트와이스의 새 앨범  Summer Nights 에는 타이틀곡  Dance The Night Away 와  CHILLAX ,  Shot thru the heart  등 3곡의 신곡과 지난 4월 9일 발표한 미니 5집  What is Love?  수록곡 등 총 9트랙이 담긴다.' ,
'(주)JYP엔터테인먼트', '20180709', 'EP', '트와이스', '발라드,댄스'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	46, 
	'가을 안부', 
'먼데이 키즈 [가을 안부]
 하기 싫은 말 ,  눈물 ,  누군가를 떠나 보낸다는 건  3장의 싱글로 솔로 보컬리스트로서의 입지를 다진 가수  먼데이 키즈 가 전하는 가을 편지..
신보  가을 안부 는 무더웠던 여름을 지나 가을이 되면 생각나는 한 사람에 대해 쓴 이야기다.
도입부 그 동안의 안부를 묻는듯한 목소리와 가을이 되면 느껴지는 그리움, 추억에 대한 애절한 감성을 노래했다.
이진성이 직접 작곡에 참여했고 지금껏 먼데이 키즈와 많은 호흡을 함께 했던 작사가  강은경 , 작곡가  한상원, 떠오르는 신예 Lohi가 공동작업으로 함께해 기존 먼데이 키즈의 감성과 솔로 보컬리스트 이진성의 매력을 함께 담을 수 있는 곡을 탄생시켰다.
완연한 가을.. 먼데이 키즈가 묻는 가을의 안부에 여러분 모두 마음의 답장을 띄어주시길 바란다.' ,
'먼데이키즈 컴퍼니', '20171014', '싱글', '먼데이키즈', '발라드'
);
INSERT INTO ALBUM(
	ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
	47, 
	'The Fairy Tale', 
'아름답게 빛나는 동화 같은 이야기
멜로망스 [The Fairy Tale]
"우리 모두에게는 소중하게 간직하고 싶은 이야기가 있다. 그 찬란한 순간들이 모여 한 편의 동화가 된다."
같은 시간 속, 저마다의 행복을 느끼고 꿈꾸며 살아가는 우리들.
어느 것 하나 소중하지 않은 것이 없다. 이번 다섯 번째 미니 앨범은 우리가 살면서 느끼는 아름다움, 사랑, 추억, 바람, 행복 그리고 희망의 모습들을 담았다.
멜로망스는 이번 음반에서 팝, 재즈와 클래식을 넘나들며 음악적 스펙트럼을 확장시켰다. 두 멤버는 곡의 멜로디, 가사, 보컬, 사운드, 악기 구성에 고심하며 작업했고, 정동환은 15인조 스트링을 직접 디렉팅했다.
현재를 살아가는 우리의 이야기 속에 멜로망스 음악이 늘 함께 하길 바라는 마음으로 만든 노래들과 함께 당신의 시간이 더 빛나길 바란다.' ,
'민트페이퍼', '20180703', 'EP', '멜로망스', '발라드'
);
INSERT INTO ALBUM(
   ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
   48,
   'Summer Magic',
'여름 지배자 레드벨벳, 여름 미니앨범 Summer Magic 공개!
초강력 서머송 Power Up으로 또 한번 여름 강타!
여름 지배자 레드벨벳이 여름 미니앨범 Summer Magic으로 화려하게 컴백한다.
이번 앨범에는 에너지 넘치는 초강력 서머송 Power Up을 비롯한 신곡 6곡과 보너스 트랙까지 총 7트랙이 수록, 레드벨벳 특유의 상큼발랄한 매력과 청량감 넘치는 여름 분위기를 만끽할 수 있어, 글로벌 팬들의 폭발적인 호응이 기대된다.
또한 레드벨벳은 작년 여름 빨간 맛 (Red Flavor)으로 각종 음악 차트를 휩쓸며 2017 최고 서머퀸에 등극함은 물론, 지난 1월 발표한 정규 2집 리패키지 타이틀 곡 Bad Boy도 국내 각종 음원, 음반 차트 1위, 아이튠즈 종합 앨범 차트 전 세계 16개 지역 1위, 중국 샤미뮤직 종합 차트 1위, 대만, 홍콩, 싱가포르 KKBOX 한국음악 차트 1위를 기록하는 등 퍼펙트 히트 행진을 이어가 가요계 대세 걸그룹다운 면모를 입증한 만큼, 이번 컴백에 이목이 더욱 집중되고 있다.
무더위를 날려버릴 초강력 서머송! 타이틀 곡 Power Up!
이번 타이틀 곡 Power Up은 통통 튀는 8비트 게임 소스와 귀여운 훅이 매력적인 중독성 강한 업템포 팝 댄스곡으로, 가사에는 신나게 놀고 에너지를 얻으면 일도 신나게 할 수 있다는 내용을 담았으며, 여름 휴가를 떠나는 순간의 설렘을 고스란히 느낄 수 있다.' ,
'SM Entertainment', '20180806', 'EP', '레드벨벳', '댄스'
);
INSERT INTO ALBUM(
  ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
  49,
  '4.1',
'10cm 설렘 가득한 새로운 싱글 매트리스 [Mattress]
-
새로 산 침대와 그 속의 우리가 세상의 전부인 것처럼
-
새로 산 침대위 사랑하는 연인과의 이야기를 담은 10cm 신곡 매트리스는 전작 [4.0]의 주제였던 어느 방에 대한 이야기의 연장선이기도 하다. 작은 공간 안으로 허락된 단 한 명 그리고 그곳은 오직 너와 나 단둘만의 작은 세계다.
이번 앨범 역시 특유의 상황 설정과 위트 있는 가사가 돋보이지만 설렘이라는 키워드가 추가되어 10cm 고유의 색채를 잃지 않으면서 새로운 분위기를 만들어냈다.
앨범의 전체적인 아트 디렉팅은 설치 미술 작가로 활동 중인 ‘이정형작가가 참여, 뮤직비디오와 앨범 커버 아트를 통해 가사에서 들려주던 둘만의 공간을 시각화했다..' ,
'매직스트로베리사운드', '
20180823', '싱글', '10cm', '포크'
);
INSERT INTO ALBUM(
 ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
 50,
 'Red Diary',
'볼빨간사춘기 [Red Diary ‘Hidden Track’]
설레는 만남부터 푸르게 시린 이별, 혼자의 순간까지.
볼빨간사춘기 Red Diary, 그 마지막 장..' ,
'쇼파르뮤직', '20180717', '싱글', '볼빨간사춘기', '포크'
);
INSERT INTO ALBUM(
ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
51,
'RED MOON',
'마마무 "포시즌 포컬러 프로젝트"의 두 번째 앨범 [RED MOON] 발매
- 무더운 여름을 더욱 뜨겁게 달궈줄 "여름맘무"로 컴백!
- 올여름을 "RED"로 물들일 마마무의 화려하고 정열적인 매력발산!
- 마마무, [RED MOON]을 띄우며 완전체로 돌아오다.
올해 3월 [Yellow Flower]의 타이틀곡 "별이 빛나는 밤"을 통해 각종 차트를 휩쓸며 포시즌 포컬러 프로젝트의 성공적인 항해를 시작한 마마무. 네 가지 컬러에 각각의 상징으로 지금까지 보여주지 못한 각 멤버들의 숨겨진 매력과 역량을 담아내는 이 프로젝트에서 두 번째로 문별의 RED를 앞세운 새 미니앨범 [RED MOON]을 발매했다. [RED MOON]은 마마무의 두 번째 컬러인 빨간색에 문별을 뜻하는 문(달)을 합한 것으로, 여름과 닮은 마마무의 정열적인 매력을 쏟아내며 무더운 여름을 더욱 뜨겁게 달굴 예정이다.
이번 미니앨범에는 총 6곡을 수록했다. 지난 8일 선공개로 기습 발매되어 걸그룹 최초 선공개 곡 음원 순위 1위라는 성적을 기록한 "장마"를 비롯해 문별의 솔로 앨범 [SELFISH]의 타이틀곡 "SELFISH"가 포함되어 있다. 그 외에도 마이너 코드로 진행되어 호러블한 분위기의 "여름밤의 꿈"으로 가슴 한편을 서늘하게 만들기도 하고, 특히 걸그룹 여자친구의 "오늘부터 우리는", "시간을 달려서", "너 그리고 나"를 프로듀싱한 이기, 용배가 새롭게 참여해 "하늘하늘 (청순)"이라는 곡을 작업하며 마마무가 그간 감춰왔던 색다른 청순미를 한껏 보여줄 예정이다.
또한, 공식적으로 발매되진 않았지만 멤버들이 서로에게 던지는 애정이 어린(?) 디스의 재밌는 가사로 팬들에게 많은 사랑을 받고 있는 "잠이라도 자지"가 이번 앨범에 정식으로 수록되었다.' ,
'(주)RBW', '20180716', 'EP', '마마무', '댄스'
);

INSERT INTO ALBUM(
ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
52,
'미스터 션샤인 OST',
'[박원 - 이방인]
연일 시청률과 화제성에서 폭발적인 반응을 얻고 있는 tvN 미스터 션샤인 OST에 대세 싱어송라이터 박원이 합류한다.
이방인은 비참한 현실에 마주친 사랑은 과분한 꿈 같다는 내용을 담은 곡으로,
큰 고통이지만 오히려 달게 받겠다는 역설적인 사랑에 대한 노래이다.
연일 그대를 그리지만 또 바라만 보다 걸음을 멈추오, 맴도는 그리움이 주는 괴로움마저 달게 받으리,
후회로 가득한 내 삶에 그댄 덧없이 사라질 나를 감싸오와 같은 가사로 애절함 마음을 담아내었다.
또한, 담담한 아쿠스틱 피아노와 콘트라베이스 연주로 시작되는 편곡은 곡의 긴장감을 유지하면서도 잔잔한 사랑의 고통을 적나라하게 표현했다.
여기에 섬세한 감성으로 마음을 울리는 박원의 보컬이 더해져 애틋함을 한층 배가시켰다.
특히, 제목 이방인은 조선에서 태어났으나 미국인의 신분으로 조선에 돌아온, 조선인에게 낯선 유진 초이 (이병헌)를 의미하기도 하며,
한편으로는 자신의 신분을 지우고 낭인이 된 구동매 (유연석), 일본으로 건너가 유학을 하고 돌아온 김희성 (변요한) 을 포함,
각자의 방법으로 격변하던 시대를 지난 세 남자 모두를 아우를 수 있는 제목이다..' ,
'화앤담픽쳐스', '
20180813', 'OST', '박원', '발라드'
);
INSERT INTO ALBUM(
ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
53,
'LISTEN 010 좋니',
'LISTEN 010 윤종신 "좋니"
미스틱엔터테인먼트의 음악 플랫폼 LISTEN(리슨)의 열 번째 곡은 윤종신의 "좋니"다.
"좋니"는 윤종신의 짙은 감수성과 호소력이 담긴 발라드로, 윤종신이 작사하고 포스티노가 작곡했다.
헤어진 연인의 행복을 빌어주고 싶지만 어쩔 수 없는 그리움에 울컥거리는 마음을 가사로 쓴 윤종신은 그 어느 때보다 애절하게 노래한다. 담담하지만 힘있게 진행되는 "좋니"는 후반부로 갈수록 에너지가 더해져 풍성한 스트링 선율과 함께 극적인 연출을 이끌어낸다.
90년대 발라더 윤종신의 대체 불가한 표현력과 설득력을 오랜만에 다시 느끼게 해 줄 "좋니". 이별 후 힘들어하는 많은 이들이 이 노래를 듣고 공감과 위로를 받기를 바란다.
미스틱의 LISTEN은 하림, 윤종신 등 완성형 뮤지션은 물론 PERC%NT(퍼센트), 장수빈 등 실력파 신인들의 좋은 음악을 소개하며 양질의 음악 플랫폼으로 성장하고 있다.' ,
'미스틱엔터테인먼트', '20170622', '싱글', '윤종신', '발라드'
);
INSERT INTO ALBUM(
ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
54,
'미스터 션샤인 OST',
'[벤 - If You Were Me]
흥미진진한 전개로 드라마 후반까지 팽팽한 긴장감을 이어가고 있는 tvN 미스터 션샤인OST에 가수 벤이 참여한다.
If You Were Me는 사랑하는 두 사람이 서로 닿을 수 없는 두려운 상황 속에서도 상대방을 놓을 수 없는 슬픈 사랑을 담아낸 곡이다.
노래 타이틀처럼 If you were me, 두려움은 없었을테죠, If I Was You, 그 품에 날 안아줄텐데 등
그대가 나라면, 또 내가 그대라면 어땠을지 그려보는 가사가 애절한 사랑을 더욱 애틋하게 표현해내었다.
또한, 가사의 내용에 어울리는 아련한 피아노 선율과 몽환적인 분위기의 편곡이 인상적이다.
여기에 여린 듯하면서도 호소력 짙은 벤의 목소리가 더해져 드라마의 몰입도를 더욱 높일 것으로 보인다.
벤은 안정적인 가창력과 애절한 감성으로 차세대 명품 보컬리스트로 주목 받고 있는 가운데,
<또 오해영>, <이번 생은 처음이라> 등 다양한 OST 작업에도 활발히 참여하며 OST 퀸의 행보를 이어가고 있다.' ,
'화앤담픽쳐스', '20180923', 'OST', '벤', '발라드'
);
INSERT INTO ALBUM(
ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
55,
'Gift E.C.H.O',
'박효신 스페셜 앨범 [GIFT E.C.H.O]
지난 2010년 12월 [Gift]  Part 2, 그 후 군입대. 그리고 길지 않은 잠시 동안의 안녕. 그를 사랑하는 팬들의 오랜 기다림 동안 조금이나마 그 갈증을 채워 줄 박효신 마음 속의 울림에서부터 배달된 새로운 선물 [GIFT E.C.H.O] 가 도착했다. 그리고 그를 기다려 주는 팬들 마음의 문에 초인종을 조심스레 눌러 본다.
[Gift]의 마지막 이야기 [GIFT E.C.H.O]
이번 앨범은 소박하다. 그리고 그럴 수 밖에 없다. 그도 그럴 것이 무엇보다 군복무 중으로 신곡을 발표할 수 있는 상황이 되지 못하는 박효신의 상황. 그래서 신곡을 들려주지 못하는 그 만의 팬들을 향한 애정 그리고 음악을 향한 열정과 새로운 것을 보여주지 못할 수 밖에 없는 속타는 마음은 아무도 모를 것이다.
그러던 중 젤리피쉬 엔터테인먼트의 수장 프로듀서 황세준은 어떻게 하면 그런 예쁜 마음으로 한결같이 기다려주는 기다림에 지친 팬들에게 조금이라도 위로가 될 수 있는 선물을 해볼 수 있을까 고민에 잠기게 되던 중, 마침 군입대 전 박효신이 발매 하였던 [Gift] Part 1에 수록 되었던 ‘이상하다’ 의 미공개 어쿠스틱 버전이 아직 세상에 빛을 보지 못했다는 것을 잊고 있었다는 사실을 알게 되고 새로운 곡은 아니지만 아직 세상 밖으로 나오지 못한 이 곡으로 박효신을 기다려주는 팬들에게 소박하게 나마 선물을 할 수 있지 않을까에 대한 생각에 잠긴다. 그리고 무엇보다 이 곡을 작업하는 동안 박효신과 스튜디오에서 포근하고 때로는 장난스럽게 그리고 무엇보다 편안하고 세련되게 어쿠스틱 버전의 "이상하다" 를 작업하던 그날을 떠올리며 추억에 잠기게 되고 결국은 이번 앨범을 기획하기에 결심한다. 새롭게 탄생된 "이상하다" 의 어쿠스틱 버전은 그런 뒷얘기의 생생함을 전해주 듯 노래의 시작 인트로에 그날 밤 작업실 현장음들이 그대로 녹아 있어서 더욱 정겨운 느낌을 전해준다.' ,
'젤리피쉬(주)', '20120322', '비정규', '박효신', '발라드,댄스'
);


INSERT INTO ALBUM(
ALBUM_SEQ, ALBUM_TITLE, INTRO, AGENCY_NAME, RELEASE_DATE, ALBUM_TYPE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
56,
'장범준 2집',
'[장범준 2집] 앨범소개
장범준 트리오 CD는 기타리프와 드럼, 베이스 기반의 심플한 음악으로 녹음 당시 메트로놈 (클릭) 없이 러프하고 라이브스러운 느낌으로 녹음했습니다. 끊어서 녹음하지 않고 기타, 드럼, 베이스, 보컬까지 최대한 한 호흡으로 갈 수 있도록 녹음했습니다. 덕분에 지금까지 했던 어떤 녹음보다도 즐거운 마음을 가지고 작업을 할 수 있었습니다.
언플러그드 CD는 통기타, 드럼, 베이스, 피아노 기반의 따뜻한 음악으로 자연스러운 느낌을 주기 위해서 기타에 보컬만을 가이드로 들려준 뒤 연주자분들과 간단한 합주 후 각 파트별 즉흥적인 해석을 그대로 담아 녹음했습니다. 사람들이 저에게 기대하는 소리를 표현하기 위해서 서정적인 음악들로 준비했습니다.
이번 앨범은 제가 지금 28살이니까 20대에 내는 마지막 정규앨범이 되지 않을까 생각합니다. 20대의 사랑을 주제로, 제가 겪고 느껴 왔던 여러 가지 감정들을 예술가들과 함께 만화와 음악으로 담아 보았습니다. 첫사랑은 영원한가? 나를 좋아하는 여자와 내가 좋아하는 여자, 결혼은 누구랑 하게 되는 걸까? 현실은 왜 이렇게 힘든가? 등등..
약 2달여 오늘까지 웹툰과 함께 이 앨범을 기다려 주신 분들께 즐거운 마지막화가 되기를 바랍니다..' ,
'버스커버스커', '20160325', '정규', '장범준', '포크'
);
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 57,'사이렌',29, 7, 3);
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 58,'ADDICT',29, 7, 3);
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 59,'곡선',29, 7, 3);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	60, '박효신', '남', '811201', '1999.12.01', '대한민국', '솔로'
);
INSERT INTO ARTIST(
	ARTIST_SEQ, ARTIST_NAME, SEX, BIRTH, DEBUT, NATION, GROUP_NAME
)
VALUES(
	61, '장범준', '남', '890516', '2012.03.29', '대한민국', '솔로'
);
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 62,'비밀테이프',29, 7, 3);
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 63,'Aqua Man',30, 8, 2);
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 64,'Always Awake',30, 8, 2);
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 65,'삐삐',31, 9, 6); 
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 66,'가을아침',33, 9, 1); 
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 67,'비밀의 화원',33, 9, 32);
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 68,'어젯밤 이야기',33, 9, 3);
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 69,'하루도 그대를 사랑하지 않은 적이 없었다',34, 10, 1); 
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 70,'노래방',34, 10, 1);  
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 71,'나눠갖지 말아요',34, 10, 1);  
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 72,'주인공',35, 7, 3); 
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 73,'가시나',36, 7, 3);  
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 74,'IDOL',37, 11, 2);  
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 75,'I`m Fine',37, 11, 2);
 INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 76,'Euphoria',37, 11, 2);
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 77,'1도 없어',38, 12, 3);
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 78,'ALRIGHT',38, 12, 3);
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 79,'시간이 들겠지(Feat. Colde)',39, 13, 2); 
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 80,'가을 타나 봐',40, 14, 1); 
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 81,'이별길',41, 15, 3);  
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 82,'내가 모르게',41, 15, 1);   
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 83,'그때 헤어지면 돼',42, 16, 1);  
INSERT INTO MUSIC(
 MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
 84,'모든 날, 모든 순간',43, 17, 1);  
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
85,'사랑에빠졌죠',56, 61, 32);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
86,'빗속으로',56, 61, 32);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
87,'그녀가웃었죠',56, 61, 32);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
88,'이상하다',55, 60, 1);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
89,'Gift',55, 60, 1);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
90,'Beautiful Day (feat.스컬)',55, 60, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
91,'널바라기',55, 60, 1);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
92,'사랑이고프다',55, 60, 1);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
93,'Happy Christmas',55, 60, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
94,' If You Were Me',54, 26, 1);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
95,'좋니',53, 25, 1);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
96,'이방인',52, 24, 1);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
97,'너나 해',51, 23, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
98,'잠이라도 자지',51, 23, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
99,' 여름밤의 꿈',51, 23, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
100,'하늘하늘',51, 23, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
101,' SELFISH(Feat.슬기)',51, 23, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
102,'Dejavu',50, 22, 32);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
103,'6 o`clock',50, 22, 32);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
104,'매트리스',49, 21, 32);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
105,'Power Up',48, 20, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
106,'한 여름의 크리스마스',48, 20, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
107,'Mr. E',48, 20, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
108,'Mosquito',48, 20, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
109,'Hit That Drum',48, 20, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
110,'동화',47, 27, 1);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
111,'바람',47, 27, 1);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
112,'Different Place',47, 27, 1);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
113,'Patience',47, 27, 1);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
114,'아름다운 순간',47, 27, 1);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
115,'가을 안부',46, 28, 1);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
116,'Dance The Night Away',45, 19, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
117,'CHILLAX',45, 19, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
118,'Shot thru the heart',45, 19, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
119,'What is Love?',45, 19, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
120,'HO!',45, 19, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
121,' SWEET TALKER?',45, 19, 1);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
122,' 뚜두뚜두',44, 18, 3);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
123,'  Forever Young',44, 18, 2);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
124,'Really',44, 18, 6);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)
VALUES(
125,'See U Later',44, 18, 6);
INSERT INTO IMG(
 IMG_NAME, EXT, SEQ
)
VALUES
(
'레드벨벳_Summer_Magic','jpg', 48),
('10cm_4_1','jpg', 49),
('볼빨간사춘기_Red_Diary','jpg', 50), 
('마마무_RED_MOON','jpg', 51),
('IU_꽃갈피_둘','jpg', 33),
('IU_삐삐','jpg', 31),
('빈지노_24_26','jpg', 30),
('선미_WARNING','jpg', 29),
('선미_주인공','jpg', 35),
('임창정_하루도_그대를','jpg', 34),
('선미_가시나','jpg',36),
('방탄소년단_LY_Answer','jpg',37),
('에이핑크_ONE_SIX','jpg',38),
('로꼬_시간이들겠지','jpg',39),
('VIBE_가을타나봐','jpg',40),
('IKON_NEW_KIDS','jpg',41),
('박원_이방인','jpg', 52),
('윤종신_좋니','jpg', 53),
('벤_If_You_Were_Me','jpg', 54),
('박효신_Gift','jpg', 55),
('장범준_2집','jpg', 56),
('로이킴_그때_헤어지면_돼','jpg', 42),
('폴킴_키스_먼저_할까요','jpg', 43),
('블랙핑크_SQUARE_UP','jpg', 44),
('트와이스_Summer_Nights','jpg', 45),
('먼데이키즈_가을안부','jpg', 46),
('멜로망스_The_Fairy_Tale','jpg', 47);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_아이유','jpg',9);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_빈지노','jpg',8);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_선미','jpg',7);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_방탄소년단','jpg',11);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_트와이스','jpg',19);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_레드벨벳','jpg',20);
UPDATE ARTIST
SET INTRO1 = 
'장범준은 대한민국의 싱어송라이터이다. 2011년 Mnet "슈퍼스타 K3"에서 준우승 하며 이름을 알린 밴드 버스커버스커의 리더이며, 그룹의 작사, 작곡 편곡을 담당하고 있다. 프로그램 방
영 중에 무대에서 선보인 곡들이 음원으로 엄청난 사랑을 받았는데, 동경소녀 , 막걸리나 , 서울사람들 등의 편곡을 도맡아 하며 팀의 무대를 이끌었다.'
WHERE ARTIST_SEQ LIKE 61;
UPDATE ARTIST
SET INTRO2 = 
'2012년 3월 발표한 [버스커 버스커1집]에 전곡 작사, 작곡으로 참여해 독보적인 인기를 얻었다. 특히 타이틀 곡인 벚꽃 엔딩 은 봄을 상징하는 노래로 회자되며 매년 봄마다 차트에 진입하고 
 있어 "벚꽃연금"이라는 신조어를 만들어내기도 했다. 타이틀 곡 뿐 아니라 수록곡 첫사랑, 여수 밤바다, 외로움증폭장치 등 수록곡 전체가 사랑을 받았으며 장범준 표 음악의 대중성이 증명된 앨
 범이다.
 2014년에 첫 솔로 앨범인 [장범준 1집]을 발표하게 되는데, 버스커 버스커 때의 장난기 있는 모습보다는 가을에 어울리는 감성적인 곡들을 수록했으며, 웹툰과 함께 앨범을 발표하는 독특한 프로
 모션으로 화제가 되기도 했다.'
WHERE ARTIST_SEQ LIKE 61;
UPDATE ARTIST
SET INTRO1 = '독보적인 여성 솔로 아티스트로 자리매김하고 있는 선미는 걸그룹 원더걸스의 멤버로 처음 가수 생활을 시작했다. 2007년 2월 싱글 Irony 로 데뷔하며 안정적인 보컬과 깜찍한 비주얼로 사랑을 받았고, Tell Me 로 신드롬급 열풍을 일으키며 국민 걸그룹의 자리에 올라 So Hot, Nobody 까지 3연속 흥행을 거뒀다.',
	 INTRO2 = '원더걸스 활동 중단 후에는 가수로서의 트레이닝을 꾸준히 병행했다. 활동 중단 선언 3년 후인 2013년에는 싱글 24시간이 모자라 를 통해 멤버들 중 가장 먼저 솔로로 데뷔했다. 이전의 풋풋한 이미지와는 확연히 다른 파격적인 변신으로 발매와 동시에 7개 음원 사이트 1위를 석권하는 센세이션을 일으켰고, 이어 발매한 보름달에서도 콘셉트, 의상, 퍼포먼스 모든 부분에서 화제를 모았다.
원더걸스로 재합류한 이후에도 도전은 계속되었다.
2015년에 발표한 [REBOOT]에서는 앨범 콘셉트에 따라 멤버 개개인의 연주를 담은 티저 영상에서 수준급의 베이스 실력을 뽐내며 화제를 모았다. 연주는 물론 앨범 수록곡의 작사와 작곡에도 적극적으로 참여하며 음악적 성장을 보여준 시기였다. 이는 10주년 기념 싱글인 Why So Lonely 와 해체 직전 발표한 그려줘에서도 이어졌다.
2018년 9월, 선미의 3부작 프로젝트를 모두 담아낸 미니앨범 [WARNING]을 내놓았으며, 전곡 작사, 작곡에 참여해 음악적으로도 더욱 성숙해진 면모를 보였다.'
WHERE ARTIST_SEQ LIKE 7;




INSERT INTO ALBUM(
   ALBUM_SEQ, ALBUM_TITLE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
   126,'LOVE YOURSELF 轉 Tear', '방탄소년단', '힙합'
);
INSERT INTO ALBUM(
   ALBUM_SEQ, ALBUM_TITLE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
   127,'LOVE YOURSELF 承 Her', '방탄소년단', '힙합'
);
INSERT INTO ALBUM(
   ALBUM_SEQ, ALBUM_TITLE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
   128,'YOU NEVER WALK ALONE', '방탄소년단', '힙합'
);
INSERT INTO ALBUM(
   ALBUM_SEQ, ALBUM_TITLE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
   129,'WINGS', '방탄소년단', '힙합'
);
INSERT INTO ALBUM(
   ALBUM_SEQ, ALBUM_TITLE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
   130,'화양연화 Young Forever', '방탄소년단', '힙합'
);
INSERT INTO ALBUM(
   ALBUM_SEQ, ALBUM_TITLE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
   131,'화양연화 pt.2', '방탄소년단', '힙합'
);
INSERT INTO ALBUM(
   ALBUM_SEQ, ALBUM_TITLE, ARTIST_NAME, ALBUM_GENRE
)
VALUES(
   132,'화양연화 pt.1', '방탄소년단', '힙합'
);
UPDATE ALBUM SET 
    AGENCY_NAME = "빅히트엔터테인먼트",
    RELEASE_DATE =  "2018.05.18",
    ALBUM_TYPE = "정규",
    INTRO = "방탄소년단, 정규 3집 LOVE YOURSELF 轉 ‘Tear’ 발매!
사랑을 얻기 위한 거짓은 결국 이별을 만난다!
나 자신을 사랑하는 것이 진정한 사랑의 시작
방탄소년단이 5월 18일 정규 3집 LOVE YOURSELF 轉 ‘Tear’를 발매한다.
방탄소년단의 LOVE YOURSELF 시리즈는 나 자신을 사랑하는 것이 진정한 사랑의 시작이라는 메시지를 담고 있다. 앞서 공개된 LOVE YOURSELF 起 ‘Wonder’ 영상과 LOVE YOURSELF 承 ‘Her’ 앨범이 사랑의 설렘과 두근거림을 표현했다면, 轉 ‘Tear’ 앨범은 이별을 마주한 소년들의 아픔을 담았다."
WHERE ALBUM_SEQ= 126;
UPDATE ALBUM SET 
    AGENCY_NAME = "빅히트엔터테인먼트",
    RELEASE_DATE =  "2017.09.18",
    ALBUM_TYPE = "EP",
    INTRO = "
'방탄소년단'이 9월 18일 새로운 시리즈 LOVE YOURSELF의 첫 앨범 [承 `Her`] 를 발매한다.
[LOVE YOURSELF 承 `Her`는 사랑의 설렘과 두근거림을 '방탄소년단'의 스타일로 해석한 앨범이다. LOVE YOURSELF 시리즈에서 '방탄소년단'이 전달하고자 하는 사랑은 성장하는 소년의 개인적 경험이기도 하지만 방탄소년단이 현재의 우리 사회에 보내는 화해와 통합의 메시지이기도 하다. 그리고 그 첫 시작인 미니앨범 承 [`Her`]에서는 첫사랑에 빠진 소년들의 모습을 청량하고 유쾌하게 담아냄으로써 사랑이라는 주제를 청춘물의 틀 안에서 풀어낸다."
WHERE ALBUM_SEQ= 127;
UPDATE ALBUM SET 
    AGENCY_NAME = "빅히트엔터테인먼트",
    RELEASE_DATE =  "2017.02.13",
    ALBUM_TYPE = "정규",
    INTRO = "방탄소년단, 'YOU NEVER WALK ALONE' 발매! 외전으로 완성된 'WINGS'
'함께라면 웃을 수 있어' 이 시대의 청춘에게 건네는 '위로'와 '희망'의 메시지!
2016년 10월 정규 2집 'WINGS'로 전 세계적인 반향을 일으킨 방탄소년단이 2월 13일 'WINGS 외전: YOU NEVER WALK ALONE'을 발매한다. 
'WINGS 외전'은 방탄소년단이 'WINGS'에 미처 담지 못했던 청춘과 성장의 이야기를 완성한 앨범이다. '화양연화' 시리즈와 'WINGS'가 청춘과 성장에 대한 서사였다면 'WINGS외전'은 이 시대 아픈 청춘들에게 건네는 따뜻한 위로와 희망의 메시지다."
WHERE ALBUM_SEQ= 128;
UPDATE ALBUM SET 
    AGENCY_NAME = "빅히트엔터테인먼트",
    RELEASE_DATE =  "2016.10.10",
    ALBUM_TYPE = "정규",
    INTRO = "소년, 유혹을 만나다! 방탄소년단, 정규 2집 [WINGS] 발매!
타이틀곡 '피 땀 눈물'로 유혹에 빠진 청춘의 갈등과 성장을 담다!
방탄소년단 최초 멤버 전원 솔로곡 수록! 멤버들의 자전적 이야기 담겨!"
WHERE ALBUM_SEQ= 129;
UPDATE ALBUM SET 
    AGENCY_NAME = "빅히트엔터테인먼트",
    RELEASE_DATE =  "2016.05.02",
    ALBUM_TYPE = "정규",
    INTRO = "방탄소년단, 스페셜 앨범 [화양연화 Young Forever] 발매!
인생의 가장 아름다운 순간, '화양연화' 그 마지막 이야기!"
WHERE ALBUM_SEQ= 130;
UPDATE ALBUM SET 
    AGENCY_NAME = "빅히트엔터테인먼트",
    RELEASE_DATE =  "2015.11.30",
    ALBUM_TYPE = "EP",
    INTRO = "방탄소년단, 청춘 2부작의 마침표를 찍다! 미니앨범 [화양연화 pt.2]
뜨겁게 타오르는, 그러나 지나고 나면 한낱 꿈에 불과한 청춘의 순간
그래도 멈출 수 없는 한 줄기 빛을 향한 질주 'RUN'"
WHERE ALBUM_SEQ= 131;
UPDATE ALBUM SET 
    AGENCY_NAME = "빅히트엔터테인먼트",
    RELEASE_DATE =  "2015.04.29",
    ALBUM_TYPE = "EP",
    INTRO = "방탄소년단, 찬란함과 불안이 공존하는 시간! 미니앨범 [화양연화 pt.1]!
방탄소년단, 일렉트로 힙합곡 'I NEED U' 발표! 동양적 멜로디와 힙합의 결합!
'학교 3부작' 마무리한 방탄소년단! 이번엔 '청춘'을 노래! '청춘2부작'의 시작!"
WHERE ALBUM_SEQ= 132;
INSERT INTO IMG( IMG_NAME, EXT, SEQ 
)VALUES(
'방탄소년단_LY_tear','jpg',126
);
INSERT INTO IMG( IMG_NAME, EXT, SEQ 
)VALUES(
'방탄소년단_LY_her','jpg',127
);
INSERT INTO IMG( IMG_NAME, EXT, SEQ 
)VALUES(
'방탄소년단_YNWA','jpg',128
);
INSERT INTO IMG( IMG_NAME, EXT, SEQ 
)VALUES(
'방탄소년단_WINGS','jpg',129
);
INSERT INTO IMG( IMG_NAME, EXT, SEQ 
)VALUES(
'방탄소년단_화양연화_YF','jpg',130
);
INSERT INTO IMG( IMG_NAME, EXT, SEQ 
)VALUES(
'방탄소년단_화양연화_pt2','jpg',131
);
INSERT INTO IMG( IMG_NAME, EXT, SEQ 
)VALUES(
'방탄소년단_화양연화_pt1','jpg',132
);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)VALUES
(133,'FAKE LOVE',126, 11,2),
(134,'전하지 못한 진심 (Feat. Steve Aoki)',126, 11,1),
(135,'Anpanman',126, 11,2),
(136,'Airplane pt.2',126, 11,2);
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)VALUES
(137,'DNA',127, 11,2),
(138,'MIC Drop',127, 11,2),
(139,'고민보다 Go',127, 11,3),
(140,'Best Of Me',127, 11,2)
;
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)VALUES
(141,'봄날',128, 11,2),
(142,'Not Today',128, 11,2),
(143,'Lost',128, 11,2),
(144,'BTS Cypher 4',128, 11,2)
;
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)VALUES
(145,'피 땀 눈물',129, 11,2),
(146,'Am I Wrong',129, 11,2),
(147,'21세기 소녀',129, 11,2),
(148,'둘! 셋! (그래도 좋은 날이 더 많기를)',129, 11,2)
;
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)VALUES
(149,'불타오르네 (FIRE)',130, 11,2),
(150,'Save ME',130, 11,2),
(151,'EPILOGUE : Young Forever',130, 11,2)
;
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)VALUES
(152,'RUN',131, 11,2),
(153,'Butterfly',131, 11,2),
(154,'Whalien 52',131, 11,2),
(155,'뱁새',131, 11,2)
;
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ALBUM_SEQ, ARTIST_SEQ, GENRE_SEQ
)VALUES
(156,'I NEED U',132, 11,2),
(157,'쩔어',132, 11,2),
(158,'흥탄소년단',132, 11,2),
(159,'잡아줘 (Hold Me Tight)',132, 11,2)
;
INSERT INTO ARTICLE( ARTICLE_SEQ, MEMBER_ID, BOARD_SEQ, HASH)
VALUES
('160','sound',1,'2,5,12'),
('161','sound',1,'2,5,11'),
('162','sound',1,'1,10,15'),
('163','sound',1,'1,3,13'),
('164','sound',1,'2,3,7'),
('165','sound',1,'2,4,9'),
('166','sound',1,'13,14,15'),
('167','sound',1,'5,11,14'),
('168','sound',1,'4,6,7'),
('169','sound',1,'1,3,5'),
('170','sound',1,'6,7,8'),
('171','sound',1,'4,12,13'),
('172','sound',1,'4,9,14'),
('173','sound',1,'5,7,11'),
('174','sound',1,'1,2,3'),
('175','sound',1,'4,8,15'),
('176','sound',1,'6,10,11');
INSERT INTO MEMBER(MEMBER_ID,PASS,BIRTH,SEX)
VALUES('pizza','1111','770803','남');
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ARTIST_SEQ, GENRE_SEQ
)VALUES
(177,'CHEER UP', 19,3),
(178,'KNOCK KNOCK', 19,3),
(179,'LIKEY', 19,3),
(180,'Heart Shaker', 19,3),
(181,'TT', 19,3)
;
INSERT INTO MUSIC(
MUSIC_SEQ, MUSIC_TITLE, ARTIST_SEQ, GENRE_SEQ
)VALUES
(182,'빨간 맛 (Red Flavor)', 20,3),
(183,'Bad Boy', 20,3),
(184,'러시안 룰렛 (Russian Roulette)', 20,3),
(185,'Rookie', 20,3),
(186,'Ice Cream Cake', 20,3)
;
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('libero','1111','030901','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('metus','1111','010630','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('tempus','1111','000227','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('mattis','1111','010507','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('turpis','1111','000514','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('tellus','1111','020103','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('magna','1111','000714','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('varius','1111','031004','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('dolor','1111','031027','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('ornare','1111','940108','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('sapien','1111','960209','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('tortor','1111','990207','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('neque','1111','951011','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('mollis','1111','910106','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('auctor','1111','960814','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('enimIn','1111','990220','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('lacus','1111','970706','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('justo','1111','940408','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('tempor','1111','940422','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('risus','1111','830204','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('congue','1111','800629','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('velit','1111','850109','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('massa','1111','860217','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('porta','1111','811019','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('mauris','1111','880513','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('nulla','1111','700904','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('ligula','1111','700327','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('ipsum','1111','741111','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('lorem','1111','721108','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('semper','1111','660712','남');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('felis','1111','690101','여');
INSERT INTO MEMBER (MEMBER_ID,PASS,BIRTH,SEX) VALUES('vitae','1111','660808','여');
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_1', 'jpg', 160 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_3', 'jpg', 161 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_2', 'jpg', 162 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_2', 'jpg', 163 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_3', 'jpg', 164 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_1', 'jpg', 165 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_3', 'jpg', 166 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_3', 'jpg', 167 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_2', 'jpg', 168 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_2', 'jpg', 169 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_2', 'jpg', 170 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_1', 'jpg', 171 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_2', 'jpg', 172 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_3', 'jpg', 173 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_3', 'jpg', 174 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_1', 'jpg', 175 );
INSERT INTO IMG ( IMG_NAME, EXT, SEQ ) VALUE ( 'DJ_IMAGE_1', 'jpg', 176 );
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_임창정','jpg',10);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_에이핑크','jpg',12);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_로꼬','jpg',13);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_바이브','jpg',14);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_아이콘','jpg',15);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_로이킴','jpg',16);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_폴킴','jpg',17);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_블랙핑크','jpg',18);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_10cm','jpg',21);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_볼빨간사춘기','jpg',22);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_마마무','jpg',23);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_박원','jpg',24);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_윤종신','jpg',25);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_벤','jpg',26);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_멜로망스','jpg',27);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_먼데이키즈','jpg',28);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_박효신','jpg',60);
INSERT INTO IMG(IMG_NAME,EXT,SEQ) VALUES('profile_장범준','jpg',61);
UPDATE ARTICLE SET TITLE = '하나 별 밤을 듯합니다', CONTENTS = '97,85,62,96,115,138,76,110,57' WHERE ARTICLE_SEQ LIKE 160 ;
UPDATE ARTICLE SET TITLE = '봄이 소녀들의 멀리 까닭입니다', CONTENTS = '73,92,67,81,101,108' WHERE ARTICLE_SEQ LIKE 161 ;
UPDATE ARTICLE SET TITLE = '보고, 파란 어머니, 시와 있습니다', CONTENTS = '93,74,110,109,115,79,108,89' WHERE ARTICLE_SEQ LIKE 162 ;
UPDATE ARTICLE SET TITLE = '아이들의 무덤 별 흙으로 거외다',  CONTENTS = '120,149,77,139,153,154,80,137,81' WHERE ARTICLE_SEQ LIKE 163 ;
UPDATE ARTICLE SET TITLE = '프랑시스 별이 이런 걱정도 까닭입니다', CONTENTS = '133,151,110,109,102,62,89' WHERE ARTICLE_SEQ LIKE 164 ;
UPDATE ARTICLE SET TITLE = '부끄러운 내린 아침이 버리었습니다',  CONTENTS = '150,78,88,71,152,59,117,81,153,114' WHERE ARTICLE_SEQ LIKE 165 ;
UPDATE ARTICLE SET TITLE = '된 묻힌 가슴속에 마리아 봅니다', CONTENTS = '82,78,125,58,133,92,103,106,142,79' WHERE ARTICLE_SEQ LIKE 166 ;
UPDATE ARTICLE SET TITLE = '새워 지나가는 별 까닭입니다', CONTENTS = '110,106,70,116,67,84,135,64' WHERE ARTICLE_SEQ LIKE 167 ;
UPDATE ARTICLE SET TITLE = '하나에 당신은 묻힌 거외다', CONTENTS = '125,57,151,111,150,88,122,65,80,96' WHERE ARTICLE_SEQ LIKE 168 ;
UPDATE ARTICLE SET TITLE = '이네들은 흙으로 벌레는 시와 까닭입니다',  CONTENTS = '141,133,101,151,83,158,74,137' WHERE ARTICLE_SEQ LIKE 169 ;
UPDATE ARTICLE SET TITLE = '밤이 너무나 둘 이제 그리워 듯합니다', CONTENTS = '88,147,85,120,76,108' WHERE ARTICLE_SEQ LIKE 170 ;
UPDATE ARTICLE SET TITLE = '어머니, 불러 책상을 있습니다',  CONTENTS = '139,114,120,76,156,134,106,68' WHERE ARTICLE_SEQ LIKE 171 ;
UPDATE ARTICLE SET TITLE = '이네들은 사람들의 이런 버리었습니다',  CONTENTS = '68,83,59,66,75,91' WHERE ARTICLE_SEQ LIKE 172 ;
UPDATE ARTICLE SET TITLE = '하나에 소녀들의 별 까닭입니다', CONTENTS = '152,149,150,141,97,147' WHERE ARTICLE_SEQ LIKE 173 ;
UPDATE ARTICLE SET TITLE = '나의 어머님, 위에도 이름자를 봅니다', CONTENTS = '62,96,59,114,139,109,73,97,103' WHERE ARTICLE_SEQ LIKE 174 ;
UPDATE ARTICLE SET TITLE = '하나에 무덤 덮어 풀이 써 봅니다',  CONTENTS = '81,147,110,109,123,116,137,139,90' WHERE ARTICLE_SEQ LIKE 175 ;
UPDATE ARTICLE SET TITLE = '책상을 하나에 마리아 릴케 까닭입니다',  CONTENTS = '135,138,141,134,102,71,107,133' WHERE ARTICLE_SEQ LIKE 176 ;
INSERT INTO COMMENT(MEMBER_ID,SEQ_GROUP,MSG) VALUES('shin',30,'지노형 얼른 전역하세요ㅠㅠ');
INSERT INTO COMMENT(MEMBER_ID,SEQ_GROUP,MSG) VALUES('신난 튜브',-1,'아이유 삐삐 들으면 들을수록 좋다~!');
INSERT INTO COMMENT(MEMBER_ID,SEQ_GROUP,MSG) VALUES('감동받은 네오',-1,'박효신 FOREVER');
INSERT INTO COMMENT(MEMBER_ID,SEQ_GROUP,MSG) VALUES('감동받은 어피치',-1,'방탄 지붕뚫고 가즈아~');
INSERT INTO COMMENT(MEMBER_ID,SEQ_GROUP,MSG) VALUES('졸린 네오',-1,'IDOL 인생 명곡');
INSERT INTO MV ( MV_SEQ,
 MV_TITLE,
 MUSIC_SEQ,
 RELEASE_DATE,
 ytb)
 VALUES(
 	187,
 	'사이렌',
 	57,
 	'2018.09.04',
 	'https://www.youtube.com/embed/TNWMZIf7eSg'
 );
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   188,
   '가시나',
   73,
   '2017.08.22',
   'https://www.youtube.com/embed/ur0hCdne2-s'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   189,
   'Aqua Man',
   63,
   '2017.07.11',
   'https://www.youtube.com/embed/8nq32TQBwXI'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   190,
   '삐삐',
   65,
   '2018.10.10',
   'https://www.youtube.com/embed/nM0xDI5R50E'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   191,
   '어젯밤 이야기',
   68,
   '2017.09.22',
   'https://www.youtube.com/embed/cxcxskPKtiI'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   192,
   '하루도 그대를 사랑하지 않은 적이 없었다',
   69,
   '2018.09.19',
   'https://www.youtube.com/embed/Xaqpvy-ZbMg'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   193,
   'IDOL',
   74,
   '2018.08.24',
   'https://www.youtube.com/embed/pBuZEGYXA6E'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   194,
   '1도 없어',
   77,
   '2018.07.02',
   'https://www.youtube.com/embed/F4oHuML9U2A'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   195,
   '시간이 들겠지(Feat. Colde)',
   79,
   '2018.10.08',
   'https://www.youtube.com/embed/YfQzz00Oc_M'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   196,
   '이별길',
   81,
   '2018.10.01',
   'https://www.youtube.com/embed/2O6dRaBbFoo'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   197,
   '내가 모르게',
   82,
   '2018.10.01',
   'https://www.youtube.com/embed/nQJx28w-yb4'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   198,
   '그때 헤어지면 돼',
   83,
   '2018.02.12',
   'https://www.youtube.com/embed/SkN_hWI6n28'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   199,
   '빗속으로',
   86,
   '2016.03.25',
   'https://www.youtube.com/embed/h2etWUFzURw'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   200,
   '사랑이고프다',
   92,
   '2010.12.13',
   'https://www.youtube.com/embed/vnFyo1eEYqw'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   201,
   'If You Were Me',
   94,
   '2018.09.23',
   'https://www.youtube.com/embed/e_ZNkheaMiw'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   202,
   '좋니',
   95,
   '2017.06.22',
   'https://www.youtube.com/embed/jy_UiIQn_d0'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   203,
   '이방인',
   96,
   '2018.08.13',
   'https://www.youtube.com/embed/FcxEI4v8ASY'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   204,
   '너나 해',
   97,
   '2018.07.16',
   'https://www.youtube.com/embed/pHtxTSiPh5I'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   205,
   '잠이라도 자지',
   98,
   '2018.07.16',
   'https://www.youtube.com/embed/BVbvoQQI6as'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   206,
   'Dejavu',
   102,
   '2018.07.17',
   'https://www.youtube.com/embed/LebzXsLFwaM'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   207,
   '매트리스',
   104,
   '2018.08.23',
   'https://www.youtube.com/embed/seNNCbiXTSY'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   208,
   'Power Up',
   105,
   '2018.08.06',
   'https://www.youtube.com/embed/aiHSVQy9xN8'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   209,
   '한 여름의 크리스마스',
   106,
   '2018.08.06',
   'https://www.youtube.com/embed/2gIy65zbG-8'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   210,
   '동화',
   110,
   '2018.07.03',
   'https://www.youtube.com/embed/FoYyqHqbnxc'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   211,
   '바람',
   111,
   '2018.07.03',
   'https://www.youtube.com/embed/4SNuqpHjRPQ'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   212,
   '가을 안부',
   115,
   '2017.10.14',
   'https://www.youtube.com/embed/rGVRvhm7ddk'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   213,
   'Dance The Night Away',
   116,
   '2018.07.09',
   'https://www.youtube.com/embed/Fm5iP0S1z9w'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   214,
   'What is Love?',
   119,
   '2018.04.09',
   'https://www.youtube.com/embed/i0p1bmr0EmE'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   215,
   '뚜두뚜두',
   122,
   '2018.06.15',
   'https://www.youtube.com/embed/IHNzOHi8sJs'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   216,
   'Forever Young',
   123,
   '2018.06.15',
   'https://www.youtube.com/embed/89kTb73csYg'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   217,
   'See U Later',
   125,
   '2018.06.15',
   'https://www.youtube.com/embed/MZuxtzdVVzQ'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   218,
   'FAKE LOVE',
   133,
   '2018.05.18',
   'https://www.youtube.com/embed/7C2z4GqqS5E'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   219,
   'DNA',
   137,
   '2017.09.18',
   'https://www.youtube.com/embed/MBdVXkSdhwU'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   220,
   'MIC Drop',
   138,
   '2017.09.18',
   'https://www.youtube.com/embed/kTlv5_Bs8aw'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   221,
   'Not Today',
   142,
   '2017.02.13',
   'https://www.youtube.com/embed/9DwzBICPhdM'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   222,
   'CHEER UP',
   177,
   '2016.04.25',
   'https://www.youtube.com/embed/c7rCyll5AeY'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   223,
   'KNOCK KNOCK',
   178,
   '2017.02.20',
   'https://www.youtube.com/embed/8A2t_tAjMz8'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   224,
   'TT',
   181,
   '2016.10.24',
   'https://www.youtube.com/embed/ePpPVE-GGJw'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   225,
   'LIKEY',
   179,
   '2017.10.30',
   'https://www.youtube.com/embed/V2hlQkVJZhE'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   226,
   '빨간 맛 (Red Flavor)',
   182,
   '2017.07.09',
   'https://www.youtube.com/embed/WyiIGEHQP8o'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   227,
   '러시안 룰렛 (Russian Roulette)',
   184,
   '2016.09.07',
   'https://www.youtube.com/embed/QslJYDX3o8s'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   228,
   'Rookie',
   185,
   '2017.02.01',
   'https://www.youtube.com/embed/J0h8-OTC38I'
);
INSERT INTO MV ( MV_SEQ,
MV_TITLE,
MUSIC_SEQ,
RELEASE_DATE,
ytb)
VALUES(
   229,
   'Ice Cream Cake',
   186,
   '2015.03.17',
   'https://www.youtube.com/embed/glXgSSOKlls'
);
INSERT INTO UPDOWN(MEMBER_ID,SEQ_GROUP,SG_ELEMENT,TYPES) 
VALUES
('sound',108,'music','u'),
('sound',122,'music','u'),
('sound',119,'music','u'),
('sound',116,'music','u'),
('sound',59,'music','u'),
('sound',73,'music','u'),
('sound',57,'music','u'),
('sound',77,'music','u');
INSERT INTO UPDOWN(MEMBER_ID,SEQ_GROUP,SG_ELEMENT,TYPES) 
VALUES
('sound',3,'genre','u'),
('sound',3,'genre','u'),
('sound',3,'genre','u'),
('sound',3,'genre','u'),
('sound',3,'genre','u'),
('sound',3,'genre','u'),
('sound',3,'genre','u'),
('sound',3,'genre','u');
INSERT INTO UPDOWN(MEMBER_ID,SEQ_GROUP,SG_ELEMENT,TYPES) 
VALUES
('sound',66,'music','u'),
('sound',89,'music','u'),
('sound',84,'music','u'),
('sound',95,'music','u'),
('sound',69,'music','u');
INSERT INTO UPDOWN(MEMBER_ID,SEQ_GROUP,SG_ELEMENT,TYPES) 
VALUES
('sound',1,'genre','u'),
('sound',1,'genre','u'),
('sound',1,'genre','u'),
('sound',1,'genre','u'),
('sound',1,'genre','u');
INSERT INTO UPDOWN(MEMBER_ID,SEQ_GROUP,SG_ELEMENT,TYPES) 
VALUES
('sound',79 ,'music','u'),
('sound',64 ,'music','u'),
('sound',123 ,'music','u'),
('sound',63 ,'music','u');
INSERT INTO UPDOWN(MEMBER_ID,SEQ_GROUP,SG_ELEMENT,TYPES) 
VALUES
('sound',2 ,'genre','u'),
('sound',2 ,'genre','u'),
('sound',2 ,'genre','u'),
('sound',2 ,'genre','u');
INSERT INTO UPDOWN(MEMBER_ID,SEQ_GROUP,SG_ELEMENT,TYPES) 
VALUES
('sound',124  ,'music','u'),
('sound',65  ,'music','u'),
('sound',125  ,'music','u');
INSERT INTO UPDOWN(MEMBER_ID,SEQ_GROUP,SG_ELEMENT,TYPES) 
VALUES
('sound',6  ,'genre','u'),
('sound',6  ,'genre','u'),
('sound',6  ,'genre','u');
INSERT INTO UPDOWN(MEMBER_ID,SEQ_GROUP,SG_ELEMENT,TYPES) 
VALUES
('sound',11  ,'artist','u');
INSERT INTO UPDOWN(MEMBER_ID,SEQ_GROUP,SG_ELEMENT,TYPES) 
VALUES
('sound',19  ,'artist','u');
INSERT INTO UPDOWN(MEMBER_ID,SEQ_GROUP,SG_ELEMENT,TYPES) 
VALUES
('sound',20 ,'artist','u');
UPDATE ARTIST
SET INTRO1 = '빈지노 (Beenzino)는 대한민국의 래퍼이다. 프로젝트 팀 Hot Clip과 Jazzyfact의 활동을 통해 가요계에 진출했고, 2011년 일리네어 레코즈에 입단하며 본격적인 행보를 이어갔다.
2012년 7월에 발표한 첫 EP [2 4 : 2 6]가 폭발적인 반응을 얻었으며, 힙합 앨범으로는 기록적인 판매량을 기록하면서 힙합 신의 주목을 받기 시작했다.',
    INTRO2 = '2014년에는 미니 앨범 [Up All Night]을 공개, "자신감 넘치고 예술을 사랑하는 남자"를 모티브로 삼으며 유니크한 음악들을 선보였다.
이어 싱글 어쩌라고(So What), Life In Color 등을 연이어 발표했으며, 2016년 5월에는 장기간 심혈을 기울여 만든 첫 정규앨범 [12]로 컴백했다.
이 앨범 역시 대중의 찬사를 받았고, 탁월한 실력을 인정받으며 국내에서 가장 영향력 있는 래퍼로 자리매김하고 있다.'
WHERE ARTIST_SEQ LIKE 8;
UPDATE ARTIST
SET INTRO1 = '아이유는 카카오M과 페이브 엔터테인먼트에 소속된 대한민국의 가수이다. "I"와"You"의 합성어로"너와 내가 음악으로 하나가 된다"는 의미의 이름으로 2008년 데뷔했다.
미니 앨범 [Lost And Found]으로 윤상을 비롯 유희열, 휘성 같은 선배 가수들에게 인정을 받은 그는 이후 이전에 발표한 미니 앨범의 트랙을 포함 시킨 정규 풀 앨범 [Growing Up]을 통해 앳되고 귀여운 타입의 콘셉트로 활동을 시작한다.',
    INTRO2 = '본인이 직접 프로듀싱 한 앨범 [CHAT-SHIRE]을 발매하며 한 단계 성숙해진 가수이자 아티스트로서 호평을 받았고, 화제를 모았다.
정규 4집 [Palette] 선공개 곡으로 발표된 밤편지는 앨범 내 가장 아끼는 곡이라고 말하기도 했고, 이 곡으로 골든디스크 시상식에서 음원 대상을 받았다.
대세 아티스트 오혁과 컬래버레이션 사랑이 잘 로 2017년 4월 월간 차트 1위를 차지하는 등의 성과를 거둔데 이어 정식 발매된 [Palette]는 멜론에서 역대 제일 많이 스트리밍 된 음반 1위를 차지하며 멜론 뮤직 어워드 앨범상을 수상, 빌보드가 선정한 올해의 K-POP 앨범 부문 TOP 1위에 오르는 기염을 토했다.
2017년 가을, 두 번째 리메이크 앨범 [꽃갈피 둘]을 발매하며, 공개하자마자 1위를 차지하는 위력을 보여주었고, 한국 대중음악상, 가온차트 뮤직 어워드에서도 아티스트로서의 능력을 인정받았다.
이듬해 10월에는 데뷔 10주는 디지털 싱글 삐삐 를 통해 Alternative R&B 스타일의 새로운 스타일을 입었으며, 발매 즉시 모든 음원 차트 1위에 오르는 음원 퀸의 저력을 보여주었다.'
WHERE ARTIST_SEQ LIKE 9;
UPDATE ARTIST
SET INTRO1 = '임창정은 가수와 예능인, 배우로서 모두 일정 수준의 성공을 거둔 만능 엔터테이너다. 출발은 영화배우였지만 곧 가수로도 성공하였으며 예능 프로그램에서도 발군의 재능을 뽐내며 1990년대와 2000년대 최고의 멀티 엔터테이너 연예인으로 활동했다.
현재도 연기와 음악을 병행하며 좋은 성적을 거두고 있다. 가녀린 미성의 발라드 곡을 주로 하는 임창정의 음악 세계다.',
    INTRO2 = '2009년 3월 10일, 임창정 표 발라드 오랜만이야 를 타이틀로 한 그의 음악계 컴백 앨범 [Return To My World]가 발매되었다. 소주 한 잔 의 작곡가 이동원의 작품인 오랜만이야 는 오랜만의 컴백에 힘을 실어주었지만 긴 공백기로 인해 기대한 만큼의 성적을 내지는 못했다.
임창정은 그 해 뮤지컬 "빨래"에 출연하였고, 이듬해 뮤지컬 "라디오스타"에 출연하는 등 음악적으로 다시금 기지개를 켜기 시작했다. 2014년 정규 12집 [흔한 노래……. 흔한 멜로디]를 발매하여 정석적인 발라드 곡 흔한 노래 는 발라드 장인 임창정의 매력을 대중에게 다시 한 번 어필한 곡이었다.
영화와 음악계에서 종횡무진 활동하던 2015년, 소주 한 잔 같은 히트곡이 탄생한다. 임창정의 첫 미니 앨범 [또다시 사랑]의 타이틀곡 또다시 사랑은 임창정이 직접 작사 작곡해 깊은 감성을 담았으며,
"히든싱어 시즌4" 방송 이후 역주행을 시작해 음원 차트 1위를 차지했다. 2015년 9월에 발매되어 차트 반영 기간이 3개월이었음에도 불구하고 멜론 연간 차트 11위를 기록하기도 했다. 흥행에 이어 이듬해인 2016년 발표된 신곡 내가 저지른 사랑이 발매하자마자 음원 차트 1위에 랭크되었고, 엄청난 고음에도 흔들리지 않는 라이브 실력을 선보였다.
2018년 9월, [하루도 그대를 사랑하지 않은 적이 없었다]를 발표, 동명의 타이틀곡으로 발매 직후 음원 차트 최상위권에 진입해 변하지 않은 영향력을 증명했다.'
WHERE ARTIST_SEQ LIKE 10;
UPDATE ARTIST
SET INTRO1 = '가요계의 새로운 역사를 쓰고 있는 그룹 방탄소년단은 데뷔 이후 끊임없는 성장세를 보여주는 것은 물론, 빌보드 진입 기록을 갱신하며 K-POP을 대표하는 아티스트로 한국을 넘어 세계의 기록을 세우는 행보를 이어가고 있다.
7인조로 이루어진 보이 그룹 방탄소년단은 뛰어난 보컬과 랩, 댄스 실력은 물론 매 앨범마다 작사, 작곡과 프로듀싱에까지 이름을 올리는 실력파 그룹으로 트렌드를 반영한 곡을 선보이며 성장한 모습을 기대하게 한다. 그룹은 2013년 6월 학교 3부작 시리즈의 시작인 [2 COOL 5 SKOOL]로 데뷔했다.',
    INTRO2 = '이후 발매된 다섯 번째 미니앨범 [LOVE YOURSELF 承`Her`]은 국내 차트 1위 등극, 빌보드 앨범 차트 7위에 오르며 한국 가수 최고 순위이자 아시아 최고 신기록을 세웠으며, 타이틀 곡 DNA는 빌보드 HOT 67위에 랭크되었다. 이 앨범으로 멜론 뮤직 어워드를 비롯한 국내 주요 4개의 대상을 모두 석권했고, 아메리칸 뮤직 어워드에 퍼포머로 초청받아 성공적인 무대를 치뤘다.
2017년 12월, 발표만으로 화제가 된 월드 DJ Steve Aoki와의 컬래버레이션 MIC Drop 의 리믹스 버전은 빌보드 HOT 100 28위에 오르는 위엄을 펼쳤고, 팀의 자체기록을 경신하며 한국의 대표 아이돌로서의 행보를 이어가고 있다.
2018년 5월 18일 [LOVE YOURSELF 轉‘Tear]를 발매했으며, FAKE LOVE 의 첫 무대는 미국 라스베이거스에서 열린 "빌보드 뮤직 어워드"에서 공개됐으며, 2년 연속 "톱 소셜 아티스트" 부문을 수상했다. 화제에 이어 대한민국 가수 최초로 빌보드 앨범 차트 1위,
싱글 차트 10위에 올랐으며 뮤직비디오는 8일만에 1억뷰에 도달해 전 세계 역대 뮤직비디오 최단 기록 7위에 올랐다.
2018년 8월, LOVE YOURSELF의 마지막 시리즈의 대미를 장식할 [LOVE YOURSELF 結`Answer`]을 발매, 방탄소년단만이 할 수 있는 국악과 트랩 그루브, EDM을 믹스했으며, 발매 직후 국내 주요 음원 사이트 1위에 올랐다.'
WHERE ARTIST_SEQ LIKE 11;
UPDATE ARTIST
SET INTRO1 = 'Apink(에이핑크)는 2011년 7인조로 데뷔하였다. 리더 박초롱, 윤보미, 정은지, 손나은, 김남주, 오하영, 홍유경으로 구성되었다. 데뷔 전 티저를 순차적으로 공개하며 많은 이들의 관심을 모은 Apink는 첫 EP 음반 [Seven Springs of Apink]을 발매하며 몰라요 를 타이틀곡으로 내세웠다.
몰라요 는 슈퍼창따이가 프로듀싱을 도맡은 곡으로 현악기와 브라스 세션이 곡의 사운드를 이끌어나가며 소녀의 사랑스러운 분위기를 표현했고, 아직은 앳되고 풋풋한 Apink 멤버들의 목소리로 귀여움을 더했다.',
    INTRO2 = 'Apink는 같은 해 11월 두 번째 EP 음반 [Snow Pink]를 발매했다. 이 음반의 타이틀 곡 My My 로 데뷔 후 처음으로 음악 방송 1위를 수상했고, 엠넷 아시안 뮤직 어워드에서 여자 신인상을 차지하며 그룹의 밝은 시작을 알렸다. 2012년 5월에는 첫 정규 음반 [UNE ANNEE]를 발매,
타이틀곡 HUSH 는 그동안 내세웠던 순수한 소녀의 이미지에서 벗어나 복고 디스코 풍의 곡으로 새로운 매력을 선보였다.
NoNoNo 의 여세를 몰아 2014년 4월, 네 번째 미니 음반 [Pink Blossom]을 발매하였다. 타이틀곡 Mr. Chu 는 프로듀서 이단옆차기가 작사 및 작곡을 맡은 팝 댄스곡으로 듣기 편한 멜로디와 펑키한 베이스 라인, 브라스의 사용 등이 돋보인다. 또한 각종 음원 차트에서 상위권을 놓치지 않았고, 공중파 및 케이블 음악방송에서 1위를 수상하며 그랜드슬램을 달성하였다.
11월에는 [Pink LUV]를 발매, 타이틀곡 LUV 가 음악 방송 1위를 차지했으며, "쇼! 음악중심" 최초로 5주 연속 1위라는 기록을 세우기도 했다.
2016년 9월 세 번째 정규 앨범 [Pink Revolution]의 타이틀곡 내가 설렐 수 있게 를 발표했다. 아이돌 그룹 대부분이 위기를 겪는 데뷔 7년차에 소속사와의 재계약을 알린 Apink는 2017년 6월 미니앨범 [Pink UP]의 Five로 활동을 이어나갔고, 2018년 7월에는 과감한 변화를 선보인 7번째 미니앨범 [ONE & SIX]를 공개했다.'
WHERE ARTIST_SEQ LIKE 12;
UPDATE ARTIST
SET INTRO1 = '로꼬는 힙합 레이블 AOMG 소속된 대한민국의 래퍼이다. "쇼미 더 머니 시즌1"의 초대 우승자로 더블케이와 함께한 Home 으로 데뷔했으며, 방송 종료 후 최종 공연 곡인 See The Light 를 발매했다.',
    INTRO2 = 'AOMG로 이적 후 첫 EP [LOCOMOTIVE]를 발매했다. 2017년 5월 첫 정규 앨범 [BLEACHED]을 발표했으며 타이틀 곡 지나쳐 가 실시간 음원 차트 1위에 랭크되었다. 또한 그레이와 함께 피처링으로 참여한 우원재의 시차 가 음원 사이트 주간 차트 1위에 올랐다.
음악 예능 프로그램 "건반 위의 하이에나"에서 화사와 함께한 듀엣 곡 주지마 로 주간 차트 1위를 차지한 바 있다. 이후 박재범, 사이먼 도미닉, GRAY와의 합작 뒤집어버려 와 EXO 백현과 호흡을 맞춘 YOUNG , 그리고 싱글 시간이 들겠지 를 발표했다.'
WHERE ARTIST_SEQ LIKE 13;
UPDATE ARTIST
SET INTRO1 = '바이브는 윤민수, 류재현 2인조로 구성된 대한민국의 보컬 그룹이다. 본래 윤민수. 류재현, 유성규의 3인조 그룹이었으나 유성규가 솔로 활동을 위해 탈퇴함으로서 2인조 그룹이 되었다.
2000년대 중반 SG 워너비, 먼데이키즈 등 R&B 발라드 그룹의 유행을 이끌었으며 현재까지 활동을 이어가고 있는 보컬 그룹이기도 하다.',
    INTRO2 = '윤민수는 본래 남성 보컬 그룹 포맨의 멤버였다. 1998년 포맨의 한현희, 정세영, 이정호와 함께 1기 멤버로서 활동하였으며, 같은 해 [Four Man First Album]을 발매함으로서 가요계 데뷔를 이뤘다.
포맨은 당시 전 세계적으로 유행하던 발라드 보이 그룹의 음악 스타일을 따랐으며, 미국의 유명 보컬 그룹 Boyz II Man이나 보이 그룹 Backstreet Boys, 98 Degrees 등의 음악을 연상케 한다는 평을 받았다. 타이틀곡 나보다 더 나를 사랑한,
나만의 너 등이 수록되어있다. 이후 애절한 분위기 대신 전자음과 힙합 비트를 적극적으로 사용한 두 번째 정규 앨범 [이렇게 천일 동안 모으면 이별이 사라진다고 했다]를 2000년 발표했다. 강렬한 전자음과 보컬이 어우러진 꽃잎 과 Sad Song  등으로 활동을 이어갔다.
이 앨범을 마지막으로 윤민수는 포맨을 떠나 새로운 보컬 그룹 바이브에 합류하게 된다.
2011년 멤버 윤민수가 MBC 음악 경연 프로그램 "나는 가수다"에 출연하여 인지도를 쌓았다. 이후 2012년 데뷔 10주년을 맞아 [Vibe 10th Anniversary Live Edition] 스페셜 앨범을 발매하였고, 2013년에는 어쿠스틱 사운드를 담은 [Organic Sound]를 발매하며 꼭 한번 만나고 싶다 를 히트시켰으며,
 이듬해 2014년 2월에는 정규 6집 [Ritardando]를 통해 두 남자의 이야기를 이어갔다.'
WHERE ARTIST_SEQ LIKE 14;
UPDATE ARTIST
SET INTRO1 = 'B.I, 김진환, 송윤형, BOBBY, 김동혁, 구준회, 정찬우 이상 7명으로 구성된 iKON은 icon과 Korea 의 합성어로 한국의 아이콘이 되라는 의미를 갖고 있다. 힙합을 기반으로 한 다양한 장
르의 곡들을 선보일 뿐 아니라 그룹의 전체적인 이미지와는 상반된 부드럽고 섬세한 매력까지 보여주며 새로운 한류 문화를 만들어가고 있다. 첫 등장은 아이돌 데뷔 서바이벌 프로그램 "WIN - Who Is Next?"였다.',
    INTRO2 = '데뷔와 동시에 국내외에서 많은 사랑을 받은 그룹이 다시 한 번 화제가 된 것은 공연 기록이다. 해외 아티스트 사상 최단 기록 일본 돔 투어를 개최한 것을 시작으로 일본과 대만, 중국, 홍
콩, 인도네시아 등 아시아를 투어하며 상당한 수의 팬들을 끌어모았고, 티켓 추가 요청에 따라 공연을 추가하는 에피소드까지 있었으니, 해외에서까지 대형 신인임을 증명한 셈이다.
2018년 1월, 두 번째 정규 앨범 [Return]을 발매하며 국내에 컴백했고, 발매 직후 타이틀곡 사랑을 했다 가 음원 차트 1위를 석권했다. 급기야 모든 차트 실시간 1위를 넘어 일간 차트 1위를 줄 세우며 "퍼펙트 올킬"을 기록했는데,
이는 단순히 아이돌이 팬덤으로 이룬 결과가 아니라 대중들에게 음악성을 인정받아 입소문이 퍼지며 세운 기록이라는 점에서 화제를 모으며 iKON의 대중성을 증명한 계기였다. 같은 해 8월에는 새 미니앨범 [NEW KIDS : CONTINUE]로 컴백했으며,
2개월 후 [NEW KIDS : THE FINAL]을 발표해 차트 정상과 함께 NEW KIDS 시리즈의 마침표를 찍었다.'
WHERE ARTIST_SEQ LIKE 15;
UPDATE ARTIST
SET INTRO1 = '"슈퍼스타K 시즌4" 우승자 출신 싱어송라이터 로이킴은 본명 김상우로 한국 본토 출신 가수이다. 어려서부터 여러 악기를 배우며 음악을 접해온 그는 중학교 시절 기타 연주를 시작하면서
 본격적으로 가수의 꿈을 키웠다. 중학교 졸업 즈음 미국으로 떠나 그곳에서 고교시절을 보내며 노래 동아리를 운영하고, 유튜브에 자작곡을 올리는 등 다양한 음악 활동을 통해 실력을 쌓았다.
 대학 입학을 앞두고 참가한 오디션 프로그램 "슈퍼스타K 시즌4"는 그의 삶을 바꿔준 프로그램이었다.',
    INTRO2 = '이듬해 4월, 포크 음악의 정서가 담긴 봄봄봄 으로 데뷔, 발매 직후 음원차트 1위에 올랐다. 2013년 6월에 발매한 정규 앨범[Love Love Love]는 전곡을 자작곡으로 채우며 싱어송라이터로서
의 가능성을 보인 작품이었다. 계절감을 담은 포크 음악과 짙은 감성 발라드가 특기인 그는 이어진 두 번째 정규앨범 [HOME]에서 가을의 감성포크를 선보이는가 하면, 세 번째 정규앨범[북두칠성]에서는
겨울에 어울리는 농후한 발라드로 외로운 남자의 감성을 표현했다.
로이킴의 히스토리에서 OST를 빼놓을 수 없다. 데뷔와 동시에 발매된 "응답하라1994"의 서울 그곳은 으로 OST계의 블루칩으로 떠오르며 본격적인 커리어를 쌓아갔다. "피노키오"의 피노키오 , "두번째 스무살"의
날 사랑하지 않는다 , "또 오해영"의 어쩌면 나 는 OST에서 그의 존재감을 강하게 드러낸 보석 같은 기회였다. 특히 2017년을 강타한 드라마 "도깨비"에서는 극 중 주인공의 데이트 신을 장식한 HEAVEN 으로 방영
직후 시청자들의 음원 문의를 부르며 그 어느 때보다 열광적인 사랑을 받았다.
어느덧 6년차 가수가 된 로이킴은 2018년 한 해를 맞이하는 첫 곡으로 자작곡 그때 헤어지면 돼 발매했으며, 발매 직 후 차트를 점령하며 명실상부한 음원 강자로 활동하고 있다.'
WHERE ARTIST_SEQ LIKE 16;
UPDATE ARTIST
SET INTRO1 = '폴킴은 뉴런 뮤직에 소속된 대한민국의 싱어송라이터다. 2014년 싱글 커피 한 잔 할래요 로 데뷔했다.
EP [Song Diary], [Her]을 발매했으며, 2017년 9월 멜로망스와 함께 출연한 "유희열의 스케치북"을 통해 인지도가 급 상승했다.',
    INTRO2 = '2017년 9월에 정규 앨범 Part 1 [길]을, 2018년 1월에 정규 앨범 Part 2 [터널]을 발매했다.'
WHERE ARTIST_SEQ LIKE 17;
UPDATE ARTIST
SET INTRO1 = 'BLACKPINK (블랙핑크)는 YG엔터테인컨트에 소속되어 있는 대한민국의 4인조 걸그룹이다. 2016년 8월 싱글 [SQUARE ONE]으로 데뷔했으며
타이틀 곡인 휘파람 이 음원 사이트 주간 차트에 2주 연속1위로 랭크되었다.',
    INTRO2 = '2016년 11월 두 번째 싱글 [SQUARE ONE]이 발매되었고 2017년 6월[마지막처럼]으로 활동했으며, 2018년 이전의 싱글들과 새 노래인 뚜두뚜두 를 포함한 EP [SQUARE UP]이 발표되었다.

[수상이력]
제7회 가온 차트K-POP 어워드 | 월드루키상
2017 하이원 서울가요대상 | 본상
2017 골든디스크 어워즈 | 음원 본상
제6회 가온 차트K-POP 어워드 | 올해의 신인상
2016 하이원 서울가요대상 | 신인상
2016 골든디스크 어워즈 | 음원 신인상
2016 Mnet Asian Music Awards | 베스트 뮤직비디오
2016 MelOn Music Awards | 신인상
2016 제1회 아시아 아티스트 어워즈 | 신인상'
WHERE ARTIST_SEQ LIKE 18;
UPDATE ARTIST
SET INTRO1 = '데뷔와 동시에 정상급 위치로 발돋움 한 9인조 걸그룹 TWICE는 눈으로 한 번, 귀로 두 번 감동을 준다는 당찬 포부를 가진 걸그룹이다. 이들은 데뷔와 동시에 발매한 모든 싱글이 차트 최
상단에 위치한 것은 물론, 다양한 콘셉트를 소화하며 대중적 사랑을 받고 있다. 오디션 프로그램 "Sixteen" 선발 멤버로 구성된 TWICE는 2015년 10월 OOH-AHH하게 로 데뷔 후
음원 차트 최상위권 랭크 및 폭발적인 성장세를 보이며 대형 신인의 탄생을 알렸다.',
    INTRO2 = '두 번째 EP [PAGE TWO]에서는 한층 밝은 에너지를 담은 Cheer Up 으로 모든 방송사와 음원 차트 1위를 석권했고, 멜론 주간 TOP 10에 17주 연속 랭크되는 등 신인 그룹으로서 놀라운
기록을 세웠다. 특히 이 곡은 2016년 멜론 연간 차트 1위에 오르며 TWICE를 명실상부한 대세 걸그룹으로 이끌었다. 그 해 말 발매한 세 번째 EP [TWICEcoaster : LANE 1] 수록곡
TT 의 뮤직비디오는 공개 하루 만에 500만 뷰를 기록했으며, 제37회 "골든디스크" 디지털 음원 대상을 수상했다.
이듬해 2월 첫 번째 단독 콘서트 겸 투어 "TWICE LAND –The Opening"을 성공적으로 개최하였고, 스페셜 앨범 타이틀곡 Knock Knock 과 이어 발매한 Signal 역시 멜론 주간 차
트에 3주 연속 1위를 차지하며 히트곡의 대열에 올랐다. 2017년 10월 발매한 첫 정규앨범 [Twicetagram] 타이틀곡 LIKEY 의 뮤직비디오는 오픈 33일 만에 유튜브 조회 수 1억을 돌파
하면서 대한민국 여성 가수 최단 기록을 세웠다. 이어 발매한 리패키지 앨범[Merry & Happy]의 Heartshaker 과 2018년 4월 발표한 What is Love? 까지 멜론 주간 차트 1위에
올라 흥행에 성공하면서 대한민국 최고의 걸그룹으로 자리매김했다.
2018년 7월에는 두 번째 스페셜 앨범 [Summer Nights]을 공개, 무더위를 가시게 할 청량한 분위기의 밝은 에너지를 담아냈다.'
WHERE ARTIST_SEQ LIKE 19;
UPDATE ARTIST
SET INTRO1 = 'Red Velvet (레드벨벳)은 강렬하고 매혹적인 레드와 여성스럽고 부드러운 벨벳 의 이미지에서 연상되듯, 색깔 있고 세련된 음악과 퍼포먼스로 전 세계를 매료시키겠다는 포부를 가진
걸그룹이다. 레드와 벨벳 콘셉트를 번갈아 선보인 독특한 전략으로 글로벌 팬들에게 큰 사랑을 받고 있다. 메인 보컬인 웬디, 리드보컬 슬기, 서브보컬 조이, 랩 파트를 맡고 있는 아이린
과 예리까지 총 5명으로 구성된 레드벨벳은 전원 오디션 연습생 출신에 노래, 랩, 춤이 가능한 실력파그룹이다.',
    INTRO2 = '2014년, 데뷔 2주 만에 음악방송 정상에 선 첫 싱글 행복(Happiness) 을 시작으로 선배 걸그룹 S.E.S의 원작을 커버한 Be Natural 마저 정상권에 올리며 가요계를 이끌 특급
신인으로 주목받았다. 이들은 성공적 데뷔 시즌의 성과를 바탕으로 "골든디스크", "서울가요대상"에서 신인상을 받으며 차세대 걸그룹으로서의 입지를 확고히 다졌다.
2015년 예리를 영입, 5인조로 발표한 EP [Ice Cream Cake]는 레드와 벨벳의 느낌을 한 작품에 녹이며 반전 매력을 선보였다. 예능 프로그램 출연을 병행하는 등 만능 엔터테이너의
모습을 보여주기 시작한 것이 이 시기다. 이어서 발매된 정규 1집 [The Red]는 이들을 국내 정상권 걸그룹으로 포지셔닝 한 터닝포인트였다. 첫 싱글 Dumb Dumb 은 주요 차트 1위를 석
권하며 화제를 모았고, 뒤이어 발매한 EP [The Velvet]의 발라드 트랙 7월7일 에서는 기존과는 다른 부드러운 매력을, 유튜브 1억 뷰를 돌파한 Russian Roulette 에선 비비드
한 매력을 선보이며 글로벌 걸그룹의 저력을 보였다.
사랑하는 이를 "루키"로 귀엽고 재치 있게 비유한 팝 댄스 트랙 Rookie, 그리고 중독적인 후크와 시원한 여름의 분위기를 담은 빨간 맛 은 팬덤을 넘어 대중적으로 고른 사랑을 받은 2017년의
히트곡들이었다. 이후 정규작 [Perfect Velvet]의 타이틀곡 피카부 에서는 현 세대의 쿨한 사랑 방식을 업 템포 넘버로 표현했으며, 앨범 전체에 국내외 유명 뮤지션들이 참여해 완성도를 높였다.
 이어 [The Perfect Red Velvet - The 2nd Album Repackage]의 타이틀곡 Bad Boy 는 리패키지 앨범임에도 오랜 시간 차트 상위권에 랭크되었다.
2018년에는 새 EP [Summer Magic]을 공개해 또 한 번 여름을 강타했다.'
WHERE ARTIST_SEQ LIKE 20;
UPDATE ARTIST
SET INTRO1 = '10cm는 포크음악을 주로 하는 대한민국의 인디밴드이다. 2010년 4월 [10cm The First EP]로 데뷔했으며, 2010년 발매한 싱글 아메리카노 가 미디어에서 화제가 되며 주목을 받았다.
2011년 2월 첫 정규 앨범 [1.0]과 싱글 안아줘요 로 "제8회 한국 대중음악상"에서 최우수 팝 부문을 수상했다.',
    INTRO2 = '2016년 4월에 발매된 싱글 봄이 좋냐 는 멜론 월간 차트 1위, 가온 차트 월간 1위를 달성했고, 2016년 "멜론 뮤직 어워드"에서 포크 부문 뮤직 스타일 상을 수상한 바 있다.
2017년, 기타를 담당하던 윤철중이 탈퇴하면서 권정열 1인 체제로 변경해 그 해 9월 네 번째 정규앨범 [4.0]을 공개했고, 11월에는 EXO 첸과의 컬래버레이션 Bye Babe 로 새로운 조화를 보
여주었다. 2018년 8월에는 싱글 매트리스 로 컴백했다.

[수상이력]
2016 MelOn Music Awards | 뮤직스타일상(포크/블루스)
2015 MelOn Music Awards | 포크 부문
제8회 한국대중음악상 | 최우수 팝(노래부문)
2010 Mnet Asian Music Awards | 올해의 발견'
WHERE ARTIST_SEQ LIKE 21;
UPDATE ARTIST
SET INTRO1 = '발매하는 곡마다 메가 히트를 기록하는 히트곡 메이커 볼빨간사춘기는 인디 밴드를 넘어 대중에게 사랑받는 아티스트로 거듭난 여성 듀오다. 사춘기의 순수하고 풋풋한 감성을 표현하
겠다는 팀명처럼 부끄러움이 많은 사춘기 소녀의 마음을 표현한 곡으로 많은 사랑을 받고 있는 이 그룹은 고등학교 동문인 멤버 안지영 (보컬)과 우지윤 (기타)으로 구성되어 있다.',
    INTRO2 = '2016년 4월 [RED ICKLE]로 본격적인 활동을 시작했으며 뒤이어 첫 정규앨범 [Full Album RED PLANET]을 발매했다. "유희열의 스케치북" 출연 후 입소문을 타기
시작한 타이틀곡 우주를 줄게 가 발매 한 달 만에 차트에 진입했고, 결국 1위를 차지하며 역주행의 주인공으로 거듭났다. 앨범의 흥행 뒤 공개한 히든트랙 좋다고 말해 는 발매되자마자
실시간 차트 1위를 차지했고, 앨범의 수록곡들까지 차트인에 성공하며 명실공히 음원 강자로 떠올랐다.
소속사 동료인 스무살과 컬래버레이션 한 남이 될 수 있을까 는 발매 후 2주 동안 주간 차트 1위를 지키며 음원 강자의 위력을 보여줬고, 2017년 9월 [Red Diary Page.1]에
서는 사랑의 시작부터 이별의 순간까지를 일기 형식으로 선보이며 화제를 모았다. 특히 수록곡 중 썸 탈꺼야 , 나의 사춘기에게 , Blue 를 TOP 10에, 전곡을 TOP 20에 안착
시킨 것은 인디 듀오로서 또 다른 기록이라 할 수 있다.
준수한 성적으로 사랑 받은 그룹은 2017년 연간 차트 100위에 무려 7곡을 올리는 기염을 토했다. 앨범의 대부분의 곡들을 직접 작사, 작곡하며 자신들만의 감성을 그려가고 있는 볼
빨간사춘기는 2018년 5월 [Red Diary Page.2]을 발매했으며, 7월에는 Red Diary의 마지막 장 [Hidden Track]을 선보였다.'
WHERE ARTIST_SEQ LIKE 22;

UPDATE ARTIST
SET INTRO1 = '차별화된 콘셉트와 뛰어난 실력으로 대중의 사랑을 받으며 "믿듣맘무"라는 수식어를 탄생시킨 걸그룹 마마무는 데뷔 이전부터 실력파 아이돌로 기대를 모았다. 2014년 범키의 행복하
지마 , 케이윌의 썸남썸녀 , 긱스의 히히하헤호  등 여러 곡에서 활발한 컬래버레이션으로 대중의 관심을 불러 일으켰고 신인답지 않은 완성형 아이돌의 모습을 선보였다.',
    INTRO2 = '특히 4명의 멤버 모두 작사, 작곡, 안무 메이킹, 보컬, 랩 분야에서 뛰어난 실력을 자랑하는 것이 마마무만의 차별화된 장점이라 할 수 있다.
그룹은 갓난 아이의 옹알이처럼 원초적이고 본능적인 매력으로 다가가겠다는 뜻인 "마마무"라는 이름으로 2014년 6월 Mr. 애매모호 를 통해 정식 데뷔했다. 같은 해 11월에는 Piano Man
을 발표, 복고풍의 레트로 음악을 매끄럽게 소화하며 팬들의 주목을 받았다. 뛰어난 실력과 화제성을 인정받은 이들은 4회 가온차트 K-POP 어워드에서 신인상을 수상한 하며 성공적 데뷔를 치렀다.
이듬해, 두 번째 미니앨범 [Pink Funky]의 음오아예 는 음원 차트 상위권에 올랐고 가온 연간 차트 27위, 멜론 연간 차트 30위를 기록했다. 2016년 3월 넌 is 뭔들 로 음원 사이트 주간
1위를 석권한 이들은 싱글 Angel, DAB DAB, NEW YORK 을 연이어 발표했으며 2016년 11월 발매한 EP [MEMORY] 수록곡 Decalcomanie로 역주행에 성공, 차트 롱런과 함께 대
세 걸그룹으로 자리잡았다.
드라마 "도깨비", "힘쎈여자 도봉순", "맨투맨" 등에서 실력을 뽐냈으며, 특히 "불후의 명곡"에서 역대급 실력과 화려한 퍼포먼스로 1위를 차지하며 사랑 받았다. 2017년 6월 EP [Purple]
은 활동 기간 중 음악 방송 1위를 7회 차지하는 등 역대급 성과를 이루었으며, 2018년 1월 싱글 칠해줘 를 발매, 4위에 오르기도 했다. 2018년에 들어서는 마마무 연간 앨범 프로젝트 "포시즌"의 신
호탄으로 [Yellow Flower]를 발매, 음악적 재능의 성숙함을 드러내며 음원 차트를 장악하고 있다.'
WHERE ARTIST_SEQ LIKE 23;
UPDATE ARTIST
SET INTRO1 = '박원은 대한민국의 싱어송라이터이다. "유재하 음악경연대회" 출신 선배였던 정지찬과 함께 듀오 원 모어 찬스(one more chance)를 결성해 데뷔했고, 따뜻하고 정감 있는 음악
들로 사랑을 받았다.',
    INTRO2 = '2015년 11월 정규 1집 [Like A Wonder]를 통해 솔로 활동을 시작했으며, 전 곡을 작사, 작곡하여 자신의 음악적 색깔을 가득 담았다. 본래 타이틀곡인 우리 둘이 보다 절절한 이별 노래인
이럴거면 헤어지지 말았어야지 와 나를 좋아하지 않는 그대에게 가 주목받으며 이별 전문 가수로 성공적인 홀로서기를 시작했다.
이듬해 이별 감성을 이어 발매한 [1/24]의 타이틀곡 노력 으로 음원 차트 상위권에 진입했고, 아티스트적 색깔을 확고히 구축하며 평단의 호평을 받았다. 2017년 2월 수지와의 듀엣인 러브송 기다리지 말아요
로 대중들에게 자신을 알렸고, 7월 발매한 EP [0M]의 타이틀곡 all of my life 로 실시간 차트 1위와 주간차트 2위 등극, 2개월 이상 상위권에 랭크되며 상업적인 파급력을 입증했다.
2018년 10월에는 새 미니앨범 [r]을 공개하며 차가운 가을 감성으로 사랑 받았다.

[수상이력]
2008 유재하 음악경연대회 | 대상'
WHERE ARTIST_SEQ LIKE 24;
UPDATE ARTIST
SET INTRO1 = '가요계와 예능계 전반에서 맹활약 하고 있는 윤종신은 현재 가수, 싱어송라이터, 예능인, 프로듀서 등 여러 분야에서 독보적인 활약을 펼치는 멀티 엔터테이너이다. 특유의 담백하고 덤덤한
창법과 현실적인 가사, 새로운 멜로디를 만들어내는 탁월한 재능과 노력을 이어온 그는 데뷔 이후 지금까지 활발한 활동을 이어가고 있다. 윤종신은 대학 내 가요제 입상하며 음악을 시작, 음악
동료이자 스승인 정석원을 만나 1990년 7월 015B 텅 빈 거리에서 의 객원 보컬로서 가요계에 데뷔했다',
    INTRO2 = '2009년부터 "슈퍼스타 K"의 심사위원으로 활약하면서 설득력 있는 평가로 좋은 반응을 얻었으며, 2010년에는 재능 있는 가수들을 발굴하고 지원하기 위해 소속사 미스틱 89를 설립했다.
음악인으로서의 나태를 거부하며 매달 싱글 한 곡을 발표하고 매년 1분기에 컴필레이션으로 묶어 발표하는 프로젝트 "월간 윤종신"을 시작한 것이 이 무렵이다. "월간 윤종신"은 특히 주변에
뛰어난 아티스트들을 발굴하며 함께 작업하는 것이 특징인데, 협업과 함께 다양한 콘셉트의 노래들을 발표하며 이제는 그의 상징과도 같은 활동이 되었다. 기본적으로 발라드에 능통한 것으로 알려져 있지만,
누구보다 다양하고 새로운 시도를 선보이고 있음을 그의 끊임없는 디스코그래피를 통해 알 수 있다.
객원보컬로 데뷔해 프로 작곡가와 작사가로, 또 프로듀서로, 더 나아가 올라운드 멀티 엔터테이너로 인정을 받은 가수는 윤종신이 유일하다. 2018년에는 대중성과 함께 그동안의 공로를 인정받아 제 7회
가온 차트 뮤직 어워드에서 올해의 파퓰러 싱어상, K-POP 공헌상을 동시에 수상하는 쾌거도 거두었다. 객원가수로 시작해 이제는 가요계에서 새로운 판을 짜고 있는 윤종신,
우리는 그를 올라운드 플레이어라 부른다.'
WHERE ARTIST_SEQ LIKE 25;
UPDATE ARTIST
SET INTRO1 = '벤은 대한민국의 가수로 2010년 그룹 베베미뇽의 싱글 키도 작고 예쁘지도 않지만 으로 데뷔했으며, 2012년 10월 첫 솔로 EP [147.5]를 발매해 활동을 시작했다.
2014년부터 음악 경연 프로그램 "불후의 명곡"에서 리틀 이선희로 활약하면서 주목을 받아 드라마 "프로듀사", "오 나의 귀신님","또 오해영" 등 사운드 트랙에 참여했으며, 미니 앨범 [M',
    INTRO2 = '2009년부터 "슈퍼스타 K"의 심사위원으로 활약하면서 설득력 있는 평가로 좋은 반응을 얻었으며, 2010년에는 재능 있는 가수들을 발굴하고 지원하기 위해 소속사 미스틱 89를 설립했다.
음악인으로서의 나태를 거부하며 매달 싱글 한 곡을 발표하고 매년 1분기에 컴필레이션으로 묶어 발표하는 프로젝트 "월간 윤종신"을 시작한 것이 이 무렵이다. "월간 윤종신"은 특히 주변에
뛰어난 아티스트들을 발굴하며 함께 작업하는 것이 특징인데, 협업과 함께 다양한 콘셉트의 노래들을 발표하며 이제는 그의 상징과도 같은 활동이 되었다. 기본적으로 발라드에 능통한 것으로 알려져 있지만,
누구보다 다양하고 새로운 시도를 선보이고 있음을 그의 끊임없는 디스코그래피를 통해 알 수 있다.
객원보컬로 데뷔해 프로 작곡가와 작사가로, 또 프로듀서로, 더 나아가 올라운드 멀티 엔터테이너로 인정을 받은 가수는 윤종신이 유일하다. 2018년에는 대중성과 함께 그동안의 공로를 인정받아 제 7회
가온 차트 뮤직 어워드에서 올해의 파퓰러 싱어상, K-POP 공헌상을 동시에 수상하는 쾌거도 거두었다. 객원가수로 시작해 이제는 가요계에서 새로운 판을 짜고 있는 윤종신,
우리는 그를 올라운드 플레이어라 부른다.'
WHERE ARTIST_SEQ LIKE 26;
UPDATE ARTIST
SET INTRO1 = '2017년, 역주행 전설을 실현한 선물 속 가사처럼 "마법같이 빛난" 한 해를 보낸 멜로망스는 대중 음악계의 차세대 인디 듀오다. 시크한 표정으로 시원한 고음을 내뱉는 보컬 김민석과 유
명 뮤지션의 작품에 세션으로 참여할 만큼 뛰어난 실력을 지닌 피아노의 정동환은 서울예대 실용음악과 동문 사이로, 2015년 첫 EP [Sentimental]을 통해 데뷔했다.',
    INTRO2 = '데뷔 EP에서 전곡을 작사, 작곡하며 멜로망스만의 음악적 색깔을 선보였고 훈훈한 비주얼과 돋보이는 실력으로 팬들의 주목을 받았다. 데뷔 앨범 발표 후 보컬 김민석은 음악 예능 프로그램
"너의 목소리가 보여"에서 세 번째 나얼로 출연하며 뛰어난 노래 실력을 뽐냈고 정동환은 "자라섬 재즈 페스티벌" 무대에서 자신만의 음악을 연주하는 등 그룹 외 활동도 활발하게 펼쳤다.
첫 앨범과 대칭 구조를 이루는 미니앨범 [Romantic]과 새 연작의 첫 앨범 [Sunshine]를 발매하며 꾸준한 활동을 이어간 그룹은 2017년 7월 EP [Moonlight]를 발매하며 새로운
시작을 알린다. 심플한 악기구성으로 시작한 타이틀 곡 선물 은 중반부부터 더해지는 현악기에 풍성한 사운드로 사랑에 빠진 기적 같은 순간을 다이나믹하게 그렸다. 특히 9월 출연한 "유희열의
스케치북" 방송 이후 차트에 진입, 순위 상승을 거듭하다 마침내 1위를 차지하며 역주행의 신화를 썼고, 11월에는 멜론 월간 차트 1위에 올라서는 등 저력을 보였다.
차트 1위에 오른 10월을 시작으로 2018년 상반기까지 최상위권을 지키며 꾸준한 사랑을 받고 있는 멜로망스는 2018년 7월, 미니앨범 [The Fairy Tale]를 발매하며 대중 친화적이면서도
편안한 음악들을 선보였다. 가요계의 대표 인디 뮤지션으로 자리 잡은 멜로망스는 그들의 애칭인 "웰 메이드 피아노 팝 듀오"의 아이덴티티를 성공적으로 구축해 나가고 있다.'
WHERE ARTIST_SEQ LIKE 27;
UPDATE ARTIST
SET INTRO1 = '먼데이키즈(Monday Kiz)는 2005년 결성되어 현재까지 활동하고 있는 남성 R&B 그룹이다. 2000년대 중반 SG 워너비 등의 그룹 R&B 사운드의 유행을 일조했던 그룹이다. 현재까지
다섯 장의 정규 앨범을 발매하였으며, 본래 2인조 그룹이었으나 2008년 멤버 김민수가 오토바이 사고로 사망함으로서 해체되었고, 다시 새로운 멤버를 받아들여 3인조로 재편 후 현재는 이진
성 1인 솔로 아티스트로 활동하고 있다.',
    INTRO2 = '2005년 먼데이키즈는 1985년생 서울 출신 이진성과 부산 출신 김민수의 2인조로 데뷔했다. 정규 앨범 발매 이전 신해철의 락 그룹 넥스트(NEXT)의 5.5집 리메이크 앨범 [Regame]의
인형의 기사에 피처링하며 이름을 알렸다. 첫 번째 정규 앨범 [Bye Bye Bye]는 2005년 11월 발매되었다. 당시 R&B 그룹들의 공통된 유행이었던 드라마식 구성의 뮤직비디오와 애절
한 가사와 가창을 따라간 앨범에서는 하모니카 연주자 전제덕이 참여한 Bye Bye Bye , 보컬 그룹 원티드(Wanted)의 앨범에 수록되는 것 대신 그들의 앨범에 수록된 Promise 등이
절절한 보컬 속에서 주목받았다.
2016년 원년 멤버 이진성이 군 제대 후 홀로서기를 시작. 2005년 먼데이 키즈의 처음 모습 그대로를 담은 EP 앨범 [Reboot]를 발매하며 새로운 먼데이 키즈의 이야기를 이어갔다.
많은 변화가 있었음에도 불구하고 여전히 깊은 감성을 담은 싱글 하기 싫은 말 , 누군가를 떠나 보낸다는 건 , 가을 안부 등을 발표했다. 또한 김나영, 김보경, 015B, 지아 등과
컬래버레이션 싱글을 발표하면서 많은 이들에게 공감과 낭만을 선물하고 있다.'
WHERE ARTIST_SEQ LIKE 28;
UPDATE ARTIST
SET INTRO1 = '박효신은 특유의 굵은 보이스로 일명 "소몰이 창법"의 창시자로 대한민국에 몇 안 되는 감성 발라더이다. 고등학교 재학 시절 가수의 꿈을 키우며 "부천 청소년 가요제", "YMCA 청소년
가요제", "제물포 가요제" 등의 각종 대회에 나가 수상을 하면서 프로듀서 황윤민에게 스카우트되었다. 1년 반의 연습 기간을 거쳐 신촌 뮤직을 통해 1999년 [해줄 수 없는 일]로 데뷔했다.',
    INTRO2 = '박효신은 실력만큼 발표하는 앨범마다 대중적으로도 좋은 평가를 받았음에도 소속사와 분쟁으로 번번이 가수 활동에 제약을 받은 불운의 가수이기도 하다. 신촌뮤직 시절부터 시작된 불운은 2006
년 닛시 엔터테인먼트와 법정 공방에서 박효신이 닛시 측에 계약금 전액을 돌려주는 것으로 마무리되었고, 2008년 1월에는 전 소속사였던 인터스테이지(나원)로부터 전속계약 위반으로 30억 원
소송을 당했다. 한편, 2009년 1월, 팬텀 엔터테인먼트로부터 또 한번의 고소를 당했고, 이는 박효신의 승소로 끝났다. 기나긴 소속사와의 전쟁은 2012년 6월 박효신이 15억원을 배상하는
것으로 최종 판결이 나면서 종결됐다. 오랜 시간 심적 고초를 겪으면서도 박효신은 꾸준히 음악 활동을 계속 해왔으며, 2009년 6집 [Gift - Part 1]을 발표, 사랑한 후에 로 케이블 음
악방송 1위를 차지해 발라더로서 여전함을 보여주었다.
이어 발매한 HAPPY TOGETHER 와 Shine Your Light 도 차트에서 준수한 성적을 보였다. 마지막 싱글 Shine Your Light 발매 후 1년 6개월 만에 정규앨범 [I am A Dre
amer]라는 앨범을 발매했는데, Home과 Beautiful Tommorrow 가 나란히 차트에 올라 주목을 받았고 이때 진행한 전국투어 "I am A Dreamer 가 성황리에 공연을 마치면서 한국
발라드계 최정상급 보컬리스트임을 보여줬다. 2017 멜론 뮤직 어워드에서 Stage of the year를 수상하며 공연계에서의 영향력을 입증했고, 겨울의 감성을 담은 겨울소리 로 2018년을
열며 박효신만의 색채를 고스란히 담아냈다.'
WHERE ARTIST_SEQ LIKE 60;
UPDATE MUSIC SET MUSIC_ADDR = 'https://www.youtube.com/embed/mjTdMX27ThM' WHERE MUSIC_SEQ LIKE 57;
UPDATE MUSIC SET MUSIC_ADDR = 'https://www.youtube.com/embed/Pf88Wdj68JY' WHERE MUSIC_SEQ LIKE 73;
UPDATE MUSIC SET MUSIC_ADDR = 'https://www.youtube.com/embed/DUTUHUbJ6u8' WHERE MUSIC_SEQ LIKE 72;
UPDATE MUSIC SET MUSIC_ADDR = 'https://www.youtube.com/embed/3yoRkQBVUzM' WHERE MUSIC_SEQ LIKE 63;
UPDATE MUSIC SET MUSIC_ADDR = 'https://www.youtube.com/embed/HFRoJrcG-B0' WHERE MUSIC_SEQ LIKE 64;
UPDATE MUSIC SET MUSIC_ADDR = 'https://www.youtube.com/embed/d4Wcqe1a6xk' WHERE MUSIC_SEQ LIKE 59;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/AU6shR8rkCA' WHERE MUSIC_SEQ LIKE 65;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/CxsffBwhnSw' WHERE MUSIC_SEQ LIKE 66;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/U6FopXugJo8' WHERE MUSIC_SEQ LIKE 67;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/IhYxz6eXegM' WHERE MUSIC_SEQ LIKE 68;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/MkUcDLsCbGU' WHERE MUSIC_SEQ LIKE 69;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/PobwfenaD_U' WHERE MUSIC_SEQ LIKE 70;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/HWK4NVzoNNI' WHERE MUSIC_SEQ LIKE 71;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/mxSWBhURJ3M' WHERE MUSIC_SEQ LIKE 74;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/kCYTOR7XIB8' WHERE MUSIC_SEQ LIKE 75;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/zSMOO6SA7Uw' WHERE MUSIC_SEQ LIKE 76;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/fujuo-ms1nI' WHERE MUSIC_SEQ LIKE 77;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/KpdGwluW8QY' WHERE MUSIC_SEQ LIKE 78;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/er5sTELLZ60' WHERE MUSIC_SEQ LIKE 79;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/rbcTZGCzAi8' WHERE MUSIC_SEQ LIKE 80;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/fthzn5U3xHU?list=PLPgQcN4QerkEhSPs3uc26P1iKZYjG5Nz7' WHERE MUSIC_SEQ LIKE 81;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/rVxI7dX7nuE' WHERE MUSIC_SEQ LIKE 82;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/zLHOyiMfTmM' WHERE MUSIC_SEQ LIKE 83;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/9II_GQJ7mKo' WHERE MUSIC_SEQ LIKE 84;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/LOl1ENoPwxo' WHERE MUSIC_SEQ LIKE 85;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/Mr2DA8RNuow' WHERE MUSIC_SEQ LIKE 86;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/SUaXXwdaBYo' WHERE MUSIC_SEQ LIKE 87;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/pQ_bTi9fXVg' WHERE MUSIC_SEQ LIKE 88;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/7uJl6b2JTuE' WHERE MUSIC_SEQ LIKE 89;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/2XYP3kcDpYs' WHERE MUSIC_SEQ LIKE 90;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/jFFDDANFAKI' WHERE MUSIC_SEQ LIKE 91;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/f6xGhx1sHqI' WHERE MUSIC_SEQ LIKE 92;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/I1w1Sd1HeUI' WHERE MUSIC_SEQ LIKE 93;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/xKPg6zPZbW0' WHERE MUSIC_SEQ LIKE 94;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/d3M_tUWnjHI' WHERE MUSIC_SEQ LIKE 95;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/T3GqVt8RCI8' WHERE MUSIC_SEQ LIKE 96;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/yFNmuhD48BE' WHERE MUSIC_SEQ LIKE 97;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/p1OdWbpD9sA' WHERE MUSIC_SEQ LIKE 98;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/V38GnjOjHbk' WHERE MUSIC_SEQ LIKE 99;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/JANAfyuVukA' WHERE MUSIC_SEQ LIKE 100;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/i_x2oQPlfng' WHERE MUSIC_SEQ LIKE 101;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/oPNmqG4o-GM' WHERE MUSIC_SEQ LIKE 102;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/VGwFxQkNQCk' WHERE MUSIC_SEQ LIKE 103;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/LoYgZ5Q6qlM' WHERE MUSIC_SEQ LIKE 104;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/oYf7BodmSu0' WHERE MUSIC_SEQ LIKE 105;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/aPgOM-5q-hQ' WHERE MUSIC_SEQ LIKE 106;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/MuD00um66K4' WHERE MUSIC_SEQ LIKE 107;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/C7AaJ-EK7pE' WHERE MUSIC_SEQ LIKE 108;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/3H1FCCc-_MM' WHERE MUSIC_SEQ LIKE 109;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/MJlIfsXw2F0' WHERE MUSIC_SEQ LIKE 110;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/qDMnEm4Smf8' WHERE MUSIC_SEQ LIKE 111;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/tPuzbDIx5qY' WHERE MUSIC_SEQ LIKE 112;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/aRTlm05jDOs' WHERE MUSIC_SEQ LIKE 113;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/rzcsDOozLGw' WHERE MUSIC_SEQ LIKE 114;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/vQ05MHEnXjw' WHERE MUSIC_SEQ LIKE 115;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/kvA_0c0C0mo' WHERE MUSIC_SEQ LIKE 116;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/eLiEn2phlMI' WHERE MUSIC_SEQ LIKE 117;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/ZJo3B22uFwM' WHERE MUSIC_SEQ LIKE 118;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/KWZ-ytC9Uyk' WHERE MUSIC_SEQ LIKE 119;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/VgtEyhEJpKg' WHERE MUSIC_SEQ LIKE 120;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/Rlx0-7gxtk8' WHERE MUSIC_SEQ LIKE 121;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/pYKPJl1PIIw' WHERE MUSIC_SEQ LIKE 122;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/s_7yNDzG7OI' WHERE MUSIC_SEQ LIKE 123;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/bLhVpz1a4mE' WHERE MUSIC_SEQ LIKE 124;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/ZQDWoXC2r5k' WHERE MUSIC_SEQ LIKE 125;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/rIGifjx_F1U' WHERE MUSIC_SEQ LIKE 133;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/TpuZeNFMs1Q' WHERE MUSIC_SEQ LIKE 134;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/rM_SZLfFkVg' WHERE MUSIC_SEQ LIKE 135;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/QpwNVNryLSo' WHERE MUSIC_SEQ LIKE 136;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/2AsLK_7k-5U' WHERE MUSIC_SEQ LIKE 137;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/Cqe37sLrH2I' WHERE MUSIC_SEQ LIKE 138;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/Lwp0PAZJ8ag' WHERE MUSIC_SEQ LIKE 139;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/1WHqOPkGoqA' WHERE MUSIC_SEQ LIKE 140;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/Y4Zpm41f1VQ' WHERE MUSIC_SEQ LIKE 141;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/-QCp2nHYxe0' WHERE MUSIC_SEQ LIKE 142;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/-YIj6H4ShQA' WHERE MUSIC_SEQ LIKE 143;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/rlaRw_5sxGE' WHERE MUSIC_SEQ LIKE 144;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/TjCyMv8b0_I' WHERE MUSIC_SEQ LIKE 145;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/BK1e3DDkdi0' WHERE MUSIC_SEQ LIKE 146;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/PSXm3FuxEcU' WHERE MUSIC_SEQ LIKE 147;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/15vNx-NfVow' WHERE MUSIC_SEQ LIKE 148;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/ECHzQ_82p4U' WHERE MUSIC_SEQ LIKE 149;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/Ag5gfyKniPE' WHERE MUSIC_SEQ LIKE 150;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/7H4zkgKkNMI' WHERE MUSIC_SEQ LIKE 151;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/iv2ADx4wqfI' WHERE MUSIC_SEQ LIKE 152;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/9qaKC3u7Viw' WHERE MUSIC_SEQ LIKE 153;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/97Zyp0PAK04' WHERE MUSIC_SEQ LIKE 154;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/b8BjDTGOuzw' WHERE MUSIC_SEQ LIKE 155;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/1wccNQKiCWs' WHERE MUSIC_SEQ LIKE 156;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/Sn88Kjkhwig' WHERE MUSIC_SEQ LIKE 157;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/s6DI1qg5CfM' WHERE MUSIC_SEQ LIKE 158;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/LwZB-BuQj4s' WHERE MUSIC_SEQ LIKE 159;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/F1n4TKIv2SQ' WHERE MUSIC_SEQ LIKE 177;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/IvAsyLc7kEc' WHERE MUSIC_SEQ LIKE 178;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/BHOCt2pBVMg' WHERE MUSIC_SEQ LIKE 179;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/dMmDDFCaGNA' WHERE MUSIC_SEQ LIKE 180;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/dpJbYm-Ju80' WHERE MUSIC_SEQ LIKE 181;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/kEijTTA7Dbc' WHERE MUSIC_SEQ LIKE 182;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/8fl8pXbT-t8' WHERE MUSIC_SEQ LIKE 183;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/pSlikGQaj08' WHERE MUSIC_SEQ LIKE 184;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/tqs_oXYfdZA' WHERE MUSIC_SEQ LIKE 185;
UPDATE MUSIC SET MUSIC_ADDR ='https://www.youtube.com/embed/FLuhVsDFOh8' WHERE MUSIC_SEQ LIKE 186;


INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('auctor','여','2018-10-25 08:31:24'),
('auctor','여','2018-10-25 08:31:24'),
('auctor','여','2018-10-25 08:31:24'),
('auctor','여','2018-10-25 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('sound','남','2018-10-25 08:31:24'),
('sound','남','2018-10-25 08:31:24'),
('sound','남','2018-10-25 08:31:24'),
('sound','남','2018-10-25 08:31:24'),
('sound','남','2018-10-25 08:31:24'),
('sound','남','2018-10-25 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('auctor','여','2018-10-26 08:31:24'),
('auctor','여','2018-10-26 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('sound','남','2018-10-26 08:31:24'),
('sound','남','2018-10-26 08:31:24'),
('sound','남','2018-10-26 08:31:24'),
('sound','남','2018-10-26 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('auctor','여','2018-10-27 08:31:24'),
('auctor','여','2018-10-27 08:31:24'),
('auctor','여','2018-10-27 08:31:24'),
('auctor','여','2018-10-27 08:31:24'),
('auctor','여','2018-10-27 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('sound','남','2018-10-27 08:31:24'),
('sound','남','2018-10-27 08:31:24'),
('sound','남','2018-10-27 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('auctor','여','2018-10-28 08:31:24'),
('auctor','여','2018-10-28 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('sound','남','2018-10-28 08:31:24'),
('sound','남','2018-10-28 08:31:24'),
('sound','남','2018-10-28 08:31:24'),
('sound','남','2018-10-28 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('auctor','여','2018-10-29 08:31:24'),
('auctor','여','2018-10-29 08:31:24'),
('auctor','여','2018-10-29 08:31:24'),
('auctor','여','2018-10-29 08:31:24'),
('auctor','여','2018-10-29 08:31:24'),
('auctor','여','2018-10-29 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('sound','남','2018-10-29 08:31:24'),
('sound','남','2018-10-29 08:31:24'),
('sound','남','2018-10-29 08:31:24'),
('sound','남','2018-10-29 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('auctor','여','2018-10-30 08:31:24'),
('auctor','여','2018-10-30 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('sound','남','2018-10-30 08:31:24'),
('sound','남','2018-10-30 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('auctor','여','2018-10-31 08:31:24'),
('auctor','여','2018-10-31 08:31:24'),
('auctor','여','2018-10-31 08:31:24'),
('auctor','여','2018-10-31 08:31:24'),
('auctor','여','2018-10-31 08:31:24'),
('auctor','여','2018-10-31 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('sound','남','2018-10-31 08:31:24'),
('sound','남','2018-10-31 08:31:24'),
('sound','남','2018-10-31 08:31:24'),
('sound','남','2018-10-31 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('auctor','여','2018-11-01 08:31:24'),
('auctor','여','2018-11-01 08:31:24'),
('auctor','여','2018-11-01 08:31:24'),
('auctor','여','2018-11-01 08:31:24'),
('auctor','여','2018-11-01 08:31:24'),
('auctor','여','2018-11-01 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('sound','남','2018-11-01 08:31:24'),
('sound','남','2018-11-01 08:31:24'),
('sound','남','2018-11-01 08:31:24'),
('sound','남','2018-11-01 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('auctor','여','2018-11-02 08:31:24'),
('auctor','여','2018-11-02 08:31:24'),
('auctor','여','2018-11-02 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('sound','남','2018-11-02 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('auctor','여','2018-11-03 08:31:24'),
('auctor','여','2018-11-03 08:31:24'),
('auctor','여','2018-11-03 08:31:24'),
('auctor','여','2018-11-03 08:31:24'),
('auctor','여','2018-11-03 08:31:24'),
('auctor','여','2018-11-03 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('sound','남','2018-11-03 08:31:24'),
('sound','남','2018-11-03 08:31:24'),
('sound','남','2018-11-03 08:31:24'),
('sound','남','2018-11-03 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('auctor','여','2018-11-04 08:31:24'),
('auctor','여','2018-11-04 08:31:24'),
('auctor','여','2018-11-04 08:31:24'),
('auctor','여','2018-11-04 08:31:24'),
('auctor','여','2018-11-04 08:31:24'),
('auctor','여','2018-11-04 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('sound','남','2018-11-04 08:31:24'),
('sound','남','2018-11-04 08:31:24'),
('sound','남','2018-11-04 08:31:24'),
('sound','남','2018-11-04 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('auctor','여','2018-11-05 08:31:24'),
('auctor','여','2018-11-05 08:31:24'),
('auctor','여','2018-11-05 08:31:24'),
('auctor','여','2018-11-05 08:31:24'),
('auctor','여','2018-11-05 08:31:24'),
('auctor','여','2018-11-05 08:31:24');
INSERT INTO LOGIN_RECORD(MEMBER_ID,SEX,LOGIN_DATE) 
VALUES
('sound','남','2018-11-05 08:31:24'),
('sound','남','2018-11-05 08:31:24'),
('sound','남','2018-11-05 08:31:24'),
('sound','남','2018-11-05 08:31:24');
UPDATE MUSIC 
SET ALBUM_SEQ = 45
WHERE ARTIST_SEQ LIKE 19;
UPDATE MUSIC 
SET ALBUM_SEQ = 48
WHERE ARTIST_SEQ LIKE 20;
UPDATE MUSIC 
SET MUSIC_ADDR = 'https://www.youtube.com/embed/Ux1GFKwupYk'
WHERE MUSIC_SEQ LIKE 58;
UPDATE MUSIC 
SET MUSIC_ADDR = 'https://www.youtube.com/embed/9UIlPm00j2E'
WHERE MUSIC_SEQ LIKE 62;