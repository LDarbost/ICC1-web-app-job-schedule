import os

class Config:
    # Secret key for Flask sessions and CSRF protection
    # IMPORTANT: In a production environment, this should be a strong, randomly generated string
    # and ideally loaded from an environment variable or a secure secret management system.
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'you-will-never-guess-this-secret-key-for-development'

    # Database configuration
    # This environment variable will determine which database is used.
    # Examples:
    # 1. SQLite (monolith): SQLALCHEMY_DATABASE_URI='sqlite:///site.db'
    # 2. PostgreSQL: SQLALCHEMY_DATABASE_URI='postgresql://user:password@host:port/database_name'
    # 3. Azure Cosmos DB (PostgreSQL API): SQLALCHEMY_DATABASE_URI='postgresql://user:password@host:port/database_name'
    #    (Note: The connection string for Cosmos DB's PostgreSQL API will look like a standard PostgreSQL string)

    # For Cloud SQL, the connection string will be provided by the environment variable
    DB_USER = os.environ.get('DB_USER')
    DB_PASS = os.environ.get('DB_PASS')
    DB_HOST = os.environ.get('DB_HOST')
    DB_NAME = os.environ.get('DB_NAME')
    
    if all([DB_USER, DB_PASS, DB_HOST, DB_NAME]):
        SQLALCHEMY_DATABASE_URI = f'postgresql://{DB_USER}:{DB_PASS}@{DB_HOST}:5432/{DB_NAME}'
    
    # Disable SQLAlchemy event system to save memory, as we don't need it for this simple app
    SQLALCHEMY_TRACK_MODIFICATIONS = False

   