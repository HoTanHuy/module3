-- cau 1: Thêm mới thông tin cho tất cả các bảng có trong CSDL để có thể thoả mãn các yêu cầu bên dưới.
use quanlyfurama;
-- Câu 2: Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.
select * 
from nhan_vien
where SUBSTRING_INDEX(ho_ten, ' ', - 1)
	REGEXP '^[HTK]'
	AND LENGTH(ho_ten) <= 15;
-- câu 3: Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
select * 
from khach_hang
where (year(now()) - year(ngay_sinh))between 18 and 50
		and (dia_chi like '%Quảng Trị' or dia_chi like '%Đà Nẵng' );
-- Câu 4: Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. 
-- Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng.
-- Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
SELECT 
    kh.ho_ten, COUNT(hd.ma_khach_hang) so_lan_dat
FROM
    khach_hang kh
        JOIN
    loai_khach lk ON lk.ma_loai_khach = kh.ma_loai_khach
        JOIN
    hop_dong hd ON hd.ma_khach_hang = kh.ma_khach_hang
WHERE
    lk.ten_loai_khach = 'Diamond'
GROUP BY hd.ma_khach_hang
ORDER BY so_lan_dat;
-- Câu 5: Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien 
-- (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) 
-- cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
 
 SELECT 
    tmp.ht, (tmp.g + tmp2.c) total
FROM
    (SELECT 
        kh.ho_ten ht,
            kh.ma_khach_hang mk,
            SUM(ct.so_luong * dk.gia) g
    FROM
        khach_hang kh
    LEFT JOIN hop_dong hd ON hd.ma_khach_hang = kh.ma_khach_hang
    LEFT JOIN dich_vu dv ON dv.ma_dich_vu = hd.ma_dich_vu
    LEFT JOIN hop_dong_chi_tiet ct ON ct.ma_hop_dong = hd.ma_hop_dong
    LEFT JOIN dich_vu_di_kem dk ON dk.ma_dich_vu_di_kem = ct.ma_dich_vu_di_kem
    GROUP BY kh.ma_khach_hang) tmp
        LEFT JOIN
    (SELECT 
        kh.ho_ten ht, kh.ma_khach_hang mk, SUM(dv.chi_phi_thue) c
    FROM
        khach_hang kh
    JOIN hop_dong hd ON hd.ma_khach_hang = kh.ma_khach_hang
    JOIN dich_vu dv ON dv.ma_dich_vu = hd.ma_dich_vu
    GROUP BY hd.ma_khach_hang) tmp2 ON tmp2.mk = tmp.mk;
 -- Câu 6: Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu 
 -- của tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).
 select*from loai_dich_vu;
 select*from dich_vu;
 select*from hop_dong;
 
 SELECT 
    dv.ma_dich_vu,
    dv.ten_dich_vu,
    dv.dien_tich,
    dv.chi_phi_thue,
    ldv.ten_loai_dich_vu
FROM
    dich_vu dv
        JOIN
    loai_dich_vu ldv ON ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu
WHERE
    NOT EXISTS( SELECT 
            *
        FROM
            hop_dong
        WHERE
            ma_dich_vu = dv.ma_dich_vu
                AND ngay_lam_hop_dong BETWEEN '2021-01-01' AND '2021-03-31');
 
 -- Câu 7:Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu
 -- của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.
 
 SELECT 
    dv.ma_dich_vu,
    dv.ten_dich_vu,
    dv.dien_tich,
    dv.so_nguoi_toi_da,
    dv.chi_phi_thue,
    ldv.ten_loai_dich_vu
FROM
    dich_vu dv
        JOIN
    loai_dich_vu ldv ON ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu
WHERE
    EXISTS( SELECT 
            *
        FROM
            hop_dong
        WHERE
            ma_dich_vu = dv.ma_dich_vu
                AND YEAR(ngay_lam_hop_dong) = '2020')
        AND NOT EXISTS( SELECT 
            *
        FROM
            hop_dong
        WHERE
            ma_dich_vu = dv.ma_dich_vu
                AND YEAR(ngay_lam_hop_dong) = '2021');

-- Câu8 .Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.

-- c1:
SELECT 
    kh.ho_ten
FROM
    khach_hang kh 
UNION SELECT 
    kh.ho_ten
FROM
    khach_hang kh;

-- c2:
SELECT 
    ho_ten
FROM
    khach_hang
GROUP BY ho_ten;

-- c3:

SELECT DISTINCT
    ho_ten
FROM
    khach_hang;

-- Câu9.Thực hiện thống kê doanh thu theo tháng, 
-- nghĩa là tương ứng với mỗi tháng trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
SELECT 
    MONTH(ngay_lam_hop_dong) AS thang, COUNT(ma_khach_hang)
FROM
    hop_dong
        JOIN
    khach_hang USING (ma_khach_hang)
WHERE
    YEAR(ngay_lam_hop_dong) = 2021
GROUP BY thang
ORDER BY thang;
--
SELECT
	tmp.thang,
	hd.so_luong_khach_hang
FROM (
	SELECT
		1 AS thang
	UNION
	SELECT
		2 AS thang
	UNION
	SELECT
		3 AS thang
	UNION
	SELECT
		4 AS thang
	UNION
	SELECT
		5 AS thang
	UNION
	SELECT
		6 AS thang
	UNION
	SELECT
		7 AS thang
	UNION
	SELECT
		8 AS thang
	UNION
	SELECT
		9 AS thang
	UNION
	SELECT
		10 AS thang
	UNION
	SELECT
		11 AS thang
	UNION
	SELECT
		12 AS thang) AS tmp
	LEFT JOIN (
		SELECT
			month(ngay_lam_hop_dong) AS thang ,
			count(ma_khach_hang) AS so_luong_khach_hang
		FROM
			hop_dong
		WHERE
			YEAR(ngay_lam_hop_dong) = '2021'
		GROUP BY
			thang) AS hd ON hd.thang = tmp.thang;

-- Câu10. Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. 
-- Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem 
-- (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).

SELECT 
    hd.ma_hop_dong,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    hd.tien_dat_coc,
    SUM(hdct.so_luong) so_luong_dich_vu_di_kem
FROM
    hop_dong hd
        LEFT JOIN
    hop_dong_chi_tiet hdct ON hdct.ma_hop_dong = hd.ma_hop_dong
GROUP BY hd.ma_hop_dong;

-- Câu11. Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có 
-- ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.

SELECT 
    kh.ho_ten,
    dvdk.ten_dich_vu_di_kem,
    dvdk.gia,
    dvdk.don_vi,
    dvdk.trang_thai
FROM
    dich_vu dv
        JOIN
    hop_dong hd ON hd.ma_dich_vu = dv.ma_dich_vu
        JOIN
    hop_dong_chi_tiet hdct ON hdct.ma_hop_dong = hd.ma_hop_dong
        JOIN
    dich_vu_di_kem dvdk ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
        JOIN
    khach_hang kh ON kh.ma_khach_hang = hd.ma_khach_hang
        JOIN
    loai_khach lk ON kh.ma_loai_khach = kh.ma_loai_khach
WHERE
    lk.ten_loai_khach = 'Diamond'
        AND ((kh.dia_chi LIKE '%Vinh')
        OR (kh.dia_chi LIKE '%Quảng Ngãi'));
		
-- Câu12. Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng),
-- so_dien_thoai (khách hàng), ten_dich_vu, 
-- so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), 
-- tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020 
-- nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.

SELECT 
    hd.ma_hop_dong,
    nv.ho_ten,
    kh.ho_ten,
    kh.so_dien_thoai,
    dv.ma_dich_vu,
    dv.ten_dich_vu,
    IFNULL(SUM(hdct.so_luong), 0) so_luong_dich_vu_di_kem,
    hd.tien_dat_coc
FROM
    dich_vu dv
        JOIN
    hop_dong hd ON hd.ma_dich_vu = dv.ma_dich_vu
        JOIN
    nhan_vien nv ON nv.ma_nhan_vien = hd.ma_nhan_vien
        JOIN
    khach_hang kh ON kh.ma_khach_hang = hd.ma_khach_hang
        LEFT JOIN
    hop_dong_chi_tiet hdct ON hdct.ma_hop_dong = hd.ma_hop_dong
WHERE
    (hd.ngay_lam_hop_dong BETWEEN '2020-10-01' AND '2020-12-31')
        AND (hd.ngay_lam_hop_dong NOT BETWEEN '2021-01-01' AND '2021-06-30')
GROUP BY hd.ma_hop_dong;
--    ------------------------

    
-- Câu13.	Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
-- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).


With count_used AS (
    SELECT
        ma_dich_vu_di_kem,
        ten_dich_vu_di_kem,
        sum(so_luong) tong_so_luong_dvdk
    FROM
        dich_vu_di_kem
        JOIN hop_dong_chi_tiet USING(ma_dich_vu_di_kem)
    GROUP by
        ma_dich_vu_di_kem
)
SELECT
    ma_dich_vu_di_kem,
    ten_dich_vu_di_kem,
    tong_so_luong_dvdk
FROM
    count_used
WHERE
    tong_so_luong_dvdk = (
        SELECT
            max(tong_so_luong_dvdk)
        FROM
            count_used
    );
-- --------
-- Câu14.	Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất.
-- Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem,
-- so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).

SELECT 
    hd.ma_hop_dong,
    ldv.ten_loai_dich_vu,
    dvdk.ten_dich_vu_di_kem,
    COUNT(hdct.ma_dich_vu_di_kem) so_lan_su_dung_dvdk
FROM
    dich_vu_di_kem dvdk
        JOIN
    hop_dong_chi_tiet hdct USING (ma_dich_vu_di_kem)
        JOIN
    hop_dong hd USING (ma_hop_dong)
        JOIN
    dich_vu dv USING (ma_dich_vu)
        JOIN
    loai_dich_vu ldv USING (ma_loai_dich_vu)
GROUP BY ma_dich_vu_di_kem
HAVING so_lan_su_dung_dvdk = 1;

-- Câu15.	Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, 
-- ten_trinh_do, ten_bo_phan, so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.

SELECT 
    nv.ma_nhan_vien,
    nv.ho_ten,
    td.ten_trinh_do,
    bp.ten_bo_phan,
    nv.so_dien_thoai,
    nv.dia_chi,
    COUNT(hd.ma_nhan_vien) so_luong_hop_dong
FROM
    nhan_vien nv
        JOIN
    trinh_do td USING (ma_trinh_do)
        JOIN
    bo_phan bp USING (ma_bo_phan)
        JOIN
    hop_dong hd USING (ma_nhan_vien)
WHERE
    YEAR(ngay_lam_hop_dong) BETWEEN 2020 AND 2021
GROUP BY nv.ma_nhan_vien
HAVING so_luong_hop_dong <= 3
ORDER BY nv.ma_nhan_vien;

-- Câu16.	Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.

DELETE FROM
    nhan_vien nv
WHERE
    NOT EXISTS (
        select
            *
        from
            hop_dong
        WHERE
            ma_nhan_vien = nv.ma_nhan_vien
            and YEAR(ngay_lam_hop_dong) BETWEEN 2019
            and 2021
    );

-- Câu17. Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond,
-- chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ.

update khach_hang
set ma_loai_khach = 1
where ma_khach_hang in (
select t.ma_khach_hang
from 
)





        

		




