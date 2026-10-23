

INSERT INTO Employees (
    first_name, last_name, email, department,
    job_title, hire_date
)
VALUES (
    'John', 'Smith', 'john.smith@example.com',
    'IT', 'IT Support Specialist', '2025-01-15'
);


INSERT INTO Attendance_Records (
    employee_id, attendance_date,
    clock_in, clock_out, attendance_status
)
VALUES (
    1, '2026-10-14', '08:00', '16:30', 'Present'
);


INSERT INTO Leave_Requests (
    employee_id, leave_type, start_date,
    end_date, reason
)
VALUES (
    1, 'Vacation', '2026-11-02',
    '2026-11-04', 'Personal vacation'
);
GO
