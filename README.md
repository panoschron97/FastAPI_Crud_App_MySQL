# Python FastAPI crud app with MySQL

This repository demonstrates a basic CRUD (Create, Read, Update, Delete) application built using FastAPI and MySQL enhanced with LLM (Language Model) context for improved understanding and interaction. It provides a foundation for building more complex applications with a structured and maintainable codebase.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)

## Features

*   **FastAPI Framework**: Utilizes FastAPI for building the API leveraging its automatic data validation and interactive API documentation.
*   **MySQL Database**: Integrates with a MySQL database to store and manage data.
*   **CRUD Operations**: Implements standard CRUD operations for managing information.
*   **Data Models**: Defines Pydantic models for data validation and serialization.
*   **SQLAlchemy ORM**: Uses SQLAlchemy for interacting with the MySQL database.
*   **LLM Context**: Demonstrates how to integrate LLM context for understanding code and generating documentation.

## Installation

1.  Clone the repository:

    ```bash
    git clone https://github.com/panoschron97/FastAPI_Crud_App_MySQL.git
    cd FastAPI_Crud_App_MySQL
    ```

2.  Create a virtual environment (recommended):

    ```bash
    python3 -m venv venv
    source venv/bin/activate  # On Linux/macOS
    venv\Scripts\activate  # On Windows
    ```

3.  Install the dependencies:

    ```bash
    pip install -r requirements.txt
    ```

## Usage

1.  Set up your MySQL database. Ensure that you have MySQL installed and running. Create a database named `application`.

2.  Configure the database connection: Modify the `database.py` file to reflect your MySQL credentials:

    ```python
    db_url = "mysql://<username>:<password>@<host>:<port>/<database_name>"
    ```

3.  Run the FastAPI application:

    ```bash
    uvicorn main:app --reload
    ```

    This command starts the FastAPI server, enabling hot reloading for development.

4.  Access the interactive API documentation at `http://localhost:8000/docs` or `http://localhost:8000/redoc` to test the API endpoints.

## Dependencies

*   **FastAPI**: A modern, fast (high-performance), web framework for building APIs.
*   **SQLAlchemy**: A SQL toolkit and Object-Relational Mapping (ORM) library.
*   **MySQL Connector**: A driver to connect Python applications to MySQL databases.
*   **Pydantic**: A data validation and settings management library.
*   **Uvicorn**: An ASGI (Asynchronous Server Gateway Interface) server for running FastAPI applications.
*   **Python-dotenv**: Reads key-value pairs from a `.env` file and can set them as environment variables.
