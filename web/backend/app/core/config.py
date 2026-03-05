from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    APP_NAME: str = "Clusterion API"
    ENVIRONMENT: str = "development"

    class Config:
        env_file = ".env"

settings = Settings()