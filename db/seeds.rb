# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Department.delete_all
Department.create!(
    name: 'Computer Science',
    total_budget: 1000,
    budget_hold: 0,
    manager_ssn: 123456789
    )

Department.create!(
    name: 'Math',
    total_budget: 1000,
    budget_hold: 0,
    manager_ssn: 223456789
    )
    
Department.create!(
    name: 'English',
    total_budget: 1000,
    budget_hold: 0,
    manager_ssn: 323456789
    )

Status.delete_all
Status.create!(
    name: 'Pending'
    )
Status.create!(
    name: 'Pending Final Approval'
    )
Status.create!(
    name: 'Partial Approved'
    )
Status.create!(
    name: 'Approved'
    )
Status.create!(
    name: 'Denied'
    )
    
ExpenseType.delete_all
ExpenseType.create!(
    name: 'Hotel'
    )

ExpenseType.create!(
    name: 'Transportation'
    )

ExpenseType.create!(
    name: 'Food'
    )

Request.delete_all
Wish.delete_all
Trip.delete_all

PaymentManager.delete_all
PaymentManager.create!(
    employee_ssn: 123456788
    )
    

#*********** Creating employee for each department ***********#
Employee.delete_all
Employee.create!(
    email: 'csemp@qq.com',
    password: '123123123',
    password_confirmation: '123123123',
    fname: 'cs',
    lname: 'employee',
    ssn: 111,
    department_id: Department.where(name: "Computer Science").take.id,
    bdate: '04/30/2019'
    )
Employee.create!(
    email: 'engemp@qq.com',
    password: '123123123',
    password_confirmation: '123123123',
    fname: 'eng',
    lname: 'employee',
    ssn: 222,
    department_id: Department.where(name: "English").take.id,
    bdate: '04/30/2019'
    )
Employee.create!(
    email: 'mathemp@qq.com',
    password: '123123123',
    password_confirmation: '123123123',
    fname: 'math',
    lname: 'employee',
    ssn: 333,
    department_id: Department.where(name: "Math").take.id,
    bdate: '04/30/2019'
    )

#*********** Creating managers for each department ***********#
Employee.create!(
    email: 'csmg@qq.com',
    password: '123123123',
    password_confirmation: '123123123',
    fname: 'cs',
    lname: 'manager',
    ssn: 123456789,
    department_id: Department.where(name: "Computer Science").take.id,
    bdate: '04/30/2019'
    )
Employee.create!(
    email: 'engmg@qq.com',
    password: '123123123',
    password_confirmation: '123123123',
    fname: 'eng',
    lname: 'manager',
    ssn: 323456789,
    department_id: Department.where(name: "English").take.id,
    bdate: '04/30/2019'
    )
Employee.create!(
    email: 'mathmg@qq.com',
    password: '123123123',
    password_confirmation: '123123123',
    fname: 'math',
    lname: 'employee',
    ssn: 223456789,
    department_id: Department.where(name: "Math").take.id,
    bdate: '04/30/2019'
    )
#*********** Creating payment manager ***********#
Employee.create!(
    email: 'paymentmg@qq.com',
    password: '123123123',
    password_confirmation: '123123123',
    fname: 'payment',
    lname: 'manager',
    ssn: 123456788,
    department_id: Department.where(name: "Computer Science").take.id,
    bdate: '04/30/2019'
    )

#*********** Creating trips for csemp ***********#
Trip.delete_all
Trip.create!(
    destination_attributes: 
        {
         country: "US",
         state: "Georgia",
         city: "Thomasville"
        },
    purpose:  'Going to have fun',
    date_start: '04/30/2019', 
    date_end: '04/31/2019', 
    employee_id: Employee.where(ssn: 111).take.id,
    requests_attributes: [
      { 
         department_id: Department.where(name: "Computer Science").take.id,
         amount: 300,
         status_id: Status.where(name: "Pending").take.id
       },
        { 
         department_id: Department.where(name: "English").take.id,
         amount: 300,
         status_id: Status.where(name: "Pending").take.id
       }
     ],

     
    authorization_form_attributes: 
      { 
         employee_id: Employee.where(ssn: 111).take.id,
         status_id: Status.where(name: "Pending").take.id,
         wishes_attributes: [
              { 
                 expense_type_id: ExpenseType.where(name: "Hotel").take.id,
                 cost: 300
               },
              { 
                 expense_type_id: ExpenseType.where(name: "Transportation").take.id,
                 cost: 300
               }
         ]
       }
    
)