create schema animalhospital;

--Table Definitions--
create table animalhospital.owner (
owner_id      serial primary key,
first_name    varchar(50) not null,
last_name     varchar(50) not null,
phone_number  varchar(12) not null,
email_address varchar(50) not null
);


create table animalhospital.breed_species (
breed		  varchar primary key,	
species           varchar not null
);

create table animalhospital.animal (
animal_id     serial primary key,
animal_name   varchar(50),
gender        varchar(6) not null,	       
color         varchar,
age           varchar not null,
weight        decimal(5,2) not null,
note          text,
owner_id      integer not null references animalhospital.owner(owner_id),
breed        varchar not null references animalhospital.breed_species(breed)
);

create table animalhospital.service_amount (
description_of_service	varchar primary key,
amount_due 		decimal(7,2)
);

create table animalhospital.invoice (
invoice_id		serial primary key,
invoice_date		date,
payment_due_date  	date,
payment_received	boolean,
owner_id		integer not null references animalhospital.owner(owner_id),
description_of_service		varchar references animalhospital.service_amount(description_of_service)
);

create table animalhospital.visit (
visit_id		serial primary key,
visit_date		date,
visit_time		time,
reason_for_visit	text not null,
vet_name		varchar(50),
is_emergency		boolean,
animal_id		integer not null references animalhospital.animal(animal_id)
);


create table animalhospital.examination_treatment (
examination_treatment_id 	serial primary key,
description   			text,
results       			text not null,	       
procedure_performed  		text not null,
invoice_id      		integer not null references animalhospital.invoice(invoice_id),
visit_id			integer not null references animalhospital.visit(visit_id)
);


create table animalhospital.medication (
medication_id     	serial primary key,
medication_name   	varchar(50) not null,
type		  	varchar(50) not null,
cost  			decimal(7,2) not null,
dosage 			varchar(10) not null

);

create table animalhospital.examination_treatment_medication (
examination_treatment_id 	int not null,
medication_id 			int not null,
primary key (examination_treatment_id, medication_id),
foreign key (examination_treatment_id) references animalhospital.examination_treatment (examination_treatment_id),
foreign key (medication_id) references animalhospital.medication (medication_id)
);



--Insert Values into Tables--

insert into animalhospital.owner 
  (first_name, last_name, phone_number, email_address)
values
  ('Elenor', 'Shellstrop', '555-203-2492', 'eshellstrop@gmail.com'),
  ('Chidi', 'Anagonye', '555-123-4567', 'canagonye@gmail.com'),
  ('Tahani', 'Al-Jamil', '555-789-0123', 'taljamil@gmail.com'),
  ('Jason', 'Mendoza', '555-456-7890', 'jmendoza@gmail.com'),
  ('Micheal', 'Arch', '555-098-5674', 'march@gmail.com'),
  ('Janet', 'Good', '555-786-0384', 'goodjanet@gmail.com'),
  ('Doug', 'Forcett', '555-758-2983', 'dforcett@gmail.com'),
  ('Mindy', 'St.Claire', '555-483-0493', 'mstclaire@gmail.com'),
  ('Simone', 'Garnett', '555-892-0093', 'sgarnett@gmail.com'),
  ('Chris', 'Baker', '555-902-4820', 'cbaker@gmail.com');

insert into animalhospital.breed_species
  (breed, species)
values
  ('golden retriever', 'dog'),
  ('bulldog', 'dog'),
  ('german shepherd', 'dog'),
  ('poodle', 'dog'),
  ('siberian husky', 'dog'),
  ('persian', 'cat'),
  ('maine coon', 'cat'),
  ('bengal', 'cat'),
  ('british shorthair', 'cat'),
  ('ragdoll', 'cat');

insert into animalhospital.animal
  (animal_name, gender, color, age, weight, note, owner_id, breed)
values
  ('Max', 'male', 'blonde', '2 years', '70.63', 'mother had cancer', '1', 'golden retriever'), 
  ('Potato', 'male', 'brown', '1 year', '60.40', 'weight above average', '2', 'bulldog'),
  ('Luna', 'female', 'brown/black', '3 months', '25', '', '3', 'german shepherd'),
  ('Lola', 'female', 'white', '9 years', '50.00', 'eyesight has increasingly gotten worse', '4','poodle'),
  ('Milo', 'male', 'black/white', '5 months','43.5', '', '5', 'siberian husky'),
  ('Bella', 'female', 'brown', '18 months', '10.99', 'prone to upper respiratory infections', '6', 'maine coon'),
  ('Jasper', 'male', 'black', '8 months', '13.03', 'Allergic to Drug YX', '7', 'bengal'),
  ('Simba', 'male', 'brown/black', '2 years', '14.50', '', '8', 'ragdoll'),
  ('Leo', 'male', '', '4 years', '17.40', 'had a tumor removed from kidney', '9', 'british shorthair'),
  ('Lily', 'female', '', '1 year', '8.00', '', '10', 'bengal');

insert into animalhospital.service_amount
  (description_of_service, amount_due)
values
  ('check-up', 49.95),
  ('cast', 149.99),
  ('x-ray', 199.99),
  ('mri', 199.99),
  ('surgery', 200.89);

insert into animalhospital.invoice
  (invoice_date, payment_due_date, payment_received, owner_id, description_of_service)
values
  ('2020-01-15', '2020-02-15', 'TRUE', '1', 'check-up'),
  ('2020-01-20', '2020-02-20', 'FALSE', '2', 'mri'),
  ('2020-02-10', '2020-03-10', 'TRUE', '5', 'x-ray'),
  ('2020-03-11', '2020-04-11', 'FALSE', '3', 'cast'),
  ('2020-03-12', '2020-04-12', 'TRUE', '1', 'check-up'),
  ('2020-11-15', '2020-12-15', 'FALSE', '2', 'surgery'),
  ('2020-11-16', '2020-12-16', 'FALSE', '1', 'cast');

insert into animalhospital.visit
  (visit_date, visit_time, reason_for_visit, vet_name, is_emergency, animal_id)
values
  ('2020-12-15', '11:15:00', 'yearly check-up', 'Dr. Marks', 'FALSE', '1'),
  ('2020-01-20', '10:15:00', 'yearly check-up', 'Dr. Smith', 'FALSE', '2'),
  ('2020-12-10', '11:00:00', 'yearly check-up', 'Dr. Marks', 'FALSE', '5'),
  ('2020-03-11', '10:00:00', 'yearly check-up', 'Dr. Smith', 'FALSE', '3'),
  ('2020-03-12', '11:30:00', 'hurt leg in accident', 'Dr. Smith', 'TRUE', '1'),
  ('2020-01-15', '11:45:00', 'animal hit it’s head', 'Dr. Marks', 'TRUE', '2'),
  ('2020-01-15', '10:30:00', 'appointment for cast', 'Dr. Smith', 'FALSE', '1');

insert into animalhospital.medication
  (medication_name, type, cost, dosage)
values
  ('Cephalexin', 'Antibiotic', 150.00, '50 mg'),
  ('Firocoxib', 'Anti-Inflammatory', 69.99, '15 mg'),
  ('Oxycodone', 'Pain Reliever', 104.59, '35 mg'),
  ('Prednisone', 'Steriod', 205.77, '100 mg'),
  ('Diazepam', 'Sedative', 164.00, '75 mg'),
  ('Rafoxanide', 'Parasiticide', 354.65, '250 mg'),
  ('Cisplatin', 'Hormone', 76.00, '20 mg'),
  ('Doxorubicin', 'Chemorgerapeutic', 287.70, '200 mg'),
  ('Marbofloxacin', 'Antibiotic', 25.90, '5 mg'),
  ('Buprenorphine', 'Narcotic', 125.00, '30 mg');

insert into animalhospital.examination_treatment
  (description, results, procedure_performed, invoice_id, visit_id)
values
  ('', 'animal has been responding well to medication', 'regular check-up', '1', '3'),
  ('Owner says animal has been down for the past three weeks', 'found three ticks, will prescribe medicine', 'removed ticks', '6', '4'),
  ('mri to check for tumor', 'tumor found', 'mri performed', '2', '2'),
  ('animal broke left leg through extraneous exercise', 'will place cast for 5 weeks', 'cast placed on left leg', '4', '5'),
  ('animal has been throwing up','parasite in stomach', 'no procedure performed', '5', '4');

insert into animalhospital.examination_treatment_medication
  (examination_treatment_id, medication_id)
values
  ('1', '7'),
  ('2', '6'),
  ('3', '8'),
  ('4', '3'),
  ('5', '6');


