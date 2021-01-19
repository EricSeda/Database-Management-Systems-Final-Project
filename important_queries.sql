--Who has outstanding invoices as of 12/5/2020?
select first_name, last_name, phone_number, email_address, payment_due_date, description_of_service, amount_due
from animalhospital.owner
inner join animalhospital.invoice
using (owner_id)
inner join animalhospital.service_amount
using (description_of_service)
where payment_received = false and payment_due_date < '2020-12-05';

--Total invoice amount paid in April 2020?
select sum(amount_due) as total_invoice_April
from animalhospital.invoice
inner join animalhospital.service_amount
using (description_of_service)
where payment_due_date between '2020-04-01' and '2020-04-30';

--What is the most expensive medication?
select medication_id, medication_name, type, cost
from animalhospital.medication
group by medication_id, medication_name, type, cost
order by cost desc
limit 1;

--How often was the most expensive medicine prescribed after an examination?
select count(medication_id)
from animalhospital.examination_treatment_medication
where medication_id = '6';

--Who was prescribed Parasiticide?
select type, animal_name, gender, breed
from animalhospital.medication
inner join animalhospital.examination_treatment_medication
using (medication_id)
inner join animalhospital.examination_treatment
using (examination_treatment_id)
inner join animalhospital.invoice
using (invoice_id)
inner join animalhospital.animal
using (owner_id)
where type = 'Parasiticide';

--Who were the animals that had emergencies in 2020 so far?
select animal_name, gender, breed
from animalhospital.visit
inner join animalhospital.animal
using (animal_id)
where is_emergency = true;

--What upcoming appointments do Dr.Marks have for the month of December 2020?
select vet_name, visit_date, visit_time
from animalhospital.visit
where vet_name = 'Dr. Marks' and visit_date between '2020-12-01'and '2020-12-31';