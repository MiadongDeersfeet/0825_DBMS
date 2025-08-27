/*
 * < SUB QUERY 서브쿼리 >
 *  
 * 하나의 메인 SQL(SELECT, INSERT, UPDATE, DELETE, CREATE, ...)안에 포함된
 * 또 하나의 SELECT문
 * 
 * MAIN SQL문의 보조역할을 하는 쿼리문
 */

-- 간단 서브쿼리 예시
SELECT * FROM EMPLOYEE;
-- 박세혁 사원과 부서가 같은 사원들의 사원명 조회
-- 일단 박세혁 사원의 부서코드를 알아야겠네?

SELECT
	   DEPT_CODE
  FROM
	   EMPLOYEE
 WHERE
	   EMP_NAME = '박세혁'; -- D5
	   
-- 2) 부서코드가 D5인 사원들의 사원명 조회
SELECT
	   EMP_NAME
  FROM
	   EMPLOYEE
 WHERE
	   DEPT_CODE = 'D5';

-- 위 두 단계를 하나의 쿼리문으로 합치기
-- 박세혁이란 이름으로 D5를 알아낸 거죠.
-- 위에 쿼리의 결과로 이 쿼리가 나온 것이죠.
SELECT
	   EMP_NAME
  FROM 
	   EMPLOYEE
 WHERE 
	   DEPT_CODE = 'D5';



-- ↓ 같은 결과가 나오네~?
SELECT
	   EMP_NAME
  FROM 
	   EMPLOYEE
 WHERE 
	   DEPT_CODE = (SELECT
	  	                   DEPT_CODE
  					  FROM
	   					   EMPLOYEE
 					 WHERE
	   	 				   EMP_NAME = '박세혁');

-- 괄호 안에 있는 SQL문은 메인 쿼리를 사용하고 값을 얻어내기 위해서 보조로 사용하는 서브 쿼리입니다!!!!!!!!
-- 오라클의 과금 기준이 예를 들면 셀렉트를 몇 번 했느냐 ; 이런 부분이 있어서 연륜이 있으신 분들은 비용을 줄이기 위해 서브 쿼리를 사용해서 셀렉트문 수를 줄이는 것을 개발 실력으로 보기도 한다.

----------------------------------------------------------------------------------------------

-- 간단한 서브쿼리 예시 두 번째
-- 전체 사원의 평균 급여보다 더 많은 급여를 받고 있는 사원들의 사번, 사원명을 조회해보자

SELECT
	   AVG(SALARY)
  FROM
	   EMPLOYEE; -- 대략 3,131,140원

	   
	   
SELECT
	   EMP_ID
   	 , EMP_NAME
  FROM
	   EMPLOYEE
 WHERE
	   SALARY >= 3131140;



SELECT
	   EMP_ID
	 , EMP_NAME
  FROM
  	   EMPLOYEE
 WHERE
 	   SALARY >= (SELECT
	   	     			 AVG(SALARY)
	   				FROM
	   	    	  	     EMPLOYEE);
---------------------------------------------------------------------------------------------------------------------------------------------


SELECT
EMP_NAME
FROM
EMPLOYEE
WHERE
DEPT_CODE = (SELECT
					DEPT_CODE
	           FROM
	                EMPLOYEE
			  WHERE
					EMP_ID = (SELECT
	  	 	 	 	 		 	     EMP_ID
							    FROM
	  	 	 	 	 		 	     EMPLOYEE
	   	 	 	 	 	 	   WHERE
	   	 	 	 	 	             EMP_NAME = '박세혁'
								 AND 
									 DEPT_CODE = 'D5');

/*
 * 서브쿼리의 분류
 * 
 * 서브쿼리를 수행한 결과가 몇 행 몇 열이냐에 따라서 분류됨
 * 
 * - 단일행 [단일열] 서브쿼리			  -- 결과값이 딱 하나로 나오는 것   		   --> 서브쿼리 수행 결과가 딱 1개일 경우
 * - 다중행 [단일열] 서브쿼리			  -- 행은 여러 개 인데 컬럼은 딱 하나만 나오는 것  --> 서브쿼리 수행 결과가 여러 행일 때
 * - [단일열이 생략된] 다중열 서브쿼리 	  -- 열은 여러 개인데					   --> 서브쿼리 수행 결과가 여러 열일 때
 * - 다중행 다중열 서브쿼리			  -- 							       --> 서브쿼리 수행 결과가 여러 행, 여러 열일 때
 * 
 * => 수행 결과가 몇 행, 몇 열이냐에 따라서 사용할 수 있는 연산자가 다름
 */

/*
 * 1. 단일행 서브쿼리 (SINGLE ROW SUBQUERY)
 * 
 * 서브쿼리의 조회 결과값이 오로지 1개일 때
 * 
 * 일반 연산자 사용(=, !=, >, < ...)
 */
-- 전 직원의 평균 급여보다 적게 받는 사원들의 사원명, 전화번호 조회
-- 1. 평균 급여 구하기
SELECT
	   AVG(SALARY)
  FROM 
	   EMPLOYEE; -- 3,131,140원 / 결과값 : 오로지 1개의 값
	   

SELECT
	   EMP_NAME
	 , PHONE
  FROM
	   EMPLOYEE
 WHERE
	   SALARY < (SELECT
					    AVG(SALARY)
				   FROM
					    EMPLOYEE);

-- 최저급여를 받는 사원의 사번, 사원명, 직급코드, 급여, 입사일 조회
-- 1. 최저급여 구하기
SELECT
	   MIN(SALARY)
  FROM
	   EMPLOYEE;


SELECT
EMP_ID
, EMP_NAME
, JOB_CODE
, SALARY
, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT
					   MIN(SALARY)
				  FROM	
					   EMPLOYEE);
-- 안준영 사원의 급여보다 더 많은 급여를 받는 사원들의 사원명, 급여 조회
SELECT
	   SALARY
  FROM
	   EMPLOYEE
 WHERE
	   EMP_NAME = '안준영';

SELECT
	   EMP_NAME
	 , SALARY
  FROM
	   EMPLOYEE
 WHERE
	   SALARY > (SELECT
						SALARY
				   FROM
						EMPLOYEE
				  WHERE
						EMP_NAME = '안준영');


-- JOIN도 써먹어야죠.
-- 박수현 사원과 같은 부서인 사원들의 사원명, 전화번호, 직급명을 조회하는데 박수현 사원은 제외

SELECT * FROM EMPLOYEE; -- EMP_NAME    PHONE     JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID   DEPT_TITLE   LOCATION_ID 해외영업2부, d5
SELECT * FROM JOB; --     JOB_NAME               JOB_CODE


SELECT
	   EMP_NAME
	 , PHONE
	 , JOB_NAME
  FROM
	   EMPLOYEE 
  JOIN
  	   JOB  USING (JOB_CODE)
 WHERE
	   DEPT_CODE = (SELECT
						   DEPT_CODE
			          FROM
						   EMPLOYEE
			         WHERE
						   EMP_NAME = '박수현')
   AND
 	   EMP_NAME != '박수현';

-- 부서별 급여 합계가 가장 큰 부서의 부서명, 부서코드, 급여합계

SELECT
	   SUM(SALARY)
  FROM
	   EMPLOYEE
 GROUP
	BY
	   DEPT_CODE
 
 
-- 2. 부서별 급여합계 중 가장 큰 급여합 
SELECT
	   MAX(SUM(SALARY))
  FROM
	   EMPLOYEE
 GROUP
    BY
 	   DEPT_CODE; -- 18,000,000
  
-- 3.
 SELECT
 	    SUM(SALARY)
 	  , DEPT_CODE
	  , DEPT_TITLE
   FROM
	    EMPLOYEE
   JOIN
	    DEPARTMENT ON (DEPT_ID = DEPT_CODE)
  GROUP
     BY
     	DEPT_CODE,
        DEPT_TITLE
 HAVING
	    SUM(SALARY) = (SELECT
	    	                  MAX(SUM(SALARY))
	    	             FROM
	    	             	  EMPLOYEE
	    	            GROUP
	    	               BY
	    	               DEPT_CODE);
	    	             	 

-- FINAL METHOD => 오버라이딩 안됨 XX -- 파이널을 메소드에 달면 오버라이딩이 안되고
-- FINAL class => 상속 안됨 X -- 파이널을 클래스에 달면 상속이 안되고

----------------------------------------------------------------------------------------------------------------------------------------------
-- 자! 우리가 지금 하고 있는 작업의 목적이 무엇인가요!????
-- 왜 자바를 배우고나서 이걸 배우느냔 말이에요~~~~
-- Java 랑 DB 같이 쓸 때 필요한 개념들이 평가에 나와요~~앞에 개념을 잘 익혀야지 뒤에 개념과 잘 사용할 수 있는, 여러분은 자바 공부만 열심히 하면 돼요.

/*
 * 2. 다중 행 서브쿼리
 * 서브쿼리의 조회 결과값이 여러 행일 때
 * 
 * - IN(10, 20, 30) : 여러 개의 결과값 중 한 개라도 일치하는 값이 있다면
 */

-- 각 부서별로 최고급여를 받는 사원의 이름, 급여 조회

SELECT
	   MAX(SALARY)
  FROM 
	   EMPLOYEE
 GROUP
	BY
	 DEPT_CODE; -- 830, 390, 366, 255, 289, 376, 750
	 
SELECT * FROM EMPLOYEE;



SELECT
	   EMP_NAME
	 , SALARY
  FROM
	   EMPLOYEE
 WHERE
	   SALARY IN (SELECT
			     		 MAX(SALARY)
					FROM
				 	     EMPLOYEE
		   		   GROUP
			    	  BY
				 	     DEPT_CODE);

-- 이승철 사원 또는 선승제 사원과 같은 부서인 사원들의 사원명과 핸드폰 번호

SELECT * FROM EMPLOYEE; -- EMP_NAME, PHONE
-- 이승철 D9, 선승제 D8

SELECT
	   DEPT_CODE
  FROM 
  	   EMPLOYEE
 WHERE
	   EMP_NAME = '이승철' 
    OR 
	   EMP_NAME = '선승제';

-- 다시 해보자

SELECT
	   DEPT_CODE
  FROM
	   EMPLOYEE
 WHERE
	   EMP_NAME IN ('이승철', '선승제');


SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT
						  DEPT_CODE
						  FROM
						  EMPLOYEE
						  WHERE
						  EMP_NAME IN ('이승철', '선승제'));

	    
SELECT * FROM JOB;
-- 인턴(수습사원) < 사원 < 주임 < 대리 < 과장 < 차장 < 부장 < 부대표 < 대표

SELECT * FROM EMPLOYEE;
-- 대리직급임에도 불구하고 과장보다 급여를 많이 받는 대리가 존재한다!!

SELECT
	   SALARY 
  FROM
	   EMPLOYEE E
	 , JOB J
 WHERE  
 J.JOB_CODE = E.JOB_CODE
   AND
   JOB_NAME = '과장'; -- 220, 250, 232, 376, 750
   
 SELECT
 SALARY
 FROM
EMPLOYEE E
, JOB J
WHERE
J.JOB_CODE = E.JOB_CODE
AND
JOB_NAME = '대리'; -- 200, 255, 278, 366, 243

-- 2) 위의 급여보다 높은 급여를 받고 있는 대리의 사원명, 직급명, 급여
SELECT
	   EMP_NAME
	 , JOB_NAME
	 , SALARY
  FROM
	   EMPLOYEE E
	 , JOB J 
 WHERE
	   E.JOB_CODE = J.JOB_CODE
   AND
	   SALARY >  ANY(2200000, 2500000, 2320000)
-- SALARY > 2200000 OR SALARY > 2500000 OR
   AND
   	   JOB_NAME = '대리';

/*
SELECT
	   EMP_NAME
	 , JOB_NAME
	 , SALARY
  FROM
	   EMPLOYEE E
	 , JOB J 
 WHERE
	   E.JOB_CODE = J.JOB_CODE
   AND
	   SALARY >  ANY(SELECT
	   				        SALARY
	   				 FROM
	   				 	    EMPLOYEE
	   				 WHERE
	   				        E.JOB_CODE = J.JOB_CODE
					   AND
					   JOB_NAME = '대리');
	*/   				        
/*
 * X(컬럼) > ANY(값, 값, 값)
 * X의 값이 ANY 괄호 안의 값 중 하나라도 크면 참
 * 
 * > ANY(값, 값, 값) : 여러 개의 결과값 중 하나라도 "클"경우 참을 반환
 * 
 * > ANY(값, 값, 값) : 여러 개의 결과값 중 하나라도 "작을"경우 참을 반환
 */	   				        

-- 과장 직급인데 모든 차장 직급의 급여보다 더 많이 받는 직원

SELECT
	   SALARY
  FROM
	   EMPLOYEE
  JOIN
	   JOB USING(JOB_CODE)
 WHERE
	   JOB_NAME = '차장'; -- 280, 0, 155
	  
SELECT
	   EMP_NAME
  FROM
	   EMPLOYEE
  JOIN
	   JOB USING(JOB_CODE)
 WHERE
	   SALARY > ALL(SELECT 
						   SALARY
					  FROM 
						   EMPLOYEE
					  JOIN 
						   JOB USING(JOB_CODE) 
					 WHERE 
					 	   JOB_NAME = '차장') 
					   AND 
						   JOB_NAME = '과장';
-------------------------------------------------------------------------------------------------------
/*
 * 3. 다중 열 서브쿼리
 * 
 * 조회결과는 한 행이지만 나열된 컬럼의 수가 다수개일 때
 */

SELECT * FROM EMPLOYEE;
-- 박채형 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원들의 사원명, 부서코드, 직급코드 조회
-- D5, J5

SELECT 
	   DEPT_CODE
	 , JOB_CODE
  FROM
	   EMPLOYEE
 WHERE
	   EMP_NAME = '박채형'; -- D5 / J5

-- 사원명, 부서코드, 직급코드 / 부서코드 == D5 + 직급코드 == J5

SELECT
	   EMP_NAME
	 , DEPT_CODE
	 , JOB_CODE
  FROM
	   EMPLOYEE
 WHERE
	   (DEPT_CODE, JOB_CODE) = (SELECT
									   DEPT_CODE
									 , JOB_CODE
								  FROM	   
	   								   EMPLOYEE
	   							 WHERE
	   							       EMP_NAME = '박채형');

--------------------------------------------------------------------------------------------------------------------
/*
 * 4. 다중 행 다중 열 서브쿼리
 * 서브쿼리 수행 결과가 행도 많고 열도 많음
 */

-- 각 직급별로 최고 급여를 받는 사원들 조회(이름, 직급코드, 급여)

-- 아래 친구를 서브쿼리로 쓰고 싶은 거야
SELECT
	   JOB_CODE
	 , MAX(SALARY)
  FROM
	   EMPLOYEE
 GROUP
    BY
	   JOB_CODE; -- 750, 366, 500, 289, 280, 249, 830, 390
SELECT
EMP_NAME
, JOB_CODE
, SALARY
FROM
EMPLOYEE
WHERE
(JOB_CODE, SALARY) IN (SELECT
					          JOB_CODE
	 	  	 	 	 		, MAX(SALARY)
  						 FROM
	  						  EMPLOYEE
 						GROUP
    					   BY
	   						  JOB_CODE);
	   

/*
 * 5. 인라인 뷰(INLINE-VIEW)
 * 인라인 뷰는 많이 씁니다!!!
 * 
 * FROM 절에 서브쿼리를 작성
 * 
 * SELECT문의 수행결과(Result Set)을 테이블 대신 사용
 * 
 * 
 * 
 * 6. 스칼라 서브쿼리(Scalar Subquery)
 * 추천하지는 않는데 프로젝트 때 많이 쓰시더라구요.
 * 
 * 주로 SELECT 절에 사용하는 쿼리를 의미
 * 메인쿼리 실행마다 서브쿼리가 실행될 수 있으므로 성능이슈가 생길 수 있음
 * 그렇기 때문에 JOIN으로 대체하는 것이 "일반적으로는" 성능상 유리함
 *☆★ 단, 캐싱이 되기 때문에 동일한 결과에 대해선 성능상 JOIN보다 뛰어날 수도 있음 ☆★ -- 장점
 * 스칼라 쿼리는 반드시 단 한개의 값만을 반환해야함
 */
-- 스칼라 예시
-- 사원의 사원명과 부서명을 조회
SELECT
EMP_NAME
, DEPT_TITLE
FROM
EMPLOYEE
JOIN
DEPARTMENT ON (DEPT_CODE = DEPT_ID);


-- 이게 스칼라 파워
-- 근데 얘는 셀렉트 할 때 셀렉트 하는 행마다 수행이 또 들어가서 성능저하 이슈가 있어.
SELECT
EMP_NAME
, (SELECT DEPT_TITLE FROM DEPARTMENT WHERE E.DEPT_CODE = DEPT_ID)
FROM
EMPLOYEE E;


-- 인라인 뷰 가자!!!!!!!!!!! 간단하고 시원하게 써보자

-- 사원들의 이름, 보너스 포함 연봉 조회하고 싶음
-- 단, 보너스 포함 연봉이 4000만원 이상인 사원만 조회

/*
SELECT
EMP_NAME AS "사원이름"
, (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "보너스 포함 연봉"
FROM
EMPLOYEE
WHERE
"보너스 포함 연봉" > 40000000; ------> 웨어절이 셀렉절보다 먼저 수행되기 때문에 별칭 지어준 게 작동을 안함
*/

SELECT
	   "사원이름"
	 , "보너스 포함 연봉"
  FROM
	   (SELECT
	           EMP_NAME AS "사원이름"
		     , (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "보너스 포함 연봉"
		  FROM
	           EMPLOYEE)
		 WHERE
	           "보너스 포함 연봉" > 40000000;

--> 위와 같은 인라인 뷰는 어디에서 활용을 할 수 있을까요?
--> 인라인 뷰를 주로 사용하는 예(클래식)
--> TOP-N 분석 : DB상에 있는 값들 중 최상위 N개의 데이터를 보기 위해서 사용

SELECT * FROM EMPLOYEE;
-- 전 직원들 중 급여가 가장 높은 상위 5명 줄세우기 해서 조회

-- * ROWNUM : 오라클에서 자체적으로 제공해주는 컬럼, 조회된 순서대로 순번을 붙여줌
SELECT
EMP_NAME
, SALARY
, ROWNUM
FROM
EMPLOYEE;



SELECT					-- 3
	   ROWNUM
	 , EMP_NAME
	 , SALARY
  FROM					-- 1
	   EMPLOYEE
 WHERE				 	-- 2
	   ROWNUM <= 5
 ORDER					-- 4
    BY
	   SALARY DESC;


--> 이게 아주 클래식한 인라인 뷰 사용법
SELECT
	   EMP_NAME
	 , SALARY
  FROM
	   (SELECT
			   EMP_NAME
		     , SALARY
		  FROM
		       EMPLOYEE
		 ORDER 
		    BY
			   SALARY DESC)
 WHERE	
	   ROWNUM <= 5;
-----------------------------------------------------------------------------------------------------
-- 아 모던한 방법 쓰고 싶다.
SELECT
	   EMP_NAME
	 , SALARY
  FROM
	   EMPLOYEE
 ORDER
	BY
	   SALARY DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;	   
-- 앞 쪽에 몇 개의 행(0)을 건너뛸 건지
-- 건너뛴 다음 몇 개(5)행을 반환받을 건지
--> 0개를 건너 뛰고 그 다음 5행을 반환받겠다.
--> 근데 솔직히 말해서 우리가 오라클을 이렇게 쓰면, 프로그램에서는 클래식한 방법으로 바꿔서 올려요.


-----------------------------------------------    SELECT 문 끝 !!!!! --------------------------------------------------------------------------