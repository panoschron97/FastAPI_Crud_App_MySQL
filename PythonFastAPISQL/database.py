from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

db_url = "mysql://root:27031997@localhost:3306/application"
engine = create_engine(db_url)
SessionLocal = sessionmaker(autocommit = False, autoflush = False, bind = engine)
