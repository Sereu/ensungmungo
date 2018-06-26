
/* Drop Tables */

DROP TABLE book_order CASCADE CONSTRAINTS;
DROP TABLE cart CASCADE CONSTRAINTS;
DROP TABLE review CASCADE CONSTRAINTS;
DROP TABLE book CASCADE CONSTRAINTS;
DROP TABLE order_payment CASCADE CONSTRAINTS;
DROP TABLE shipping_address CASCADE CONSTRAINTS;
DROP TABLE customer_order CASCADE CONSTRAINTS;
DROP TABLE qna_ask CASCADE CONSTRAINTS;
DROP TABLE qna CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE grade CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE book
(
	book_no number(5,0) NOT NULL,
	book_title varchar2(100) NOT NULL,
	book_author varchar2(20) NOT NULL,
	book_publisher varchar2(20) NOT NULL,
	main_cartegory varchar2(20) NOT NULL,
	sub_category varchar2(20) NOT NULL,
	fixed_price number(7,0) NOT NULL,
	discount_rate number(2,0) NOT NULL,
	book_stock number(4,0) NOT NULL,
	publish_date date NOT NULL,
	book_image varchar2(100) NOT NULL,
	book_introduce varchar2(2000) NOT NULL,
	book_detail_image varchar2(200) NOT NULL,
	book_out_status char(1) DEFAULT '''N''' NOT NULL,
	PRIMARY KEY (book_no),
	constraint book_out_status_ck check(book_out_status in ('Y', 'N'))
);


CREATE TABLE book_order
(
	order_no number(5,0) NOT NULL,
	book_no number(5,0) NOT NULL,
	order_quantity number(3,0) DEFAULT 1 NOT NULL,
	order_status char(1) DEFAULT '''Y''' NOT NULL,
	constraint order_status_ck check(order_status in ('Y', 'N'))
);


CREATE TABLE cart
(
	book_no number(5,0) NOT NULL,
	customer_no number(5,0) NOT NULL,
	book_quantity number(3,0) DEFAULT 1 NOT NULL
);


CREATE TABLE customer
(
	customer_no number(5,0) NOT NULL,
	customer_id varchar2(20) NOT NULL,
	customer_pw varchar2(20) NOT NULL,
	customer_name varchar2(20) NOT NULL,
	customer_email varchar2(50) NOT NULL,
	gender char(1) NOT NULL,
	customer_tel varchar2(30) NOT NULL,
	customer_address varchar2(200),
	customer_birth date NOT NULL,
	customer_point number(7,0) DEFAULT 0 NOT NULL,
	customer_status char(1) DEFAULT '''Y''' NOT NULL,
	PRIMARY KEY (customer_no),
	constraint customer_gender_ck check(customer_gender in ('W', 'M')),
	constraint customer_status_ck check(customer_status in ('Y', 'N'))
);


CREATE TABLE customer_order
(
	order_no number(5,0) NOT NULL,
	customer_no number(5,0) NOT NULL,
	order_date date DEFAULT sysdate NOT NULL,
	PRIMARY KEY (order_no)
);


CREATE TABLE grade
(
	customer_grade char(1) NOT NULL,
	min_price number(7,0) NOT NULL,
	max_price number(7,0) NOT NULL,
	point_rate number(2,0) NOT NULL,
	grade_image varchar2(100) NOT NULL,
	PRIMARY KEY (customer_grade),
	constraint customer_grade_ck check(customer_grade in ('E', 'B','S','G'))
);


CREATE TABLE order_payment
(
	order_no number(5,0) NOT NULL,
	payment varchar2(10) NOT NULL
);


CREATE TABLE qna
(
	qna_no number(4,0) NOT NULL,
	customer_no number(5,0) NOT NULL,
	qna_title varchar2(100) NOT NULL,
	qna_contents varchar2(2000) NOT NULL,
	qna_date date DEFAULT sysdate NOT NULL,
	PRIMARY KEY (qna_no)
);


CREATE TABLE qna_ask
(
	qna_no number(4,0) NOT NULL,
	qna_ask_title varchar2(100) NOT NULL,
	qna_ask_contents varchar2(2000) NOT NULL,
	qna_ask_date date DEFAULT sysdate NOT NULL
);


CREATE TABLE review
(
	review_no number(4,0) NOT NULL,
	book_no number(5,0) NOT NULL,
	customer_no number(5,0) NOT NULL,
	review_star number(2,0) NOT NULL,
	review_date date DEFAULT sysdate NOT NULL,
	review_contents varchar2(1000) NOT NULL,
	PRIMARY KEY (review_no)
);


CREATE TABLE shipping_address
(
	order_no number(5,0) NOT NULL,
	recent_shipping_address varchar2(200) NOT NULL
);



/* Create Foreign Keys */

ALTER TABLE book_order
	ADD FOREIGN KEY (book_no)
	REFERENCES book (book_no)
;


ALTER TABLE cart
	ADD FOREIGN KEY (book_no)
	REFERENCES book (book_no)
;


ALTER TABLE review
	ADD FOREIGN KEY (book_no)
	REFERENCES book (book_no)
;


ALTER TABLE cart
	ADD FOREIGN KEY (customer_no)
	REFERENCES customer (customer_no)
;


ALTER TABLE customer_order
	ADD FOREIGN KEY (customer_no)
	REFERENCES customer (customer_no)
;


ALTER TABLE qna
	ADD FOREIGN KEY (customer_no)
	REFERENCES customer (customer_no)
;


ALTER TABLE review
	ADD FOREIGN KEY (customer_no)
	REFERENCES customer (customer_no)
;


ALTER TABLE book_order
	ADD FOREIGN KEY (order_no)
	REFERENCES customer_order (order_no)
;


ALTER TABLE order_payment
	ADD FOREIGN KEY (order_no)
	REFERENCES customer_order (order_no)
;


ALTER TABLE shipping_address
	ADD FOREIGN KEY (order_no)
	REFERENCES customer_order (order_no)
;


ALTER TABLE qna_ask
	ADD FOREIGN KEY (qna_no)
	REFERENCES qna (qna_no)
;



