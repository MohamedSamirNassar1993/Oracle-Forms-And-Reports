CREATE TABLE users (
  User_id number(10) NOT NULL,
  User_Name varchar2(50) NOT NULL,
  User_Password varchar2(50) NOT NULL,
  User_StartDate date DEFAULT NULL,
  User_EndDate date DEFAULT NULL,
  User_Active char(1) DEFAULT 'N',
  USER_ADMIN char(1) DEFAULT 'N'
) ;

create unique index User_Name_idex on users(User_Name);

ALTER TABLE users
  ADD PRIMARY KEY (User_id);

create sequence User_seq start with 1 increment by 1 nocache nocycle;

--------------------------------------------------------------------
CREATE TABLE Mhkma (
  Mhkma_Id number(10) NOT NULL,
  Mhkma_Name varchar2(50) NOT NULL,
  Mhkma_Address varchar2(50) DEFAULT NULL
) ;

create unique index Mhkma_id_pk on Mhkma(Mhkma_id);

ALTER TABLE Mhkma
  ADD (constraint Mhkma_id_pk PRIMARY KEY (Mhkma_id));

create sequence Mhkma_seq start with 1 increment by 1 nocache nocycle;

--------------------------------------------------------

CREATE TABLE Kadiatype (
  Kadiatype_Id number(10) NOT NULL,
  Kadiatype_Name varchar2(50) NOT NULL
) ;

create unique index Kadiatype_Id_pk on Kadiatype(Kadiatype_Id);

ALTER TABLE Kadiatype
  ADD (constraint Kadiatype_Id_pk PRIMARY KEY (Kadiatype_Id));

create sequence Kadiatype_seq start with 1 increment by 1 nocache nocycle;
------------------------------------------------------------------
CREATE TABLE office(
  office_Name varchar2(50) NOT NULL,
  office_email varchar2(50) NOT NULL
) ;
--------------------------------------------------------------------

CREATE TABLE Mokel (
  Mokel_Id number(10) NOT NULL,
  Mokel_Name varchar2(50) NOT NULL,
  Mokel_idnumber number(10) DEFAULT NULL,
  Mokel_phone number(30) DEFAULT NULL,
  Mokel_address varchar2(255) DEFAULT NULL,
  Mokel_email varchar2(50) DEFAULT NULL,
  Mokel_deon number(10) DEFAULT 0,
  Mokel_StartDate date DEFAULT NULL,
  Mokel_notes varchar2(255) DEFAULT NULL
) ;

create unique index Mokel_Id_pk on Mokel(Mokel_Id);

ALTER TABLE Mokel
  ADD (constraint Mokel_Id_pk PRIMARY KEY (Mokel_Id));

create sequence Mokel_seq start with 1 increment by 1 nocache nocycle;
--------------------------------------------------------------------
CREATE TABLE Kadia (
  Kadia_Id number(10) NOT NULL,
  Kadia_number varchar2(50) DEFAULT NULL,
  Kadia_mokelid number(10) NOT NULL,
  Kadia_mokeltype varchar2(50) DEFAULT NULL,
  Kadia_Khesm varchar2(255) NOT NULL,
  Kadia_KhesmAddress varchar2(255) DEFAULT NULL,
  Kadia_type number(10) NOT NULL,
  Kadia_SDate date NOT NULL,
  Kadia_brice number(10) DEFAULT 0,
  Kadia_notes varchar2(255) DEFAULT NULL,
  Kadia_details varchar2(255) DEFAULT NULL,
  Kadia_mhkmaid varchar2(255) DEFAULT NULL,
  Kadia_userid number(10) NOT NULL,
  Kadia_Hokm varchar2(255) DEFAULT NULL
);
create unique index Kadia_Id_pk on Kadia(Kadia_Id);

ALTER TABLE Kadia
  ADD (constraint Kadia_Id_pk PRIMARY KEY (Kadia_Id)
  , constraint Kadia_mokel_fk FOREIGN KEY (Kadia_mokelid) REFERENCES mokel(Mokel_Id) on delete cascade
  , constraint Kadia_type_fk FOREIGN KEY (Kadia_type) REFERENCES Kadiatype(Kadiatype_Id) on delete cascade
  , constraint Kadia_user_fk FOREIGN KEY (Kadia_userid) REFERENCES users(user_Id) on delete cascade
);

create sequence Kadia_seq start with 1 increment by 1 nocache nocycle;
------------------------------------------------------------------------------
CREATE TABLE galsa (
  galsa_Id number(10) NOT NULL,
  galsa_date date NOT NULL,
  galsa_cause varchar2(255) DEFAULT NULL,
  galsa_requiredpaper varchar2(255) DEFAULT NULL,
  galsa_Kadiaid number(10) NOT NULL,
  Kadia_notes varchar2(255) DEFAULT NULL
);

create unique index galsa_Id_pk on galsa(galsa_Id);

ALTER TABLE galsa
  ADD (constraint galsa_Id_pk PRIMARY KEY (galsa_Id)
  , constraint galsa_Kadia_fk FOREIGN KEY (galsa_Kadiaid) REFERENCES Kadia(Kadia_Id) on delete cascade
);

create sequence galsa_seq start with 1 increment by 1 nocache nocycle;
------------------------------------------------------------------------------
CREATE TABLE payment (
  payment_Id number(10) NOT NULL,
  payment_Date date NOT NULL,
  payment_mokelid number(10) NOT NULL,
  payment_value number(10) NOT NULL,
  payment_userid number(10) NOT NULL
);

create unique index payment_Id_pk on payment(payment_Id);

ALTER TABLE payment
  ADD (constraint payment_Id_pk PRIMARY KEY (payment_Id)
  , constraint payment_mokel_fk FOREIGN KEY (payment_mokelid) REFERENCES mokel(Mokel_Id) on delete cascade
  , constraint payment_user_fk FOREIGN KEY (payment_userid) REFERENCES users(user_Id) on delete cascade
);

create sequence payment_seq start with 1 increment by 1 nocache nocycle;
------------------------------------------------------------------------------
CREATE TABLE morfk (
  morfk_Id number(10) NOT NULL,
  morfk_kadiaid number(10) NOT NULL,
  morfk_file blob,
  morfk_name varchar2(255) DEFAULT NULL
);

create unique index morfk_Id_pk on morfk(morfk_Id);

ALTER TABLE morfk
  ADD (constraint morfk_Id_pk PRIMARY KEY (morfk_Id)
  , constraint morfk_Kadia_fk FOREIGN KEY (morfk_Kadiaid) REFERENCES kadia(kadia_Id) on delete cascade
);

create sequence morfk_seq start with 1 increment by 1 nocache nocycle;

create or replace directory UPLOAD_DB as 'C:\Law\UPLOAD_DB';
