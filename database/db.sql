-- 테이블 생성
CREATE TABLE task (
    _id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    date TEXT NOT NULL,
    isCompleted BOOLEAN NOT NULL DEFAULT false,
    isImportant BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    userId TEXT NOT NULL
);

-- 데이터 추가
INSERT INTO task (_id, title, description, date, isCompleted, isImportant, userId) VALUES ('1234', '할일1', '할일1 설명', '2021-08-01', false, false, 'marshall');

-- 데이터 조회
SELECT * FROM task WHERE userId = 'marshall' ORDER BY created_at DESC(ASC);

-- 특정 사용자 데이터 필터 조회
SELECT * FROM task WHERE userId = 'marshallhch'

-- 데이터 삭제
DELETE FROM task WHERE _id = '1234';

-- 데이터 업데이트
UPDATE task SET iscompleted = true WHERE _id = '1235';


-- 트리거 함수 생성: updated_at 필드를 현재 시간으로 설정
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- 트리거 생성: task 테이블에서 UPDATE가 발생할 때마다 update_updated_at_column 함수를 호출
CREATE TRIGGER update_task_updated_at
BEFORE UPDATE ON task
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();


-- task 테이블의 created_at 필드는 행이 처음 삽입될 때만 설정.
-- updated_at 필드는 행이 업데이트될 때마다 트리거를 통해 현재 시간으로 자동 갱신.
-- BEFORE UPDATE 트리거는 레코드가 업데이트되기 직전에 updated_at 필드를 현재 시간으로 변경.



