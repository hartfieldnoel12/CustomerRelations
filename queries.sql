
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    a.attendance_date,
    a.clock_in,
    a.clock_out,
    a.attendance_status
FROM Employees AS e
INNER JOIN Attendance_Records AS a
    ON e.employee_id = a.employee_id
ORDER BY a.attendance_date DESC;
