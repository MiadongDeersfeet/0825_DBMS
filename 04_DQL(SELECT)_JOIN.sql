SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;

-- 전체사원들의 사번, 사원명, 부서코드, 부서명을 한꺼번에 조회하고 싶다.

SELECT
	   EMP_ID
	 , EMP_NAME
	 , DEPT_CODE
  FROM
	   EMPLOYEE;
	   
SELECT
   	   DEPT_ID
	 , DEPT_TITLE
  FROM
 	   DEPARTMENT;

-- 전체사원들의 사번, 사원명, 직급코드, 직급명을 한꺼번에 조회해라.

SELECT
   	   EMP_ID
	 , EMP_NAME
	 , JOB_CODE
  FROM 
	   EMPLOYEE;

SELECT
	   JOB_CODE
	 , JOB_NAME
  FROM
	   JOB;

-- 면접 단골질문으로 서로 다른 테이블에 있는 컬럼들을 어떻게 한꺼번에 조회할 수 있는가??? ☆★☆★☆★☆★
--> JOIN을 통해 연결고리에 해당하는 컬럼만 매칭시킨다면 마치 하나의 조회 결과물처럼 조회 가능
--> 이것만 잘해도 한 회사 면접에 OK가 될 정도로 어마어마한 친구

-- KH
-- 어떤 강의장에 어떤 강사가 수업을 하고 있는가??

CREATE TABLE CLASS_ROOM( 
	CLASS_ID CHAR(1)
,   LECTURE_NAME VARCHAR2(20)
); 

SELECT * FROM CLASS_ROOM;

INSERT INTO CLASS_ROOM VALUES ('A', '이승철');
INSERT INTO CLASS_ROOM VALUES ('B', '김태원');
INSERT INTO CLASS_ROOM VALUES ('C', '채제민');

CREATE TABLE STUDENT(
	CLASS_ID CHAR(1)
, 	STUDENT_NAME VARCHAR2(20)
);

SELECT * FROM STUDENT;

INSERT INTO STUDENT VALUES ('A', '한승욱');
INSERT INTO STUDENT VALUES ('A', '채정민');
INSERT INTO STUDENT VALUES ('B', '김윤기');
INSERT INTO STUDENT VALUES ('C', '김태호');

SELECT
	   LECTURE_NAME
	 , CLASS_ROOM.CLASS_ID
	 , STUDENT.CLASS_ID
	 , STUDENT_NAME
  FROM 
	   CLASS_ROOM, STUDENT -- 1절 끝
 WHERE
	   CLASS_ROOM.CLASS_ID = STUDENT.CLASS_ID;

/*
 * < JOIN >
 * 
 * 두 개 이상의 테이블에서 데이터를 한 번에 조회하기 위해 사용하는 구문
 * 조회결과는 하나의 ResultSet으로 나옴 
 * 
 * 관계형 데이터베이스에서는 최소한의 데이터로 각각의 테이블에 데이터를 보관하고 있다.(중복방지)
 * -> JOIN 구문을 사용해서 여러 개의 테이블 간 "관계"를 맺어서 같이 조회해야한다.
 * => 무작정 JOIN을 해서 조인하는 것이 아니고 테이블 간 매칭을 할 수 있는 컬럼이 존재해야한다.
 * 
 * JOIN은 크게 "오라클 전용구문"과 "ANSI(미국국립표준협회)구문"으로 나뉜다.
 * 보통은 ANSI 구문을 선호한다.
 * 
 * =============================================================================
 * 		오라클 전용 구문    					|   	ANSI(오라클 + 타 DBMS) 구문
 * =============================================================================
 *         등가조인	  					| 				내부조인
 * 		(EQUAL JOIN)					| 			 (INNER JOIN)
 * ------------------------------------------------------------------------------
 * 		   포괄조인 						|		 왼쪽 외부 조인(LEFT OUTER JOIN)
 *		(LEFT OUTER)					| 		오른쪽 외부 조인(RIGHT OUTER JOIN)
 *		(RIGHT OUTER)					| 		전체 외부 조인(FULL OUTER JOIN) -> 오라클에선 X
 * -------------------------------------------------------------------------------
 *		  카테시안 곱		                |               교차조인
 *	 (CARTESIAN PRODUCT)		        |             (CROSS JOIN)
 *--------------------------------------------------------------------------------
 *자체조인(SELF JOIN)
 *비등가조인(NON EQUAL JOIN)	
 *자연조인(NATURAL JOIN)	
 */

/*
 * 1. 등가조인(EQUAL JOIN) / 내부조인(INNER JOIN)
 * 
 * JOIN 시 연결시키는 컬럼의 값이 일치하는 행들만 조인돼서 조회
 * ( == 일치하지 않는 값들을 조회에서 제외)
 */

--> 오라클 전용 구문
--> SELECT 절에는 조회하고 싶은 컬럼명을 각각 기술
-->   FROM 절에는 조회하고자 하는 테이블을  ,  를 이용해서 전부 다 나열
-->  WHERE 절에는 매칭을 시키고자 하는 컬럼명에 대한 조건을 제시함 ( = )     <-- 동등비교

-- 전체 사원들의 사원명, 부서코드, 부서명을 한꺼번에 조회하고 싶다.
SELECT * FROM EMPLOYEE; -- EMP_NAME, DEPT_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID, DEPT_TITLE


-- case 1. 연결할 두 컬럼의 컬럼명이 다른 경우(DEPT_CODE <-> DEPT_ID)
SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , DEPT_ID
	 , DEPT_TITLE
  FROM
	   EMPLOYEE 
	 , DEPARTMENT
 WHERE
 	   DEPT_CODE = DEPT_ID;
-- 207개 행 중에서 21행만 일치하더라.
-- 일치하지 않는 값은 조회에서 제외
-- DEPT_CODE가 NULL인 사원 2명은 데이터가 조회되지 않는다.
-- DEPT_ID가 D3, D4, D7인 부서데이터가 조회되지 않는다.










-- 이번에는 전체 사원들의 사원명, 직급코드, 직급명을 한꺼번에 조회하고 싶어요.
-- 먼저 전체구성을 보아야합니다.
SELECT * FROM JOB; -- JOB_CODE, JOB_NAME
SELECT * FROM EMPLOYEE; -- EMP_NAME, JOB_CODE

-- case 2. 연결할 두 컬럼의 이름이 같은 경우(JOB_CODE)
SELECT
	   EMP_NAME
	 , JOB_CODE
	 , JOB_CODE
	 , JOB_NAME
  FROM
	   EMPLOYEE
	 , JOB
 WHERE
 	   JOB_CODE = JOB.JOB_CODE;

-- 방법 1. 테이블명을 사용하는 방법
SELECT
	   EMP_NAME
	 , EMPLOYEE.JOB_CODE
	 , JOB.JOB_CODE
	 , JOB_NAME
  FROM
	   EMPLOYEE
	 , JOB
 WHERE
 	   EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 방법 2. 별칭 사용(각 테이블마다 별칭 부여 가능)
SELECT
	   EMP_NAME
	 , E.JOB_CODE
	 , J.JOB_CODE
	 , JOB_NAME
  FROM
	   EMPLOYEE E
	 , JOB J
 WHERE
 	   E.JOB_CODE = J.JOB_CODE;
-- 위와 같은 방법은 나중에 행이 많아지면 헷갈릴 수가 있다.




/*
SELECT
EMP_NAME
, "사원정보".JOB_CODE E
, "직급정보".JOB_CODE DE
, JOB_NAME
FROM
EMPLOYEE "사원정보"
, JOB "직급정보"
WHERE
"사원정보".JOB_CODE = "직급정보".JOB_CODE;
*/

-------------------------------------- 오라클 구문 끝!!!!!!!!! -------------------------------------------------------------

--> 이제 ANSI 구문 들어가보자 !
-- FROM절에 기준 테이블을 하나 기술한 뒤
-- 그 뒤에 JOIN절에 같이 조회하고자 하는 테이블을 기술(매칭시킬 컬럼에 대한 조건도 기술)
-- USING / ON 구문 둘 중에 하나를 선택해서 써야해요.

-- EMP_NAME, DEPT_CODE, DEPT_TITLE
-- 사원명, 부서코드, 부서명
-- 연결컬럼이 컬럼명이 다름(EMPLOYEE - DEPT_CODE / DEPARTMENT - DEPT_ID)
-- 위의 경우에는 무조건 ON 구문만 써야한다. (USING은 못씀 안됨 불가능함!!!!!!!!!!!!!!)

SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , DEPT_TITLE
  FROM
	   EMPLOYEE
--INNER (이너조인에서는 이너를 안쓰면 이너조인이 됩니다^~^)
  JOIN
	   DEPARTMENT ON (DEPT_CODE = DEPT_ID);



-- EMP_NAME, JOB_CODE, JOB_NAME
-- 사원명, 직급코드, 직급명
-- 연결할 두 컬럼명이 같을 경우(JOB_CODE)
-- ON 구문이용 ) 애매하다(AMBIGUOUSLY) 발생할 수 있음 어떤 테이블의 컬럼인지 명시
SELECT
	   EMP_NAME
	 , E.JOB_CODE
	 , JOB_NAME
  FROM
	   EMPLOYEE E
  JOIN
  	   JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- USING 구문이용 ) 컬럼명이 동일할 경우 사용이 가능하며 동등비교 연산자를 사용하지 기술하지 않음
SELECT
	   EMP_NAME
	 , JOB_CODE
	 , JOB_NAME
  FROM 
	   EMPLOYEE
  JOIN
	   JOB USING(JOB_CODE);

-- [참고사항] NATURAL JOIN(자연조인)
SELECT
	   EMP_NAME
	 , JOB_CODE
	 , JOB_NAME
  FROM
	   EMPLOYEE
NATURAL
  JOIN
       JOB;
-- 두 개의 테이블을 조언하는데 운 좋게도 두 개의 테이블에 일치하는 컬럼이 딱 하나 있었다.
-- 잘 사용하지 않습니다. 그냥 이런 게 있다고 알아만 두세요.

/*
 * < Quiz >
 */
-- 사원명과 직급명을 같이 조회해주세요. 단 직급명이 대리인 사원들만 조회해주세요.

--> ORACLE 문법

--> ANSI 문법


-- ↓ 이것을 오라클에서는 등가조인(EQUAL JOIN)
-- 1. 오라클 문법
SELECT
	   E.EMP_NAME
	 , J.JOB_NAME
  FROM
	   EMPLOYEE E
	   , JOB J
 WHERE
	   E.JOB_CODE = J.JOB_CODE
   AND
       JOB_NAME = '대리';


-- ↓ 이것을 ANSI에서는 이너조인(INNER JOIN)
-- 2. ANSI 문법
SELECT
	   EMP_NAME
	 , JOB_NAME
  FROM
	   EMPLOYEE E
  JOIN
	   JOB J ON (E.JOB_CODE = J.JOB_CODE)
 WHERE
 	   JOB_NAME = '대리';

-- EQUAL JOIN / INNER JOIN : 일치하지 않는 행은 애초에 ResultSet에 포함시키지 않음

--------------------------------------------------------------------------------------------------------------------------
/*
 * 2. 포괄조인 / 외부조인(OUTER JOIN)
 * 
 * 테이블간의 JOIN 시 일치하지 않는 행도 포함시켜서 ResultSet 반환
 * 단, 반드시 LEFT / RIGHT를 지정해줘야함!(기준 테이블을 선택해야함)
 */

-- EMPLOYEE 테이블에 존재하는 "모든" 사원명과 부서명을 조회
SELECT
	   EMP_NAME
	 , DEPT_TITLE
  FROM
	   EMPLOYEE
-- INNER
  JOIN
	   DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- EMPLOYEE 테이블에서 DEPT_CODE가 NULL인 두 명의 사원은 조회 X
-- DEPARTMENT 테이블에서 부서에 배정된 사원이 없는 부서(D3, D4, D7) 조회 X

--SELECT * FROM EMPLOYEE;

-- 1) LEFT [ OUTER ] JOIN : 두 테이블 중 왼편에 기술한 테이블을 기준으로 JOIN
-- 조건과는 상관없이 왼편에 기술한 테이블의 데이터는 전부 조회(일치하는 값을 못찾더라도 조회)

--> ANSI 구문 ( 외부조인 OUTER JOIN )
SELECT
	   EMP_NAME
	 , DEPT_TITLE
  FROM
	   EMPLOYEE 
  LEFT
-- OUTER(자동생략)
  JOIN
	   DEPARTMENT ON (DEPT_CODE = DEPT_ID);

/*FROM EMPLOYEE LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); */
/* JOIN 을 기준으로 왼 편에 있는 테이블, 오른편에 있는 테이블을 ON 절에 조건을 만족시키지 않더라도 모두 조회하겠다!!!*/

------------------------------------------------------------------------------------------------------------------------
--> ORACLE 구문의 LEFT JOIN
SELECT
	   EMP_NAME
	 , DEPT_TITLE
  FROM
	   EMPLOYEE
	 , DEPARTMENT
 WHERE
	   DEPT_CODE = DEPT_ID(+); -- 기준으로 안삼고 싶은 애한테 (+)를 붙여야합니다.
	   -- 반대로 움직이는 느낌이 드네ㅠ_ㅠ

	  
-- 2) RIGHT [ OUTER ] JOIN : 두 테이블 중 오른편에 기술한 테이블을 기준으로 JOIN
-- 일치하는 컬럼이 존재하지 않더라도 오른쪽 테이블의 데이터는 무조건 다 조회한다.

--> ANSI 구문
SELECT
   	   EMP_NAME
	 , DEPT_TITLE
  FROM
	   EMPLOYEE
 RIGHT
  JOIN
	   DEPARTMENT ON (DEPT_CODE = DEPT_ID);
	   
	   
	   
--> 오라클 구문	   
SELECT
	   EMP_NAME
	 , DEPT_TITLE
  FROM
	   EMPLOYEE  
	 , DEPARTMENT -- 얘를(오른쪽) 기준삼고 싶어 / 기준 안삼고 싶은 애 컬럼한테 (+) 붙이자
 WHERE
	   DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [ OUTER ] JOIN : 두 테이블을 가진 모든 행을 조회할 수 있는 조인
--> ANSI 구문
SELECT
	   EMP_NAME
	 , DEPT_TITLE
  FROM
	   EMPLOYEE
  FULL
 OUTER
  JOIN
	   DEPARTMENT ON (DEPT_CODE = DEPT_ID);



--> ORACLE 에선 안된다. 낚였다.
/*
SELECT
EMP_NAME
, DEPT_TITLE
FROM
EMPLOYEE
WHERE
DEPT_CODE(+) = DEPT_ID(+);
*/
-------------------------------------------------------------------------------------------------------------------------
/*
 *3. 카테시안 곱(CARTESIAN PRODUCT) / 교차조인(CROSS JOIN) 
 * 모든 테이블의 각 행들을 서로서로 매칭해서 조회된(곱집합) ** 사용금지 문법
 * 
 * 두 테이블의 행들이 곱해진 조합을 뽑아냄 => 데이터가 많을 수록 방대한 행이 생겨난다.
 * => 과부하의 위험
 */

--> ORACLE
SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE, DEPARTMENT;
--									23			9       = 207행이 나온다

--> ANSI
SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE CROSS JOIN DEPARTMENT;

------------------------------------------------------------------------------------------------------------------------
/*
 * 4. 비등가 조인(NON EQUAL JOIN)
 * '=' 이퀄 싸인을 안쓰는 조인이다.
 * 
 * 컬럼값을 비교하는 경우가 아니라 "범위"에 포함되는 내용을 매칭 
 */

-- EMPLOYEE 테이블로부터 사원명, 급여
SELECT
	   EMP_NAME
	 , SALARY
  FROM
	   EMPLOYEE;

-- EMPLOYEE 테이블로부터 사원명, 급여
SELECT
	   EMP_NAME
	 , SALARY
  FROM
	   EMPLOYEE;

SELECT * FROM SAL_GRADE

--> ORACLE
SELECT
	   EMP_NAME
	 , SALARY	 
	 , SAL_GRADE.SAL_LEVEL
  FROM
	   EMPLOYEE
	 , SAL_GRADE
 WHERE
 	   SALARY BETWEEN MIN_SAL AND MAX_SAL;

--> ANSI
SELECT
	   EMP_NAME
	 , SALARY
	 , SAL_GRADE.SAL_LEVEL
  FROM
	   EMPLOYEE
  JOIN
	   SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

-----------------------------------------------------------------------------------------------------------------------
/*
 * 5. 자체조인(SELF JOIN)
 * 
 * 같은 테이블을 다시 한 번 조인하는 경우
 * 자기자신의 테이블과 조인을 맺음 (왜?????????????????????)
 */

SELECT
	   EMP_ID "사원 번호"
	 , EMP_NAME "사원 이름"
	 , PHONE "전화번호"
	 , MANAGER_ID "사수 사번"
  FROM
	   EMPLOYEE;

SELECT EMP_ID, EMP_NAME, PHONE, MANAGER_ID FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE;

--> ORACLE
-- 사원사번, 사원명, 사원 폰번호, 사수번호
-- 사수사번, 사수명, 사수 폰번호
SELECT
	   E.EMP_ID, E.EMP_NAME, E.PHONE, E.MANAGER_ID,
	   M.EMP_ID, M.EMP_NAME, M.PHONE
FROM
	   EMPLOYEE E,
	   EMPLOYEE M
WHERE 
	   E.MANAGER_ID = M.EMP_ID(+);



--> ANSI
SELECT
	   E.EMP_ID, E.EMP_NAME, E.PHONE, E.MANAGER_ID,
	   M.EMP_ID, M.EMP_NAME, M.PHONE
  FROM
	   EMPLOYEE E
  LEFT
  JOIN 
	   EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

-----------------------------------------------------------------------------------------------------------------
/*
 * < 다중 JOIN >
 */
-- 사원명(EMP_NAME) + 부서명(DEPT_TITLE) + 직급명(JOB_NAME) + 지역명(LOCAL_NAME) LOCATION

SELECT * FROM EMPLOYEE;   -- EMP_NAME    DEPT_CODE  JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_TITLE  DEPT_ID			   LOCAION_ID
SELECT * FROM JOB; 		  -- JOB_NAME			    JOB_CODE
SELECT * FROM LOCATION;   -- LOCAL_NAME						   LOCAL_CODE



--> ANSI
SELECT
	   EMP_NAME
	 , DEPT_TITLE
	 , JOB_NAME
	 , LOCAL_NAME
  FROM
	   EMPLOYEE E
	   /*
  JOIN
  */	   
  LEFT	
  JOIN
	   DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  --LEFT	
  JOIN
	   JOB USING (JOB_CODE)
  LEFT	   
  JOIN 
  	   LOCATION ON (LOCATION_ID = LOCAL_CODE);



--> ORACLE
SELECT
	   EMP_NAME
	 , DEPT_TITLE
	 , JOB_NAME
	 , LOCAL_NAME
  FROM
	   EMPLOYEE E
	 , DEPARTMENT
	 , JOB J
	 , LOCATION
 WHERE
	   DEPT_CODE = DEPT_ID(+)
   AND
	   LOCATION_ID = LOCAL_CODE(+)
   AND
	   E.JOB_CODE = J.JOB_CODE;
-------------------------------------------- 조인 끝!!!!!!!!!!!!!!! -------------------------------------------------

-- 하는 김에 JOIN 이랑 비슷한 친구도 다뤄봅시다 !

/*
 * < 집합 연산자 SET OPERATOR >
 * 조인이랑 결이 조금 다르긴 해요.
 * 합집합, 교집합, 차집합(????????????????????????)
 * 
 * 여러 개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
 * 
 * - UNION : 합집합(두 쿼리문의 수행 결과값을 더한 후 중복되는 부분을 제거)
 * - INTERSECT : 교집합(두 쿼리문의 수행 결과값 중에서 중복된 부분)
 * - MINUS : 차집합(선행 쿼리문 결과값 빼기 후행 쿼리문 결과값을 한 결과)
 *
 * - UNION ALL : 합집합의 결과에 교집합을 더한 개념
 * (두 쿼리문을 수행한 결과값을 무조건 더함. 합집합에서 중복 제거를 하지 않는 것)
 * => 중복행이 여러 번 조회될 수 있음
 * 
 * 솔직히 말씀드려요. 앞에 세 개는 쓰잘데기 없어요.
 * 유니온 올만 기억하세요^~^ "UNION ALL" 
 * 자주 필요한 건 아니고 인생을 살다가 한 번쯤은 필요해.
 */

-- 1. UNION
-- 부서코드가 D5인 사원들을 조회하는 셀렉문이 있구요.
SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , SALARY
  FROM
	   EMPLOYEE
 WHERE
	   DEPT_CODE = 'D5'; -- 박세혁, 박수현, 박채형, 박현준, 배주영, 유성현 (여섯명)
	   
-- 급여가 300만원 초과인 사원들
SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , SALARY
  FROM
	   EMPLOYEE
 WHERE
	   SALARY > 3000000; -- 이승철, 강병준, 강현성, 박성민, 박현준, 유성현, 채정민, 신국희 (여덟명)

-- 위의 두 개의 쿼리값을 합치고 싶어요!

-- UNION 사용 !
SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , SALARY
  FROM
	   EMPLOYEE
 WHERE
	   DEPT_CODE = 'D5'
UNION
SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , SALARY
  FROM
	   EMPLOYEE
 WHERE
	   SALARY > 3000000; -- 여섯명과 여덟명의 정보 중에 중복된 건 날아가고 나머지 결과들은 합쳐서 출력
	   					 -- 열 두 사람

-- OR
SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , SALARY
  FROM
	   EMPLOYEE
 WHERE
	   DEPT_CODE = 'D5'
	OR
	   SALARY > 3000000;	
	   
-- 셀렉트의 컬럼이 같다면 유니온 사용할 바에 "OR" 쓰면 됩니다.

-- 부서코드가 D1, D2, D5인 부서의 급여합계를 조회하고 싶다.
SELECT
	   SUM(SALARY)
  FROM
	   EMPLOYEE
 WHERE 
	   DEPT_CODE = 'D1';

SELECT
	   SUM(SALARY)
  FROM
	   EMPLOYEE
 WHERE 
	   DEPT_CODE = 'D2';

SELECT
	   SUM(SALARY)
  FROM
	   EMPLOYEE
 WHERE 
	   DEPT_CODE = 'D5';





--------- 합치려면 ?
SELECT
	   SUM(SALARY)
  FROM
	   EMPLOYEE
 WHERE 
	   DEPT_CODE = 'D1'
UNION
SELECT
	   SUM(SALARY)
  FROM
	   EMPLOYEE
 WHERE 
	   DEPT_CODE = 'D2'
UNION
SELECT
	   SUM(SALARY)
  FROM
	   EMPLOYEE
 WHERE 
	   DEPT_CODE = 'D5';
-- 이것도 별로군.


-- 이게 더 낫네ㅠ_ㅠ
SELECT
	   SUM(SALARY)
  FROM
	   EMPLOYEE
 WHERE 
	   DEPT_CODE IN ('D1', 'D2', 'D5')
 GROUP 
    BY DEPT_CODE;
------------------------------------------------------------------------------------------------------------------------
-- 2. UNION ALL : 여러 개의 쿼리 결과를 무조건!!!!!! 합치는 연산자(중복 가능)
SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , SALARY
  FROM 
	   EMPLOYEE
 WHERE
	   DEPT_CODE = 'D5'
 UNION
   ALL
SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , SALARY
  FROM
	   EMPLOYEE
 WHERE
	   SALARY > 3000000;
-- 이건 한번쯤은 쓸 일이 있으니 기억해주세요! 대체불가

-------------------------------------------------------------------------------------------------------------------
-- 3. INTERSECT (교집합 :선행 쿼리와 후행 쿼리가 겹치는 부분만)

SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , SALARY
  FROM 
	   EMPLOYEE
 WHERE
	   DEPT_CODE = 'D5'
INTERSECT
SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , SALARY
  FROM
	   EMPLOYEE
 WHERE
	   SALARY > 3000000;




-- 하지만......AND로 대체 가능하죠.
SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , SALARY
  FROM 
	   EMPLOYEE
 WHERE
	   DEPT_CODE = 'D5'
   AND	   
	   SALARY > 3000000;

------------------------------------------------------------------------------------------
-- 4. MINUS(차집합 - 선행쿼리 결과에서 후행 쿼리결과를 뺀 나머지)
SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , SALARY
  FROM 
	   EMPLOYEE
 WHERE
	   DEPT_CODE = 'D5'
MINUS
SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , SALARY
  FROM
	   EMPLOYEE
 WHERE
	   SALARY > 3000000;

-- 사실 이렇게 쓰면 되는 거죠ㅠ_ㅠ 차집합 별로죠.
SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , SALARY
  FROM 
	   EMPLOYEE
 WHERE
	   DEPT_CODE = 'D5'
   AND
  	   SALARY <= 3000000;

-----------------------------------------------------------------------------------------------------------------





