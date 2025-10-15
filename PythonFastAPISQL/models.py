import datetime

from pydantic import BaseModel

class information(BaseModel):
    id : int
    firstname : str
    lastname : str
    age : int
    sex : str
    datebirth : datetime.datetime
    jobstatus : bool
    levelofeducation : str
    salary : float
    #netsalary : float

    #def __init__(self, firstname = "UnKnownName", lastname = "UnKnownLastName", age = 0, sex = "N", datebirth = "1940-01-01"
    #             , jobstatus = False, levelofeducation = "N/A", salary = 0.0):
    #    self.firstname = firstname
    #    self.lastname = lastname
    #    self.age = age
    #    self.sex = sex
    #    self.datebirth = datebirth
    #    self.jobstatus = jobstatus
    #    self.levelofeducation = levelofeducation
    #    self.salary = salary

    def __str__(self):
        return (f"id : {self.id}, firstname : {self.firstname}, lastname : {self.lastname}, age : {self.age}"
                f", sex : {self.sex}, datebirth : {self.datebirth}, jobstatus : {self.jobstatus}"
                f", levelofeducation : {self.levelofeducation}, netsalary : {self.salary}")

    def set_firstname(self, firstname):
        self.firstname = firstname

    def set_lastname(self, lastname):
        self.lastname = lastname

    def set_age(self, age):
        self.age = age

    def set_sex(self, sex):
        self.sex = sex

    def set_datebirth(self, datebirth):
        self.datebirth = datebirth

    def set_jobstatus(self, jobstatus):
        self.jobstatus = jobstatus

    def set_levelofeducation(self, levelofeducation):
        self.levelofeducation = levelofeducation

    def set_salary(self, salary):
        self.salary = salary

    def get_salary(self):
        return self.salary

    def set_id(self, id):
        self.id = id

    def get_firstname(self):
        return self.firstname

    def get_lastname(self):
        return self.lastname

    def get_age(self):
        return self.age

    def get_sex(self):
        return self.sex

    def get_datebirth(self):
        return self.datebirth

    def get_jobstatus(self):
        return self.jobstatus

    def get_levelofeducation(self):
        return self.levelofeducation

    def get_id(self):
        return self.id

    def get_net_salary(self):
        netsalary = self.salary - (self.salary * 0.257)
        return netsalary








