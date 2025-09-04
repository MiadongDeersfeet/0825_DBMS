SELECT
	   *
  FROM
       EMPLOYEE;


-- 회원 전체 조회 --
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , DEPT_TITLE
     , JOB_NAME
  FROM
       EMPLOYEE E
  	 , DEPARTMENT D
  	 , JOB J
 WHERE
       E.DEPT_CODE = D.DEPT_ID
   AND
       E.JOB_CODE = J.JOB_CODE;
       
-- 부서별 조회 --
SELECT
       EMP_NAME
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON(DEPT_ID = DEPT_CODE)
 WHERE
       DEPT_TITLE = '총무부';

-- 직급별 조회 --
SELECT
       EMP_NAME
  FROM
  	   EMPLOYEE 
  JOIN
       JOB USING(JOB_CODE)
 WHERE
       JOB_NAME = '과장';

-- 사번으로 모든 컬럼 값 조회 --
SELECT
       *
  FROM
       EMPLOYEE
 WHERE
       EMP_ID = 200;

-- 급여가 높은 상위 다섯명 조회 --
	      -- 8,715,000쌤 / 7,875,000국희 / 5,250,000병준 / 5,250,000태호 / 현성 4,935,000
SELECT
	   EMP_NAME
	 , SALARY
  FROM
	   EMPLOYEE
 ORDER
	BY
	   SALARY DESC NULLS LAST
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- 급여가 낮은 하위 다섯명 조회 -- // 하늘 105, 예성 105, 안준영 1,449,000 , 현금자 1,627,500, 박세혁 1,890,000
SELECT
	   EMP_NAME
	 , SALARY
  FROM
       EMPLOYEE
 ORDER
    BY
       SALARY ASC NULLS LAST
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;       

-- 사원추가
INSERT
  INTO
       EMPLOYEE
VALUES 
   	   (
       ? -- EMP_ID
     , ? -- EMP_NAME
     , ? -- EMP_NO
     , ? -- EMAIL
     , ? -- PHONE
     , SYSDATE -- HIRE_DATE
       )

       

 
 SELECT
	   *
  FROM
       EMPLOYEE;
    
     
     
     
SELECT
 	   *
  FROM
       DEPARTMENT;



SELECT
	   *
  FROM
  	   JOB;
