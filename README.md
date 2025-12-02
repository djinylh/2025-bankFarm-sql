## 공통 코드 목록

### 상위 공통 코드
| super_cd_id | super_cd_nm           | super_cd_des |
| ----------- | --------------------- | ------------ |
| CS          | CONTRACT_STATUS       | 계약 상태        |
| AP          | AUTHORIZATION_PROCESS | 승인 상태        |
| AS          | ACCOUNT_STATUS        | 계좌 상태        |
| RG          | REGION                | 지역           |
| TX          | TRANSACTION           | 거래 상태        |
| BK          | BANK                  | 은행 코드        |
| CD          | CARD             | 카드           |
| AC          | ACCOUNT          | 계좌           |
| BR          | BRANCH           | 지점           |
| PD          | PRODUCT          | 상품           |
| OD          | OVERDUE          | 연체           |
| IN          | INSURANCE        | 보험           |
| LN          | LOAN             | 대출           |
| RT          | RATE             | 금리           |
| FX          | FOREIGN_EXCHANGE | 외환           |
| DO          | DEPOSIT          | 예/적금         |
| CO          | COUNSELING       | 상담           |

## 하위 공통 코드

### 계약 상태 코드 (CS)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| CS          | 001          | EFFECTIVE    | 유효            |
| CS          | 002          | EXPIRED      | 만기            |
| CS          | 003          | TERMINATED   | 해지            |
| CS          | 004          | SUSPENDED    | 효력 정지         |

### 승인 상태 코드 (AP)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| AP          | 001          | PENDING      | 대기 중          |
| AP          | 002          | APPROVED     | 승인            |
| AP          | 003          | REJECTED     | 거부            |
| AP          | 004          | CANCELED     | 취소            |

### 계좌 상태 코드 (AS)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| AS          | 001          | ACTIVE       | 활성화           |
| AS          | 002          | INACTIVE     | 비활성화          |
| AS          | 003          | DORMANT      | 휴면            |
| AS          | 004          | FROZEN       | 법적동결          |
| AS          | 005          | CLOSED       | 해지            |

### 권역 코드 (RG)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| RG          | 001          | CAPITAL      | 수도권           |
| RG          | 002          | CENTRAL      | 충청권           |
| RG          | 003          | HONAM        | 호남권           |
| RG          | 004          | YEONGNAM     | 영남권           |
| RG          | 005          | GANGWON      | 강원권           |
| RG          | 006          | JEJU         | 제주권           |
| RG          | 007          | OTHER        | 기타/해외         |

### 거래 상태 코드 (TX)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| TX          | 001          | GENERATED    | 생성            |
| TX          | 002          | BILLED       | 발행            |
| TX          | 003          | ONGOING      | 진행 중          |
| TX          | 004          | PAID         | 납부 완료         |
| TX          | 005          | REFUND       | 환불            |
| TX          | 006          | CLOSED       | 종료            |
| TX          | 007          | OVERDUE      | 연체 중          |

### 은행 코드 (BK)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| BK          | 001          | FARM         | 은행팜           |
| BK          | 002          | SHINHAN      | 신한은행          |
| BK          | 003          | KOOKMIN      | 국민은행          |
| BK          | 004          | WOORI        | 우리은행          |
| BK          | 005          | HANA         | 하나은행          |
| BK          | 006          | NONGHYUP     | 농협은행          |
| BK          | 007          | IBK          | 기업은행          |
| BK          | 008          | SC           | SC 제일은행       |
| BK          | 009          | KDB          | 산업은행          |
| BK          | 010          | SUHYUP       | 수협은행          |
| BK          | 011          | KAKAO        | 카카오뱅크         |
| BK          | 012          | K_BANK       | 케이뱅크          |
| BK          | 013          | TOSS         | 토스뱅크          |
| BK          | 014          | POST         | 우체국은행         |
| BK          | 015          | JEJU         | 제주은행          |
| BK          | 016          | GWANGJU      | 광주은행          |
| BK          | 017          | DAEGU        | 대구은행          |
| BK          | 018          | BUSAN        | 부산은행          |
| BK          | 019          | KYUNGNAM     | 경남은행          |
| BK          | 020          | JEONBUK      | 전북은행          |

## 카테고리별 공통 코드

### 고객 (CU - Customer)

#### 고객 등급 (001~010)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| CU          | 001          | BASIC        | 일반            |
| CU          | 002          | SILVER       | 실버            |
| CU          | 003          | GOLD         | 골드            |
| CU          | 004          | VIP          | 명예            |
#### 고객 유형 (011~015)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| CU          | 011          | PERSONAL     | 개인            |
| CU          | 012          | BUSINESS     | 개인 사업자        |
| CU          | 013          | CORPORATE    | 법인 사업자        |

### 카드 (CD - Card)

#### 옵션 코드 (001~010)
| super_cd_id | common_cd_id | common_cd_nm        | common_cd_des |
| ----------- | ------------ | ------------------- | ------------- |
| CD          | 001          | TRANSPORTATION CARD | 교통카드          |
| CD          | 002          | CASHBACK            | 캐시백           |
| CD          | 003          | POINT               | 포인트           |
| CD          | 004          | OVERSEAS            | 해외 결제         |
#### 카드 상태 (011~015)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| CD          | 006          | ACTIVE       | 정상            |
| CD          | 007          | SUSPENDED    | 거래정지          |
| CD          | 008          | LOST         | 분실            |
| CD          | 009          | CANCELLED    | 해지            |
| CD          | 010          | EXPIRED      | 만료            |
#### 회차 상태 (016~025)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| CD          | 016          | SCHEDULED    | 예정            |
| CD          | 017          | BILLED       | 청구 완료         |
| CD          | 018          | PAID         | 납부 완료         |
| CD          | 019          | OVERDUE      | 연체            |
| CD          | 020          | REFUNDED     | 환불            |
#### 청구 상태 (026~035)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| CD          | 026          | GENERATED    | 생성            |
| CD          | 027          | BILLED       | 발행            |
| CD          | 028          | PAID         | 완납            |
| CD          | 029          | OVERDUE      | 연체            |
| CD          | 030          | CLOSED       | 종료            |

### 계좌 (AC - Account)

#### 계좌 타입 (001~005)
| super_cd_id | common_cd_id | common_cd_nm  | common_cd_des |
| ----------- | ------------ | ------------- | ------------- |
| AC          | 001          | BOTH          | 제한 없음         |
| AC          | 002          | DEPOSIT_ONLY  | 입금 전용         |
| AC          | 003          | WITHDRAW_ONLY | 출금 전용         |

### 지점 (BR - Branch)

#### 영업 상태 (001~005)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| BR          | 001          | OPEN         | 영업중           |
| BR          | 002          | CLOSED       | 영업종료          |
| BR          | 003          | SUSPENDED    | 휴점            |

### 상품 (PD - Product)

#### 서류 타입 (001~005)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| PD          | 001          | PAPER        | 지류            |
| PD          | 002          | ELECTRONIC   | 디지털           |
#### 상품 타입 (006~010)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| PD          | 006          | DEPOSIT      | 예적금           |
| PD          | 007          | LOAN         | 대출            |
| PD          | 008          | CARD         | 카드            |
| PD          | 009          | INSURANCE    | 보험            |

### 연체 (OD - Overdue)

#### 연체 주체 (001~005)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| OD          | 001          | LOAN         | 대출            |
| OD          | 002          | CARD         | 카드            |
| OD          | 003          | INSURANCE    | 보험            |

### 보험 (IN - Insurance)

#### 해지/만기 유형 (001~005)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| IN          | 001          | TERMINATED   | 해지            |
| IN          | 002          | EXPIRED      | 만기            |

#### 보험 타입 (006~030)
| super_cd_id | common_cd_id | common_cd_nm     | common_cd_des |
| ----------- | ------------ | ---------------- | ------------- |
| IN          | 006          | WHOLE_LIFE       | 종신보험          |
| IN          | 007          | TERM_LIFE        | 정기보험          |
| IN          | 008          | ENDOWMENT        | 저축성/만기환급형 보험  |
| IN          | 009          | UNIVERSAL        | 유니버셜보험        |
| IN          | 010          | VARIABLE_LIFE    | 변액보험          |
| IN          | 011          | ANNUITY          | 연금보험          |
| IN          | 012          | ANNUITY_VARIABLE | 변액연금보험        |
| IN          | 013          | HEALTH           | 건강보험          |
| IN          | 014          | CANCER           | 암보험           |
| IN          | 015          | CRITICAL_ILLNESS | 중대질병(CI)보험    |
| IN          | 016          | MEDICAL          | 의료실비보험        |
| IN          | 017          | ACCIDENT         | 상해보험          |
| IN          | 018          | DRIVER           | 운전자보험         |
| IN          | 019          | TRAVEL           | 여행자보험         |
| IN          | 020          | FIRE             | 화재보험          |
| IN          | 021          | HOME             | 주택/가재도구보험     |
| IN          | 022          | AUTO             | 자동차보험         |
| IN          | 023          | PET              | 반려동물보험        |
| IN          | 024          | LIABILITY        | 배상책임보험        |
| IN          | 025          | GROUP            | 단체보험          |

### 대출 (LN - Loan)

#### 상환 방식 (001~010)
| super_cd_id | common_cd_id | common_cd_nm      | common_cd_des |
| ----------- | ------------ | ----------------- | ------------- |
| LN          | 001          | EQUAL_INSTALLMENT | 원리금 균등 상환     |
| LN          | 002          | EQUAL_PRINCIPAL   | 원금 균등 상환      |
| LN          | 003          | LUMP_SUM          | 만기 일시 상환      |
| LN          | 004          | GRACE             | 거치식 상환        |
| LN          | 005          | MIXED             | 혼합 상환         |
| LN          | 006          | REVOLVING         | 자유 상환         |
| LN          | 007          | STEP_UP           | 체중식 상환        |
| LN          | 008          | STEP_DOWN         | 체감식 상환        |

### 금리 (RT - Rate)

#### 금리 타입 (001~005)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| RT          | 001          | DISCOUNT     | 우대금리          |
| RT          | 002          | ADDITIONAL   | 가산금리          |
#### 금리 적용 상품 (006~010)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| RT          | 006          | DEPOSIT      | 예/적금          |
| RT          | 007          | LOAN         | 대출            |

### 외환 (FX - Foreign Exchange)

#### 거래 타입 (001~005)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| FX          | 001          | EXCHANGE     | 환전            |
| FX          | 002          | RE_EXCHANGE  | 재환전           |
| FX          | 003          | TRANSFER     | 이체            |
| FX          | 004          | PURCHASE     | 매입            |
#### 거래 목적 (006~020)
| super_cd_id | common_cd_id | common_cd_nm             | common_cd_des |
| ----------- | ------------ | ------------------------ | ------------- |
| FX          | 006          | TUITION_EXPENSES         | 유학 경비         |
| FX          | 007          | LIVING_EXPENSES          | 해외 체재비        |
| FX          | 008          | TRAVEL_EXPENSES          | 여행 경비         |
| FX          | 009          | GIFT/DONATION_REMITTANCE | 증여 송금         |
| FX          | 010          | TRADE_SETTLEMENT         | 무역거래          |
| FX          | 011          | OVERSEAS_DIRECT_INV      | 해외 직접 투자      |
| FX          | 012          | REAL_ESTATE_ACQ          | 부동산 취득        |
| FX          | 013          | OVERSEAS_DEPOSIT         | 해외 예금         |

### 예/적금 (DO - Deposit)

#### 상품 타입 (001~015)
| super_cd_id | common_cd_id | common_cd_nm   | common_cd_des |
| ----------- | ------------ | -------------- | ------------- |
| DO          | 001          | DEMAND_DEPOSIT | 요구불 예금        |
| DO          | 002          | TIME_DEPOSIT   | 정기 예금         |
| DO          | 003          | FIXED_SAVING   | 정기 적금         |
| DO          | 004          | FREE_SAVING    | 자유 적금         |
#### 이자 계산 단위 (016~020)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| DO          | 016          | DAY          | 일             |
| DO          | 017          | MONTH        | 월             |
| DO          | 018          | YEAR         | 년             |
#### 이자 지급 주기 (021~025)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| DO          | 021          | MATURITY     | 만기 지급         |
| DO          | 022          | YEARLY       | 년 지급          |
| DO          | 023          | MONTHLY      | 월 지급          |
#### 이자 계산 방식 (026~030)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| DO          | 026          | SIMPLE       | 단리            |
| DO          | 027          | COMPOUND     | 복리            |

### 상담 (CO - Counseling)

#### 상담 타입 (001~020)
| super_cd_id | common_cd_id | common_cd_nm     | common_cd_des |
| ----------- | ------------ | ---------------- | ------------- |
| CO          | 001          | LOAN             | 대출 상담         |
| CO          | 002          | DEPOSIT          | 예적금 상담        |
| CO          | 003          | CARD             | 카드 상담         |
| CO          | 004          | INSURANCE        | 보험 상담         |
| CO          | 005          | FX               | 환전/외환 상담      |
| CO          | 006          | ACCOUNT          | 계좌 상담         |
| CO          | 007          | INTERNET_BANKING | 인터넷/모바일뱅킹 상담  |
| CO          | 008          | FEE              | 수수료/요금 상담     |
| CO          | 009          | COMPLAINT        | 민원/불만 상담      |
| CO          | 010          | GENERAL          | 일반 상담         |
| CO          | 011          | SECURITY         | 보안/사기 예방 상담   |
| CO          | 012          | LOST             | 분실/재발급 상담     |

### 제휴 (PA - Partner)

#### 제휴사 타입 (001~015)
| super_cd_id | common_cd_id | common_cd_nm | common_cd_des |
| ----------- | ------------ | ------------ | ------------- |
| PA          | 001          | MERCHANT     | 일반 가맹점        |
| PA          | 002          | FRANCHISE    | 프랜차이즈 제휴처     |
| PA          | 003          | INSURANCE    | 보험사 제휴처       |
| PA          | 004          | FINANCIAL    | 금융기관 제휴사      |
| PA          | 005          | SERVICE      | 서비스업 제휴사      |
| PA          | 006          | TRANSPORT    | 교통/모빌리티 제휴사   |
| PA          | 007          | RETAIL       | 유통/마트/백화점 제휴사 |
| PA          | 008          | FOOD         | 음식/카페 제휴사     |
| PA          | 009          | ETC          | 기타 제휴처        |
