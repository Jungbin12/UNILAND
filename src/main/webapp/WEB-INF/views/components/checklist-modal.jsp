<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 입주 점검표 모달 -->
<div class="modal-overlay" id="checklistModalOverlay" onclick="closeChecklistModal()"></div>

<div class="modal-container" id="checklistModal">
    <div class="modal-header">
        <h2>원룸/오피스텔 입주 점검표</h2>
        <div class="property-info-box">
            <div class="info-row">
                <span>매물 주소:</span>
                <span class="memo-line">_____________________________________________</span>
            </div>
            <div class="info-row">
                <span>방문 일시:</span>
                <span class="memo-line">________년 ____월 ____일 ____시</span>
            </div>
            <div class="info-row">
                <span>중개사:</span>
                <span class="memo-line">________________</span>
                <span style="margin-left: 20px;">연락처:</span>
                <span class="memo-line">______________________</span>
            </div>
        </div>
    </div>

    <div class="modal-body">
        <!-- 수도/전기/가스 -->
        <div class="checklist-section">
            <h3>수도 / 전기 / 가스</h3>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>수압 확인 (샤워기, 세면대, 싱크대 직접 틀어보기)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>온수 나오는지 확인 (온수기 작동 확인)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>배수구 막힘 여부 (싱크대, 세면대, 욕실)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>화장실 환기팬 작동 확인</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>전기 콘센트 위치 및 개수 (부족하지 않은지)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>모든 조명 켜지는지 확인</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>가스레인지 점화 및 불 세기 확인</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>보일러 작동 여부 (난방 테스트)</span>
            </div>
        </div>

        <!-- 보안/안전 -->
        <div class="checklist-section">
            <h3>보안 / 안전</h3>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>현관 도어락 작동 (배터리 상태 확인)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>창문 잠금장치 및 방범창 설치 여부</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>건물 출입구 CCTV 유무</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>소화기 비치 여부</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>1층 여부 (방범 취약 확인)</span>
            </div>
        </div>

        <!-- 실내 상태 -->
        <div class="checklist-section">
            <h3>실내 상태</h3>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>벽지/도배 상태 (찢어짐, 얼룩 확인)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>바닥 (장판, 마루) 상태</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>곰팡이 흔적 (창문틀, 벽 모서리, 화장실)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>누수 흔적 (천장, 벽, 싱크대 하부)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>채광 (햇빛 잘 들어오는지)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>통풍 (맞바람, 창문 위치 확인)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>냄새 확인 (하수구, 곰팡이 냄새)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>에어컨 설치 여부 및 작동 확인</span>
            </div>
        </div>

        <!-- 옵션/가구 -->
        <div class="checklist-section">
            <h3>옵션 / 가구</h3>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>냉장고 (크기 및 작동 확인)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>세탁기 (설치 위치 및 작동 확인)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>전자레인지</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>침대/책상/옷장 상태</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>신발장</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>커튼/블라인드</span>
            </div>
        </div>

        <!-- 소음/주변환경 -->
        <div class="checklist-section">
            <h3>소음 / 주변 환경</h3>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>층간 소음 (위층 발자국 소리)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>옆집 소음 (벽 두께 확인)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>도로/차량 소음</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>유흥업소 거리 (술집, 노래방)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>편의점/마트 도보 거리</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>지하철/버스 정류장 거리</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>학교까지 소요 시간</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>밤 늦게 혼자 걸어도 안전한지</span>
            </div>
        </div>

        <!-- 인터넷/통신 -->
        <div class="checklist-section">
            <h3>인터넷 / 통신</h3>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>인터넷 설치 가능 통신사 확인</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>휴대폰 신호 강도 (SKT, KT, LG)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>공유기 설치 예정 위치</span>
            </div>
        </div>

        <!-- 계약/비용 -->
        <div class="checklist-section">
            <h3>계약 / 비용</h3>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>월세: _________만원 / 보증금: _________만원</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>관리비: _________만원 (포함 항목: ____________________________)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>입주 가능일: ________년 ____월 ____일</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>중개 수수료 확인 (보통 월세의 50%)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>수리 약속 받은 사항: _____________________________________________</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>단기 계약 가능 여부 (6개월/1년)</span>
            </div>
        </div>

        <!-- 기타 확인사항 -->
        <div class="checklist-section">
            <h3>기타 확인사항</h3>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>쓰레기 배출 장소 및 요일</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>택배 수령 방법 (무인택배함, 경비실)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>주차 가능 여부 (있으면 월 주차비: _______만원)</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>반려동물 가능 여부</span>
            </div>
            <div class="checklist-item">
                <span class="checkbox">☐</span>
                <span>엘리베이터 유무 (몇 층인지: ______층)</span>
            </div>
        </div>

        <!-- 메모 공간 -->
        <div class="memo-section">
            <h3>추가 메모</h3>
            <div class="memo-area">
                <div class="memo-line-full">_______________________________________________________________________________</div>
                <div class="memo-line-full">_______________________________________________________________________________</div>
                <div class="memo-line-full">_______________________________________________________________________________</div>
                <div class="memo-line-full">_______________________________________________________________________________</div>
                <div class="memo-line-full">_______________________________________________________________________________</div>
            </div>
        </div>

        <!-- 팁 박스 -->
        <div class="tip-box">
            <strong>체크 포인트</strong>
            <ul>
                <li>낮/밤, 평일/주말에 소음 정도가 다르니 가능하면 여러 시간대에 방문하세요!</li>
                <li>사진을 많이 찍어두면 나중에 비교할 때 좋아요.</li>
                <li>수도꼭지를 10초 이상 틀어서 수압을 제대로 확인하세요.</li>
                <li>핸드폰 전등을 켜서 벽 모서리와 천장을 비춰보면 곰팡이를 찾기 쉬워요.</li>
            </ul>
        </div>
    </div>

    <div class="modal-footer">
        <button class="modal-btn modal-btn-print" onclick="printChecklist()">
            인쇄하기
        </button>
        <button class="modal-btn modal-btn-close" onclick="closeChecklistModal()">
            닫기
        </button>
    </div>
</div>

<style>
    /* 모달 스타일 */
    .modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.6);
        z-index: 9998;
        animation: fadeIn 0.3s;
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    .modal-container {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: white;
        border-radius: 16px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        z-index: 9999;
        max-width: 800px;
        width: 90%;
        max-height: 90vh;
        overflow-y: auto;
        animation: slideUp 0.3s;
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translate(-50%, -40%);
        }
        to {
            opacity: 1;
            transform: translate(-50%, -50%);
        }
    }

    .modal-header {
        background: #f8f8f8;
        color: #333;
        padding: 30px;
        border-radius: 16px 16px 0 0;
        border-bottom: 3px solid #333;
        text-align: center;
    }

    .modal-header h2 {
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 20px;
    }

    /* 매물 정보 박스 */
    .property-info-box {
        background: white;
        border: 2px solid #666;
        border-radius: 8px;
        padding: 20px;
        margin-top: 20px;
    }

    .info-row {
        display: flex;
        align-items: center;
        margin-bottom: 12px;
        font-size: 14px;
        color: #333;
    }

    .info-row:last-child {
        margin-bottom: 0;
    }

    .info-row > span:first-child {
        font-weight: 600;
        margin-right: 10px;
        min-width: 70px;
    }

    .memo-line {
        color: #666;
        font-family: monospace;
        letter-spacing: 1px;
    }

    .modal-body {
        padding: 30px;
    }

    .checklist-section {
        margin-bottom: 30px;
    }

    .checklist-section h3 {
        font-size: 18px;
        font-weight: 700;
        color: #333;
        margin-bottom: 15px;
        padding-bottom: 10px;
        border-bottom: 2px solid #333;
    }

    .checklist-item {
        display: flex;
        align-items: flex-start;
        gap: 12px;
        padding: 10px 12px;
        margin-bottom: 6px;
        border-radius: 6px;
        transition: background 0.2s;
    }

    .checklist-item:hover {
        background: #f5f5f5;
    }

    /* 체크박스 아이콘 */
    .checkbox {
        font-size: 18px;
        color: #333;
        font-weight: 400;
        line-height: 1.5;
        user-select: none;
    }

    .checklist-item > span:last-child {
        flex: 1;
        font-size: 15px;
        color: #444;
        line-height: 1.5;
    }

    /* 메모 섹션 */
    .memo-section {
        margin-top: 40px;
        padding: 25px;
        background: #f9fafb;
        border: 2px dashed #d1d5db;
        border-radius: 8px;
    }

    .memo-section h3 {
        font-size: 18px;
        font-weight: 700;
        color: #333;
        margin-bottom: 15px;
    }

    .memo-area {
        padding: 10px 0;
    }

    .memo-line-full {
        font-family: monospace;
        color: #9ca3af;
        letter-spacing: 0.5px;
        margin-bottom: 12px;
        font-size: 14px;
    }

    /* 팁 박스 */
    .tip-box {
        margin-top: 25px;
        padding: 20px;
        background: #f5f5f5;
        border: 2px solid #666;
        border-radius: 8px;
    }

    .tip-box strong {
        font-size: 16px;
        color: #333;
        display: block;
        margin-bottom: 12px;
    }

    .tip-box ul {
        list-style: none;
        padding-left: 0;
    }

    .tip-box ul li {
        font-size: 14px;
        color: #444;
        line-height: 1.8;
        margin-bottom: 8px;
        padding-left: 20px;
        position: relative;
    }

    .tip-box ul li:before {
        content: "•";
        position: absolute;
        left: 5px;
        color: #333;
        font-weight: bold;
    }

    .modal-footer {
        padding: 20px 30px;
        border-top: 1px solid #e5e5e5;
        display: flex;
        gap: 12px;
        justify-content: flex-end;
    }

    .modal-btn {
        padding: 12px 24px;
        border: none;
        border-radius: 8px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s;
    }

    .modal-btn-print {
        background: #333;
        color: white;
    }

    .modal-btn-print:hover {
        background: #555;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    }

    .modal-btn-close {
        background: #f5f5f5;
        color: #666;
    }

    .modal-btn-close:hover {
        background: #e5e5e5;
    }

    /* 인쇄 스타일 */
    @media print {
        @page {
            size: A4;
            margin: 15mm;
        }

        body * {
            visibility: hidden;
        }

        .modal-container, .modal-container * {
            visibility: visible;
        }

        .modal-container {
            position: absolute;
            left: 0;
            top: 0;
            transform: none;
            box-shadow: none;
            max-width: 100%;
            max-height: none;
            border-radius: 0;
        }

        .modal-footer, .modal-overlay {
            display: none !important;
        }

        .modal-header {
            background: white !important;
            color: #333 !important;
            border-bottom: 3px solid #333;
            padding: 20px;
        }

        .property-info-box {
            background: white !important;
            border: 2px solid #666 !important;
            padding: 15px;
            margin-top: 15px;
        }

        .info-row {
            color: #333 !important;
            margin-bottom: 8px;
        }

        .memo-line {
            color: #666 !important;
        }

        .modal-body {
            padding: 20px;
        }

        .checklist-section {
            page-break-inside: avoid;
            margin-bottom: 20px;
        }

        .checklist-section h3 {
            color: #333 !important;
            border-bottom: 2px solid #333 !important;
            page-break-after: avoid;
        }

        .checklist-item {
            page-break-inside: avoid;
            padding: 8px 10px;
            margin-bottom: 5px;
            border: 1px solid #e5e5e5;
        }

        .checklist-item:hover {
            background: none;
        }

        .checkbox {
            color: #333 !important;
            font-size: 16px;
        }

        .memo-section {
            page-break-inside: avoid;
            background: white !important;
            border: 2px dashed #999 !important;
            margin-top: 20px;
        }

        .memo-line-full {
            color: #999 !important;
        }

        .tip-box {
            page-break-inside: avoid;
            background: white !important;
            border: 2px solid #666 !important;
            margin-top: 15px;
        }

        .tip-box strong {
            color: #333 !important;
        }

        .tip-box ul li {
            color: #444 !important;
        }

        .tip-box ul li:before {
            color: #333 !important;
        }
    }
</style>

<script>
    // 모달 열기
    function openChecklistModal() {
        document.getElementById('checklistModalOverlay').style.display = 'block';
        document.getElementById('checklistModal').style.display = 'block';
        document.body.style.overflow = 'hidden'; // 스크롤 방지
    }

    // 모달 닫기
    function closeChecklistModal() {
        document.getElementById('checklistModalOverlay').style.display = 'none';
        document.getElementById('checklistModal').style.display = 'none';
        document.body.style.overflow = 'auto'; // 스크롤 복구
    }

    // 인쇄하기
    function printChecklist() {
        window.print();
    }

    // ESC 키로 모달 닫기
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeChecklistModal();
        }
    });
</script>
