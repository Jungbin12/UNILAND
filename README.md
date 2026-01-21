# 🏠 UNILAND (대학생 맞춤형 부동산 중개 플랫폼)

> **"처음 자취를 시작하는 대학생들을 위한 예산/거리/편의성 기반 맞춤형 매물 추천 서비스"**
> 기존 부동산 플랫폼의 복잡함을 걷어내고, 대학생의 생활 패턴과 예산에 최적화된 주거 솔루션을 제공합니다.

---

## 📽️ 프로젝트 발표 자료 (PDF)
프로젝트의 기획 의도, 시스템 아키텍처, 핵심 기능 시연 화면이 포함된 상세 자료입니다.
* [**👉 UNILAND 프로젝트 발표 PDF 보기**](https://github.com/Jungbin12/UNILAND/blob/master/%EC%84%B8%EB%AF%B8%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8%20UNILAND(%EB%B0%9C%ED%91%9C).pdf) 

---

## 1. 개요 및 배경
* 📅 **수행 기간**: 2024.09.27 ~ 2024.10.31 (팀 프로젝트)
* 🎯 **주요 타깃**: 대학 주변 매물 정보가 필요한 대학생
* ✅ **핵심 목표**:
    * **AI 자연어 검색**을 통한 직관적인 매물 탐색
    * 예산 계산기 및 **카카오맵 API** 기반 지도 시각화
    * 사용자 / 중개사 / 관리자 **권한별 맞춤 기능** 제공

---

## 2. 사용 기술 (Tech Stack)

| 분류 | 기술 스택 |
| :--- | :--- |
| **Language** | `Java`, `JavaScript`, `HTML5`, `CSS3` |
| **Framework** | `Spring Boot`, `MyBatis` |
| **Database** | `Oracle Cloud DB` |
| **API** | `OpenAI GEMINI` (AI 검색), `Kakao Map API`, `국토교통부 실거래가 API` |
| **Server/Tool** | `Apache Tomcat`, `GitHub`, `SQL Developer` |

---

## 3. 핵심 담당 기능 (Individual Role)
> **"관리자 운영 효율을 극대화하기 위해 데이터 처리 구조를 설계하고, SQL 최적화를 통해 시스템 응답 속도를 70% 이상 개선했습니다."**

### ✅ 관리자 통합 대시보드 및 중개사 관리 (Full-stack)
* **기능 설명**: 신규 매물 승인, 중개사 권한 부여, 전체 회원 상태를 한눈에 관리할 수 있는 통합 대시보드를 구축했습니다.
* **화면 구현**: 
   - ➀ 중개사 승인 프로세스: 가입 신청한 중개사의 자격 증명을 확인하고 승인/반려하는 워크플로우를 구현했습니다.
   - ➁ 비동기 상태 업데이트: AJAX를 통해 페이지 이동 없이 즉각적으로 중개사 권한을 변경할 수 있도록 설계했습니다.
* **권한 시스템**: `Spring MVC` 패턴 기반 중개사 승인 프로세스 및 전체 데이터 관리 로직 구현
* **필수 코드 (권한 제어 및 비동기 처리)**:
> 중개사 승인 시 보안을 위해 서버 단에서 권한 체크 후 MyBatis를 통해 상태 값을 업데이트하는 핵심 로직입니다.

```java
/* [Back-end] 중개사 승인 및 권한 상태 변경 로직 (MyBatis 활용) */
@Transactional
public int approveBroker(String brokerId) {
    // 1. 중개사 상태를 '승인(Y)'으로 업데이트
    int result = adminMapper.updateBrokerStatus(brokerId, "Y");
    
    // 2. 승인 성공 시, 해당 계정의 접근 권한(Role)을 'BROKER'로 상향
    if(result > 0) {
        adminMapper.updateUserRole(brokerId, "ROLE_BROKER");
    }
    return result;
}

/* [Front-end] AJAX를 이용한 비동기 권한 변경 요청 */
function handleApprove(brokerId) {
    if(confirm("해당 중개사를 승인하시겠습니까?")) {
        $.ajax({
            url: "/admin/approve",
            type: "POST",
            data: { id: brokerId },
            success: function(res) {
                alert("승인이 완료되었습니다.");
                location.reload(); // 변경된 상태값 반영
            }
        });
    }
}
```

### ✅ 데이터 조회 성능 최적화 (Performance Tuning)
* **기능 설명**: 관리자 페이지 내 대용량 매물/회원 데이터 조회 시 발생하던 5초 이상의 로딩 지연을 해결했습니다.
* **최적화 포인트**:
   - ➀ 복잡한 JOIN 개선: 3개 이상의 테이블(회원, 중개사, 매물)이 얽힌 쿼리를 인라인 뷰와 필요한 컬럼만 추출하는 방식으로 재설계했습니다.
   - ➁ 인덱스 전략: 검색 조건으로 자주 사용되는 '회원 등급', '가입일' 컬럼에 인덱스를 적용하여 Full Table Scan을 방지했습니다.
* **필수 코드 (SQL 최적화)**:
> 불필요한 전체 조인을 피하고, 페이징 처리를 최적화하여 응답 속도를 70% 단축시킨 쿼리 구조입니다.

```xml
<select id="selectMemberList" resultType="MemberVO">
    SELECT * FROM (
        SELECT 
            ROWNUM AS rnum, 
            t.* FROM (
            SELECT 
                m.user_id, m.user_name, m.reg_date,
                b.broker_name, b.status
            FROM member m
            LEFT JOIN broker b ON m.user_id = b.user_id -- 필요한 정보만 선택적 Join
            WHERE m.del_flag = 'N'
            <if test="searchKeyword != null">
                AND m.user_id LIKE '%' || #{searchKeyword} || '%'
            </if>
            ORDER BY m.reg_date DESC
        ) t
        WHERE ROWNUM &lt;= #{endRow}
    )
    WHERE rnum &gt;= #{startRow} -- 인덱스를 타는 효율적인 페이징 처리
</select>
```

---

## 4. 트러블 슈팅 (Problem Solving)

### 🚀 데이터 조회 속도 지연 해결 (**성능 70% 향상**)
* **문제**: 더미 데이터 증가 및 3개 이상의 테이블 Join으로 인해 관리자 페이지 로딩이 **5초 이상 지연**.
* **분석**: SQL 실행 계획 분석 결과, 대량의 Full Table Scan과 불필요한 반복 쿼리 확인.
* **해결**: 
    1.  **SQL 쿼리 최적화**: 서브쿼리를 Join으로 변경하여 부하 분산.
    2.  **인덱스(Index) 적용**: 빈번하게 조회되는 컬럼에 인덱스 설정.
    3.  **AJAX 비동기 통신**: 대용량 리스트 로딩 시 비동기 방식을 채택해 체감 속도 향상.
* **결과**: 데이터 응답 속도를 **70% 이상 개선**하여 쾌적한 관리 환경 제공.

---

## 5. 협업 및 성장 경험
* **Git 전략**: 브랜치 관리 및 `PR(Pull Request)` 리뷰 프로세스 참여로 코드 무결성 유지.
* **코드 품질**: `MyBatis` 매퍼 네이밍 규칙 정의 및 공통 `ResultMap` 설계를 통해 유지보수성 확보.
* **소감**: 
    > *"문제의 본질을 분석하고 기술적으로 성능을 개선하는 과정에서 개발자로서의 큰 성장을 느꼈습니다. 특히 성능 최적화 경험은 데이터 설계의 중요성을 깊이 깨닫는 계기가 되었습니다."*
