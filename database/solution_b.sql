-- b. Truy vấn đơn hàng
-- 1. Liệt kê các hóa đơn của khách hàng, thông tin hiển thị gồm: mã user, tên user, mã hóa đơn
SELECT 
    u.user_id, 
    u.user_name, 
    o.order_id 
FROM users u 
INNER JOIN orders o ON u.user_id = o.user_id;
-- 2. Liệt kê số lượng các hóa đơn của khách hàng: mã user, tên user, số đơn hàng
SELECT 
    u.user_id,
    u.user_name,
    COUNT(o.order_id) AS order_count
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name;
-- 3. Liệt kê thông tin hóa đơn: mã đơn hàng, số sản phẩm
SELECT 
    order_id, 
    COUNT(product_id) AS so_san_pham 
FROM order_details 
GROUP BY order_id;
-- 4. Liệt kê thông tin mua hàng của người dùng: mã user, tên user, mã đơn hàng, tênsảnphẩm. Lưu ý: gôm nhóm theo đơn hàng, tránh hiển thị xen kẻ các đơn hàng với nhau
SELECT 
    u.user_id, 
    u.user_name, 
    o.order_id, 
    p.product_name
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id
ORDER BY o.order_id;
-- 5. Liệt kê 7 người dùng có số lượng đơn hàng nhiều nhất, thông tin hiển thị gồm: mãuser, tên user, số lượng đơn hàng.
SELECT 
    u.user_id, 
    u.user_name, 
    COUNT(o.order_id) AS order_count
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name
ORDER BY order_count DESC
LIMIT 7;
-- 6. Liệt kê 7 người dùng mua sản phẩm có tên: Samsung hoặc Apple trongtênsảnphẩm, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tên sản phẩm
SELECT 
    u.user_id, 
    TRIM(REPLACE(u.user_name, '\n', '')) AS user_name, 
    o.order_id, 
    p.product_name
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id
WHERE p.product_name LIKE '%Samsung%' OR p.product_name LIKE '%Apple%'
ORDER BY o.order_id
LIMIT 7;
-- 7. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền
SELECT 
    u.user_id, 
    TRIM(REPLACE(u.user_name, '\n', '')) AS user_name, 
    o.order_id, 
    SUM(p.product_price) AS tong_tien
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id
GROUP BY u.user_id, TRIM(REPLACE(u.user_name, '\n', '')), o.order_id;
-- 8. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thôngtinhiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền. Mỗi user chỉ chọnra1đơnhàng có giá tiền lớn nhất. 
SELECT 
    user_id, 
    user_name, 
    order_id, 
    MAX(tong_tien) AS tong_tien_lon_nhat
FROM (
    SELECT 
        u.user_id, 
        TRIM(REPLACE(u.user_name, '\n', '')) AS user_name, 
        o.order_id, 
        SUM(p.product_price) AS tong_tien
    FROM users u
    INNER JOIN orders o ON u.user_id = o.user_id
    INNER JOIN order_details od ON o.order_id = od.order_id
    INNER JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) AS temp_table
GROUP BY user_id, user_name;
-- 9. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thôngtinhiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền, số sản phẩm. Mỗi userchỉchọn ra 1 đơn hàng có giá tiền nhỏ nhất. 
SELECT 
    user_id, 
    user_name, 
    order_id, 
    MIN(tong_tien) AS tong_tien_nho_nhat, 
    so_san_pham
FROM (
    SELECT 
        u.user_id, 
        TRIM(REPLACE(u.user_name, '\n', '')) AS user_name, 
        o.order_id, 
        SUM(p.product_price) AS tong_tien,
        COUNT(od.product_id) AS so_san_pham
    FROM users u
    INNER JOIN orders o ON u.user_id = o.user_id
    INNER JOIN order_details od ON o.order_id = od.order_id
    INNER JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) AS temp_table
GROUP BY user_id, user_name;
-- 10. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thôngtinhiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền, số sản phẩm. Mỗi userchỉchọn ra 1 đơn hàng có số sản phẩm là nhiều nhất
SELECT 
    user_id, 
    user_name, 
    order_id, 
    tong_tien, 
    MAX(so_san_pham) AS so_san_pham_nhieu_nhat
FROM (
    SELECT 
        u.user_id, 
        TRIM(REPLACE(u.user_name, '\n', '')) AS user_name, 
        o.order_id, 
        SUM(p.product_price) AS tong_tien,
        COUNT(od.product_id) AS so_san_pham
    FROM users u
    INNER JOIN orders o ON u.user_id = o.user_id
    INNER JOIN order_details od ON o.order_id = od.order_id
    INNER JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) AS temp_table
GROUP BY user_id, user_name;