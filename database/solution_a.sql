--  a. Truy vấn người dùng
-- 1. Lấy ra danh sách người dùng theo thứ tự tên theo Alphabet (A->Z)
SELECT * FROM users WHERE user_name REGEXP '^[a-zA-Z]' ORDER BY user_name ASC;
-- 2. Lấy ra 07 người dùng theo thứ tự tên theo Alphabet (A->Z)
SELECT * FROM users WHERE user_name REGEXP '^[a-zA-Z]' ORDER BY user_name ASC LIMIT 7;
-- 3. Lấy ra danh sách người dùng theo thứ tự tên theo Alphabet (A->Z), trong đótên người dùng có chữ a
SELECT * FROM users WHERE user_name REGEXP '^[a-zA-Z]' AND user_name LIKE '%a%' ORDER BY user_name ASC;
-- 4. Lấy ra danh sách người dùng trong đó tên người dùng bắt đầu bằng chữ m
SELECT * FROM users WHERE user_name REGEXP '^[a-zA-Z]' AND user_name LIKE 'm%' ORDER BY user_name ASC;
-- 5. Lấy ra danh sách người dùng trong đó tên người dùng kết thúc bằng chữ i
SELECT * FROM users WHERE user_name REGEXP '^[a-zA-Z]' AND user_name LIKE '%i' ORDER BY user_name ASC;
-- 6. Lấy ra danh sách người dùng trong đó email người dùng là Gmail (ví dụ:
-- example@gmail.com)
SELECT * FROM users WHERE user_email LIKE '%@gmail.com' AND REPLACE(user_name, '\n', '') REGEXP '^[a-zA-Z]' ORDER BY user_name ASC;
-- 7. Lấy ra danh sách người dùng trong đó email người dùng là Gmail (ví dụ: example@gmail.com), tên người dùng bắt đầu bằng chữ m
SELECT * FROM users WHERE user_email LIKE '%@gmail.com' AND REPLACE(user_name, '\n', '') LIKE 'm%' ORDER BY user_name ASC;
-- 8. Lấy ra danh sách người dùng trong đó email người dùng là Gmail (ví dụ: example@gmail.com), tên người dùng có chữ i và tên người dùng có chiềudài lớnhơn 5
SELECT * FROM users WHERE user_email LIKE '%@gmail.com' AND user_name LIKE '%i%' AND LENGTH(TRIM(REPLACE(user_name, '\n', ''))) > 5
ORDER BY user_name ASC;
-- 9. Lấy ra danh sách người dùng trong đó tên người dùng có chữ a, chiều dài từ5đến9,email dùng dịch vụ Gmail, trong tên email có chữ I (trong tên, chứkhôngphảidomain exampleitest@yahoo.com)
SELECT * FROM users WHERE user_name LIKE '%a%' AND LENGTH(TRIM(REPLACE(user_name, '\n', ''))) BETWEEN 5 AND 9 AND user_email LIKE '%i%@gmail.com'
ORDER BY user_name ASC;
-- 10. Lấy ra danh sách người dùng trong đó tên người dùng có chữ a, chiềudài từ5đến 9 hoặc tên người dùng có chữ i, chiều dài nhỏ hơn 9 hoặc email dùngdịchvụGmail, trong tên email có chữ i
SELECT * FROM users WHERE (user_name LIKE '%a%' AND LENGTH(TRIM(REPLACE(user_name, '\n', ''))) BETWEEN 5 AND 9) OR (user_name LIKE '%i%' AND LENGTH(TRIM(REPLACE(user_name, '\n', ''))) < 9) OR (user_email LIKE '%i%@gmail.com')