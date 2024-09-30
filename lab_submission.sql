-- CREATE EVN_average_customer_waiting_time_every_1_hour
CREATE EVENT EVN_average_customer_waiting_time_every_1_hour
ON 
SCHEDULE EVERY 1 HOUR
STARTS CURRENT_TIMESTAMP
ON COMPLETION PRESERVE
COMMENT 'This event computes the total time a customer has waited since they raised a ticket'
DO
  UPDATE customer_service_ticket
  SET 
    customer_service_total_wait_time_minutes = TIMESTAMPDIFF(MINUTE, customer_service_ticket_raise_time, CURRENT_TIMESTAMP),
    customer_service_ticket_last_update = CONCAT('The last 1-hour recurring update was made at ', CURRENT_TIMESTAMP)
  WHERE 
    customer_service_ticket_resolved = 0;