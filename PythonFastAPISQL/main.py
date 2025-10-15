import datetime

from fastapi import FastAPI, Depends

from models import information

from database import engine, SessionLocal

import database_models

from sqlalchemy.orm import Session

database_models.Base.metadata.create_all(bind = engine)

app = FastAPI()

employees = []

p1 = information(id = 8, firstname = "Panagiotis", lastname = "Chronopoulos", age = 28, sex = "M", datebirth = datetime.datetime.strptime("1997-03-27", "%Y-%m-%d"), jobstatus = False, levelofeducation = "6", salary = 0.0)
p1.set_salary(p1.get_net_salary())
p2 = information(id = 9, firstname = "Nikos", lastname = "Stergiou", age = 30, sex = "M", datebirth = datetime.datetime.strptime("1995-03-27", "%Y-%m-%d"), jobstatus = True, levelofeducation = "8", salary = 2500.0)
p2.set_salary(p2.get_net_salary())
p3 = information(id = 10, firstname = "Giwrgos", lastname = "Gewrgiou", age = 50, sex = "M", datebirth = datetime.datetime.strptime("1975-02-20", "%Y-%m-%d"), jobstatus = True, levelofeducation = "8", salary = 6500.0)
p3.set_salary(p3.get_net_salary())
p4 = information(id = 11, firstname = "UnKnownFirstName", lastname = "UnKnownLastName", age = 80, sex = "M", datebirth = datetime.datetime.strptime("1945-01-01", "%Y-%m-%d"), jobstatus = False, levelofeducation = "N/A", salary = 0.0)
p4.set_salary(p4.get_net_salary())

employees.append(p1)
employees.append(p2)
employees.append(p3)
employees.append(p4)

@app.get("/")
async def panos_api():
    return "Welcome to PanosAPI!"

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def add_employees_to_db():
    db = SessionLocal()
    count = db.query(database_models.information).count()
    if count == 7:
        for employee in employees:
            db.add(database_models.information(**employee.model_dump()))
        db.commit()
        db.close()
    else:
        print("\nTable is not empty!\n")
        db.close()

add_employees_to_db()

@app.get("/api/employees")
async def get_all_employees(db: Session = Depends(get_db)):
    db_employees = db.query(database_models.information).all()
    #print("\n" + str(db_employees) + "\n")
    return db_employees

@app.get("/api/employees/{employeeid}")
async def get_employee_by_id(employeeid : str, db: Session = Depends(get_db)):
    if not employeeid.isdigit() or (employeeid.isdigit() and int(employeeid) <= 0):
        return "You need to enter a valid and positive number!"
    else:
        db_employee = db.query(database_models.information).filter(database_models.information.id == int(employeeid)).first()
        if(db_employee):
            #print("\n" + str(db_employee) + "\n")
            return db_employee
        else:
            return "Employee not found with id : " + employeeid

@app.post("/api/employees")
async def add_employee(employee: information, db: Session = Depends(get_db)):
    db.add(database_models.information(**employee.model_dump()))
    db.commit()
    #print("\nEmployee added successfully!\n")
    #print("\n" + str(employee) + "\n")
    return employee, " added successfully!"

@app.put("/api/employees")
async def update_employee(employeeid: str, employee: information, db: Session = Depends(get_db)):
    if not employeeid.isdigit() or (employeeid.isdigit() and int(employeeid) <= 0):
        return "You need to enter a valid and positive number!"
    else:
        db_employee = db.query(database_models.information).filter(database_models.information.id == int(employeeid)).first()
        if(db_employee):
            db_employee.firstname = employee.firstname
            db_employee.lastname = employee.lastname
            db_employee.age = employee.age
            db_employee.sex = employee.sex
            db_employee.datebirth = employee.datebirth
            db_employee.jobstatus = employee.jobstatus
            db_employee.leveofeducation = employee.levelofeducation
            db_employee.salary = employee.salary
            #print("\n" + str(db_employee) + "\n")
            db.commit()
            return "Employee updated successfully!"
        else:
            return "No employee found with id : " + employeeid

@app.delete("/api/employees/{employeeid}")
async def delete_employee(employeeid : str, db: Session = Depends(get_db)):
    if not employeeid.isdigit() or (employeeid.isdigit() and int(employeeid) <= 0):
        return "You need to enter a valid and positive number!"
    else:
        db_employee = db.query(database_models.information).filter(database_models.information.id == int(employeeid)).first()
        if(db_employee):
            db.delete(db_employee)
            db.commit()
            #print("\nDeleted row - > " + str(db_employee) + "\n")
            return "Employee deleted successfully!"
        else:
            return "Employee not found with id : " + employeeid
