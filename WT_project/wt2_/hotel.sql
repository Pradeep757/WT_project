drop database prameet;
create database prameet;
\c prameet;


drop table hotel;
drop table room;
drop table cost;
drop table customer;
drop table reservation;
drop table facilities;
drop table location;

create table location(
	pincode numeric(6) primary key,
	street varchar(50),
	city varchar(20)
	);



create table hotel(
	hotel_id varchar(10),
	name varchar(25),
	ratings numeric(2,1) check (ratings < 5 and ratings > 0),
	pincode numeric(6),
	foreign key(pincode)references location on delete cascade on update cascade,
	primary key (hotel_id)
	);


create table room(
	hotel_id varchar(10),
	roomno varchar(10), 
	roomtype varchar(20), 
	roomstatus varchar(20),
	foreign key(hotel_id)references hotel on delete cascade on update cascade,
	primary key(roomno,hotel_id));


create table customer(
	cust_id varchar(10),
	name varchar(25),
	roomno varchar(10),
	phno numeric(10),
	hotel_id varchar(10),
	foreign key (hotel_id) references hotel on delete cascade on update cascade,
	primary key(hotel_id,cust_id,roomno)
	);


create table reservation(
	hotel_id varchar(10),
	roomno varchar(10),
	payment_id varchar(15),
	reservation_id varchar(15),
	cust_id varchar(10),
	reservation_type varchar(20),
	start_date date,
	end_date date,
	foreign key(hotel_id,cust_id,roomno) references customer on delete cascade on update cascade,
	foreign key(roomno,hotel_id) references room on delete cascade on update cascade,
	primary key(payment_id)
	);

create table facilities(
	hotel_id varchar(10),
	fname varchar(30),
	foreign key (hotel_id)references hotel on delete cascade on update cascade,
	primary key (hotel_id,fname));

create table cost(
	payment_id varchar(15),
	reservation_id varchar(15),
	amt int,
	foreign key(payment_id) references reservation on delete cascade on update cascade,
	primary key(payment_id,reservation_id) 
	);


delete from location;
delete from hotel;
delete from room;
delete from customer;
delete from reservation;
delete from cost;
delete from facilities;


insert into location values ('560080','bsk','Bangalore');
insert into location values ('560085','jpnagar','Bangalore');
insert into location values ('560070','kmpnagar','Mysore');
insert into location values ('560060','keshwapur','Hubli');
insert into location values ('560090','keshavnagar','Belagaum');
insert into location values ('560084','jayanagar','Bangalore');
insert into location values ('560050','navnagar','Bagalkot');


/*select * from location where city like 'Bangalore%';*/


insert into hotel values ('H1000','Pride Hotel','4.1','560080');
insert into hotel values ('H1001','Chalukya Hotel','4.9','560080');
insert into hotel values ('H1002','Ashok Hotel','4.7','560080');
insert into hotel values ('H1003','Capitol Hotel','3.9','560085');
insert into hotel values ('H1004','Gateway Hotel','2.3','560085');
insert into hotel values ('H1005','Ramesh Hotel','4.4','560084');
insert into hotel values ('H1006','Royal orchid','3.6','560084');
insert into hotel values ('H1007','Aishwarya Residency','3.9','560070');
insert into hotel values ('H1008','Ajanta Hotel','3.4','560070');
insert into hotel values ('H1009','Darshan Residency','4.2','560070');
insert into hotel values ('H1010','President Hotel','4.5','560060');
insert into hotel values ('H1011','Metropolis Hotel','4.3','560060');
insert into hotel values ('H1012','Ananth Residency','3.9','560060');
insert into hotel values ('H1013','Prameet Residency','4.9','560060');
insert into hotel values ('H1014','Adarsha Hotel','1.3','560090');
insert into hotel values ('H1015','Sankam Residency','1.3','560090');
insert into hotel values ('H1016','Hanuman Hotel','4.6','560050');
insert into hotel values ('H1017','Ramdev Hotel','3.3','560050');



--select name,street,city from hotel,location where hotel.pincode=location.pincode;

insert into room values('H1000','AC-1-1','AC','Available');
insert into room values('H1000','AC-2-1','AC','Not Available');
insert into room values('H1000','R-1-1','Regular','Available');
insert into room values('H1000','R-2-1','Regular','Available');
insert into room values('H1001','AC-1-1','AC','Available');
insert into room values('H1001','AC-1-2','AC','Not Available');
insert into room values('H1001','AC-2-1','AC','Not Available');
insert into room values('H1001','AC-2-2','AC','Not Available');
insert into room values('H1001','R-1-1','Regular','Available');
insert into room values('H1001','R-2-1','Regular','Available');
insert into room values('H1002','AC-1-1','AC','Not Available');
insert into room values('H1002','AC-2-1','AC','Not Available');
insert into room values('H1002','AC-2-2','AC','Available');
insert into room values('H1002','R-1-1','Regular','Available');
insert into room values('H1002','R-2-1','Regular','Available');
insert into room values('H1003','AC-1-1','AC','Available');
insert into room values('H1003','AC-2-1','AC','Not Available');
insert into room values('H1003','AC-2-2','AC','Not Available');
insert into room values('H1003','R-1-1','Regular','Not Available');
insert into room values('H1003','R-2-1','Regular','Available');
insert into room values('H1004','AC-1-1','AC','Not Available');
insert into room values('H1004','R-2-1','Regular','Not Available');
insert into room values('H1005','AC-1-1','AC','Available');
insert into room values('H1005','R-2-1','Regular','Not Available');
insert into room values('H1006','AC-1-1','AC','Not Available');
insert into room values('H1006','R-2-1','Regular','Available');
insert into room values('H1007','AC-1-1','AC','Not Available');
insert into room values('H1007','R-2-1','Regular','Not Available');
insert into room values('H1007','AC-1-2','AC','Available');
insert into room values('H1008','AC-1-1','AC','Not Available');
insert into room values('H1008','R-2-1','Regular','Available');
insert into room values('H1008','AC-1-2','AC','Available');
insert into room values('H1008','R-2-2','Regular','Not Available');
insert into room values('H1009','AC-1-1','AC','Available');
insert into room values('H1009','R-2-1','Regular','Available');
insert into room values('H1010','AC-1-1','AC','Available');
insert into room values('H1010','AC-2-1','AC','Not Available');
insert into room values('H1010','R-1-1','Regular','Not Available');
insert into room values('H1010','R-2-1','Regular','Available');
insert into room values('H1011','AC-1-1','AC','Available');
insert into room values('H1011','AC-1-2','AC','Not Available');
insert into room values('H1011','R-2-1','Regular','Available');
insert into room values('H1011','R-2-2','Regular','Available');
insert into room values('H1012','AC-1-1','AC','Available');
insert into room values('H1012','AC-1-2','AC','Not Available');
insert into room values('H1013','AC-1-1','AC','Available');
insert into room values('H1013','AC-1-2','AC','Not Available');
insert into room values('H1013','AC-1-3','AC','Not Available');
insert into room values('H1013','R-2-1','Regular','Not Available');
insert into room values('H1013','R-2-2','Regular','Available');
insert into room values('H1013','R-2-3','Regular','Not Available');
insert into room values('H1014','R-1-1','Regular','Available');
insert into room values('H1014','R-2-1','Regular','Available');
insert into room values('H1015','AC-1-1','AC','Available');
insert into room values('H1015','R-1-1','Regular','Not Available');
insert into room values('H1016','R-1-1','Regular','Available');
insert into room values('H1017','R-1-1','Regular','Available');
insert into room values('H1017','R-2-1','Regular','Not Available');
insert into room values('H1017','AC-2-1','AC','Available');

--select name,roomno,street,city from room,hotel,location where room.hotel_id=hotel.hotel_id and hotel.pincode=location.pincode and city='Bangalore' and roomstatus = 'Available';

insert into customer values('C0001','John','R-1-1','1234567890','H1000');
insert into customer values('C0002','Ram','AC-1-1','1234567891','H1000');
insert into customer values('C0003','Raj','R-1-1','1234567880','H1001');
insert into customer values('C0004','Mohan','AC-1-1','1234567881','H1001');
insert into customer values('C0005','Mohanlal','AC-2-2','1234567882','H1002');
insert into customer values('C0006','James','R-2-1','1234567883','H1002');
insert into customer values('C0007','Bond','R-2-1','1234567884','H1003');
insert into customer values('C0008','Rock','R-1-1','1234567885','H1003');
insert into customer values('C0009','Cena','R-2-1','1234567886','H1004');
insert into customer values('C0010','Taylor','AC-1-1','1234567887','H1004');
insert into customer values('C0011','Manish','AC-1-1','1234567888','H1005');
insert into customer values('C0012','Mahantesh','R-2-1','1234567889','H1005');
insert into customer values('C0013','Paris','AC-1-1','1234567870','H1006');
insert into customer values('C0014','Mark','R-2-1','1234567871','H1007');
insert into customer values('C0015','Darshan','R-2-1','1234567872','H1008');
insert into customer values('C0016','Sudeep','AC-1-1','1234567873','H1008');
insert into customer values('C0017','johnny','R-2-2','1234567874','H1008');
insert into customer values('C0018','Robert','AC-1-1','1234567875','H1009');
insert into customer values('C0019','Mathew','R-1-1','1234567876','H1010');
insert into customer values('C0020','Adam','R-2-1','1234567877','H1011');
insert into customer values('C0021','Ravi','AC-1-1','1234567878','H1012');
insert into customer values('C0022','Ramesh','R-2-1','1234567879','H1013');
insert into customer values('C0023','Gary','AC-1-1','1234567860','H1013');
insert into customer values('C0024','Sham','AC-1-2','1234567861','H1013');
insert into customer values('C0025','Kumar','R-2-1','1234567862','H1014');
insert into customer values('C0026','Mery','AC-1-1','1234567863','H1015');
insert into customer values('C0027','Dj','R-1-1','1234567864','H1016');
insert into customer values('C0028','Manju','AC-2-1','1234567865','H1017');

--select * from customer;


insert into reservation values('H1000','R-1-1','P0001','R0001','C0001','Online','01-04-2018','02-04-2018');
insert into reservation values('H1000','AC-1-1','P0002','R0002','C0002','Offline','01-04-2018','02-04-2018');
insert into reservation values('H1001','R-1-1','P0003','R0003','C0003','Online','01-04-2018','03-04-2018');
insert into reservation values('H1001','AC-1-1','P0004','R0004','C0004','Online','01-04-2018','03-04-2018');
insert into reservation values('H1002','AC-2-2','P0005','R0005','C0005','Offline','01-04-2018','02-04-2018');
insert into reservation values('H1002','R-2-1','P0006','R0006','C0006','Online','01-04-2018','03-04-2018');
insert into reservation values('H1003','R-2-1','P0007','R0007','C0007','Offline','01-04-2018','02-04-2018');
insert into reservation values('H1003','R-1-1','P0008','R0008','C0008','Online','01-04-2018','02-04-2018');
insert into reservation values('H1004','R-2-1','P0009','R0009','C0009','Online','01-04-2018','02-04-2018');
insert into reservation values('H1004','AC-1-1','P0010','R0010','C0010','Online','01-04-2018','02-04-2018');
insert into reservation values('H1005','AC-1-1','P0011','R0011','C0011','Offline','01-04-2018','04-04-2018');
insert into reservation values('H1005','R-2-1','P0012','R0012','C0012','Online','01-04-2018','02-04-2018');
insert into reservation values('H1006','AC-1-1','P0013','R0013','C0013','Online','01-04-2018','02-04-2018');
insert into reservation values('H1007','R-2-1','P0014','R0014','C0014','Online','01-04-2018','02-04-2018');
insert into reservation values('H1008','R-2-1','P0015','R0015','C0015','Online','01-04-2018','02-04-2018');
insert into reservation values('H1008','AC-1-1','P0016','R0016','C0016','Offline','01-04-2018','02-04-2018');
insert into reservation values('H1008','R-2-2','P0017','R0017','C0017','Online','01-04-2018','02-04-2018');
insert into reservation values('H1009','AC-1-1','P0018','R0018','C0018','Offline','01-04-2018','02-04-2018');
insert into reservation values('H1010','R-1-1','P0019','R0019','C0019','Offline','01-04-2018','02-04-2018');
insert into reservation values('H1011','R-2-1','P0020','R0020','C0020','Online','01-04-2018','02-04-2018');
insert into reservation values('H1012','AC-1-1','P0021','R0021','C0021','Online','01-04-2018','04-04-2018');
insert into reservation values('H1013','R-2-1','P0022','R0022','C0022','Online','01-04-2018','02-04-2018');
insert into reservation values('H1013','AC-1-1','P0023','R0023','C0023','Online','01-04-2018','03-04-2018');
insert into reservation values('H1013','AC-1-2','P0024','R0024','C0024','Online','01-04-2018','03-04-2018');
insert into reservation values('H1014','R-2-1','P0025','R0025','C0025','Online','01-04-2018','02-04-2018');
insert into reservation values('H1015','AC-1-1','P0026','R0026','C0026','Offline','01-04-2018','02-04-2018');
insert into reservation values('H1016','R-1-1','P0027','R0027','C0027','Offline','01-04-2018','02-04-2018');
insert into reservation values('H1017','AC-2-1','P0028','R0028','C0028','Online','01-04-2018','02-04-2018');



/*select distinct name,room.roomno,street from reservation,room,location,hotel where room.hotel_id=hotel.hotel_id and hotel.pincode=location.pincode and hotel.hotel_id=reservation.hotel_id 
and city='Bangalore' and end_date<current_date;*/
--select * from reservation;

/*delete from customer where cust_id='C0001';
delete from room where roomno='R-1-1';
select * from customer where roomno='R-1-1';
select * from customer where cust_id='C0003';*/

insert into facilities values('H1000','AC');
insert into facilities values('H1000','WiFi');
insert into facilities values('H1000','TV');
insert into facilities values('H1001','AC');
insert into facilities values('H1001','WiFi');
insert into facilities values('H1001','TV');
insert into facilities values('H1002','AC');
insert into facilities values('H1002','WiFi');
insert into facilities values('H1002','TV');
insert into facilities values('H1003','AC');
insert into facilities values('H1003','WiFi');
insert into facilities values('H1003','TV');
insert into facilities values('H1004','AC');
insert into facilities values('H1004','WiFi');
insert into facilities values('H1004','TV');
insert into facilities values('H1005','AC');
insert into facilities values('H1005','WiFi');
insert into facilities values('H1005','TV');
insert into facilities values('H1006','AC');
insert into facilities values('H1006','WiFi');
insert into facilities values('H1006','TV');
insert into facilities values('H1007','AC');
insert into facilities values('H1007','WiFi');
insert into facilities values('H1007','TV');
insert into facilities values('H1008','AC');
insert into facilities values('H1008','WiFi');
insert into facilities values('H1008','TV');
insert into facilities values('H1009','AC');
insert into facilities values('H1009','WiFi');
insert into facilities values('H1009','TV');
insert into facilities values('H1010','AC');
insert into facilities values('H1010','WiFi');
insert into facilities values('H1010','TV');
insert into facilities values('H1011','AC');
insert into facilities values('H1011','WiFi');
insert into facilities values('H1011','TV');
insert into facilities values('H1012','AC');
insert into facilities values('H1012','WiFi');
insert into facilities values('H1012','TV');
insert into facilities values('H1013','AC');
insert into facilities values('H1013','WiFi');
insert into facilities values('H1013','TV');
insert into facilities values('H1014','WiFi');
insert into facilities values('H1015','AC');
insert into facilities values('H1015','WiFi');
insert into facilities values('H1015','TV');
insert into facilities values('H1016','WiFi');
insert into facilities values('H1017','AC');
insert into facilities values('H1017','WiFi');
insert into facilities values('H1017','TV');

--select facilities.fname from hotel join facilities on hotel.hotel_id=facilities.hotel_id where hotel.name = 'Prameet Residency';

insert into cost values('P0001','R0001',500);
insert into cost values('P0002','R0002',1000);
insert into cost values('P0003','R0003',800);
insert into cost values('P0004','R0004',1800);
insert into cost values('P0005','R0005',1000);
insert into cost values('P0006','R0006',600);
insert into cost values('P0007','R0007',400);
insert into cost values('P0008','R0008',400);
insert into cost values('P0009','R0009',700);
insert into cost values('P0010','R0010',1200);
insert into cost values('P0011','R0011',1500);
insert into cost values('P0012','R0012',300);
insert into cost values('P0013','R0013',800);
insert into cost values('P0014','R0014',400);
insert into cost values('P0015','R0015',500);
insert into cost values('P0016','R0016',1000);
insert into cost values('P0017','R0017',500);
insert into cost values('P0018','R0018',800);
insert into cost values('P0019','R0019',500);
insert into cost values('P0020','R0020',200);
insert into cost values('P0021','R0021',1500);
insert into cost values('P0022','R0022',600);
insert into cost values('P0023','R0023',1600);
insert into cost values('P0024','R0024',1600);
insert into cost values('P0025','R0025',400);
insert into cost values('P0026','R0026',600);
insert into cost values('P0027','R0027',500);
insert into cost values('P0028','R0028',800);

--Queries
/*1.To see all hotels in our database
 select name,street,city from hotel,location where hotel.pincode=location.pincode;

 2.To search for hotels in given city
 select name,street from hotel,location where hotel.pincode=location.pincode and city='Bangalore';
 
 3.To view all hotels with ratings more than 4
 select name,street from hotel,location where hotel.pincode=location.pincode and city='Bangalore' and ratings > 4.0;

 4.To see rooms list in a particular hotel
 select roomno,roomtype from room as r,hotel as h where h.hotel_id=r.hotel_id and name = 'The pride Hotel';

 5.To see number of AC rooms in a given hotel
 select count(roomno) from room as r,hotel as h where h.hotel_id=r.hotel_id and name = 'The pride Hotel' and roomtype='AC';

 6.To view hotels with atleast one empty room in a given city
 select distinct name,room.roomno,street from reservation,room,location,hotel where room.hotel_id=hotel.hotel_id and hotel.pincode=location.pincode and hotel.hotel_id=reservation.hotel_id 
 and city='Mysore' and end_date<current_date union select distinct name,room.roomno,street from reservation,room,location,hotel where room.hotel_id=hotel.hotel_id and hotel.pincode=location.pincode and hotel.hotel_id=reservation.hotel_id 
 and city='Mysore' and roomstatus='Available';*/

