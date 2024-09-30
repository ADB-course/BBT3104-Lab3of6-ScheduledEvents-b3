-- CREATE EVN_average_customer_waiting_time_every_1_hour
CREATE TABLE customer_service_kpi (
customer_service_KPI_timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
customer_service_KPI_average_waiting_time_minutes INT NOT NULL,
PRIMARY KEY (customer_service_KPI_timestamp));

CREATE EVENT EVN_average_customer_waiting_time_every_1_hour
ON 
SCHEDULE EVERY 1 HOUR
STARTS CURRENT_TIMESTAMP
ON COMPLETION PRESERVE
COMMENT 'This event computes the total time a customer has waited since they raised a ticket'
DO
   INSERT INTO customer_service_kpi (customer_service_KPI_average_waiting_time_minutes)
    SELECT AVG(TIMESTAMPDIFF(MINUTE, start_time, end_time))
    FROM customer_service_ticket
    WHERE end_time > NOW() - INTERVAL 1 HOUR;
