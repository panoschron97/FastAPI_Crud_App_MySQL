import datetime

from sqlalchemy import Column, Integer, String, Float, DateTime, Boolean
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class information(Base):

    __tablename__ = "information"

    id = Column(Integer, primary_key=True, index = True)
    firstname = Column(String)
    lastname = Column(String)
    age = Column(Integer)
    sex = Column(String)
    datebirth = Column(DateTime)
    jobstatus = Column(Boolean)
    levelofeducation = Column(String)
    salary = Column(Float)

