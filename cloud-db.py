from neo4j import GraphDatabase
import os
from dotenv import load_dotenv

load_dotenv()

uri = os.getenv('AURA_URI')
user = os.getenv('AURA_USER')
password = os.getenv('AURA_PASSWORD')

# URI examples: "neo4j://localhost", "neo4j+s://xxx.databases.neo4j.io"
URI = uri
AUTH = (user, password)

with GraphDatabase.driver(URI, auth=AUTH) as driver:
    driver.verify_connectivity()